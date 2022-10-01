import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_todos_dapp/repository/endpoints.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

import 'notes_deployed_contract.dart';

class NotesWeb3Client {
  late Web3Client web3client;
  late NotesDeployedContract _notesDeployedContract;
  late ContractAbi _contractAbiCode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _credentials;

  static const notesContractPath = 'assets/contracts/NotesContract.json';

  EthPrivateKey get getCredentials => _credentials;
  NotesDeployedContract get getNotesDeployedContract => _notesDeployedContract;

  NotesWeb3Client() {
    web3client = Web3Client(
      Endpoints.rpcUrl(),
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(Endpoints.wsUrl()).cast<String>();
      },
    );
  }

  Future<void> init() async {
    await _getABI();
    await _getAddress(_contractAbiCode);
    await _getCredentials();
    _notesDeployedContract = NotesDeployedContract();
    _notesDeployedContract.getDeployedContract(
        _contractAbiCode, _contractAddress);
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
}
