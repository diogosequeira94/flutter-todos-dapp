import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_todos_dapp/repository/endpoints.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class NotesWeb3Client {
  late Web3Client web3client;
  late DeployedContract _notesDeployedContract;
  late ContractAbi _contractAbiCode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _credentials;

  static const notesContractPath = 'assets/contracts/NotesContract.json';

  EthPrivateKey get getCredentials => _credentials;
  DeployedContract get getNotesDeployedContract => _notesDeployedContract;

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
    await _getDeployedContract();
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

    // /// Test logs
    // EtherAmount balance = await web3client.getBalance(_credentials.address);
    // print(balance.getValueInUnit(EtherUnit.ether));
  }

  //region DeployedContract
  late ContractFunction createNote;
  late ContractFunction deleteNote;
  late ContractFunction notes;
  late ContractFunction noteCount;

  /// ToDo: assign in NoteDeployedContract
  Future<void> _getDeployedContract() async {
    _notesDeployedContract =
        DeployedContract(_contractAbiCode, _contractAddress);
    createNote = _notesDeployedContract.function('createNote');
    deleteNote = _notesDeployedContract.function('deleteNote');
    notes = _notesDeployedContract.function('notes');
    noteCount = _notesDeployedContract.function('noteCount');
  }
//endregion
}
