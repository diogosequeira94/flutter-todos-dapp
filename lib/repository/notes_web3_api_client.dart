import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_todos_dapp/repository/endpoints.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

import 'notes_deployed_contract.dart';

class NotesWeb3Client {
  late Web3Client web3client;
  late NotesDeployedContract notesDeployedContract;
  late ContractAbi contractAbiCode;
  late EthereumAddress contractAddress;
  late EthPrivateKey credentials;

  static const notesContractPath = 'assets/contracts/NotesContract.json';

  EthPrivateKey get getCredentials => credentials;
  NotesDeployedContract get getNotesDeployedContract => notesDeployedContract;

  NotesWeb3Client() {
    print('Notes Web3 Client also Initialized!');
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
    await _getAddress(contractAbiCode);
    await _getCredentials();
    notesDeployedContract = NotesDeployedContract();
    notesDeployedContract.getDeployedContract(contractAbiCode, contractAddress);
  }

  Future<void> _getABI() async {
    final abiFile = await rootBundle.loadString(notesContractPath);
    final jsonABI = jsonDecode(abiFile);
    contractAbiCode =
        ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'NotesContract');
  }

  Future<void> _getAddress(ContractAbi contractAbi) async {
    final abiFile = await rootBundle.loadString(notesContractPath);
    final jsonABI = jsonDecode(abiFile);
    contractAddress =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }

  Future<void> _getCredentials() async {
    credentials = EthPrivateKey.fromHex(Endpoints.mockPrivateGanashKey());
  }
}
