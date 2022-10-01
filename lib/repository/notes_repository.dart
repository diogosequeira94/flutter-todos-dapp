import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_todos_dapp/models/note.dart';
import 'package:flutter_todos_dapp/repository/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web3dart/web3dart.dart';

/// Notes Repository
/// Responsible for CRUD operations and Error handling

class NotesRepository {
  late Web3Client web3client;
  late ContractAbi _contractAbiCode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _credentials;

  static final _instance = NotesRepository._internal();

  static NotesRepository get instance => _instance;

  factory NotesRepository() => _instance;

  NotesRepository._internal() {
    init();
  }

  static const notesContractPath = 'assets/contracts/NotesContract.json';

  //region initialization
  Future<void> init() async {
    web3client = Web3Client(
      Endpoints.apiUrl(),
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(Endpoints.wsUrl()).cast<String>();
      },
    );
    await _getABI();
    await _getAddress(_contractAbiCode);
    await _getCredentials();
    await getDeployedContract();
  }

  Future<void> _getABI() async {
    final abiFile = await rootBundle.loadString(notesContractPath);
    final jsonABI = jsonDecode(abiFile);
    _contractAbiCode =
        ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'NotesContract');
  }

  Future<void> _getAddress(ContractAbi contractAbi) async {
    final abiFile = await rootBundle.loadString(notesContractPath);
    final jsonABI = jsonDecode(abiFile);
    _contractAddress =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }

  Future<void> _getCredentials() async {
    _credentials = EthPrivateKey.fromHex(Endpoints.mockPrivateGanacheKey());
  }

  //endregion

  //region DeployedContract
  late DeployedContract _deployedContract;
  late ContractFunction _createNote;
  late ContractFunction _deleteNote;
  late ContractFunction _notes;
  late ContractFunction _noteCount;

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_contractAbiCode, _contractAddress);
    _createNote = _deployedContract.function('createNote');
    _deleteNote = _deployedContract.function('deleteNote');
    _notes = _deployedContract.function('notes');
    _noteCount = _deployedContract.function('noteCount');
  }
  //endregion

  Future<void> addNote(String title, String description) async {
    await web3client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _deployedContract,
        function: _createNote,
        parameters: [title, description],
      ),
    );
  }

  // Future<void> deleteNote(int id) async {
  //   await _notesWeb3ApiClient.web3client.sendTransaction(
  //     _notesWeb3ApiClient.getCredentials,
  //     Transaction.callContract(
  //       contract: _notesWeb3ApiClient.getNotesDeployedContract.deployedContract,
  //       function: _notesWeb3ApiClient.getNotesDeployedContract.deleteNote,
  //       parameters: [BigInt.from(id)],
  //     ),
  //   );
  // }

  Future<List<Note>> fetchNotes() async {
    List<Note> notes = [];
    final rawNotesList = await web3client.call(
      contract: _deployedContract,
      function: _noteCount,
      params: [],
    );

    print('###### Notes List: $rawNotesList');
    return notes;

    int totalTaskLen = rawNotesList[0].toInt();

    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await web3client.call(
          contract: _deployedContract,
          function: _notes,
          params: [BigInt.from(i)]);
      if (temp[1] != "") {
        notes.add(
          Note(
            id: (temp[0] as BigInt).toString(),
            title: temp[1],
            description: temp[2],
          ),
        );
      }
    }
    return notes;
  }
}
