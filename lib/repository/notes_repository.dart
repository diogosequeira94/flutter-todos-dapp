import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

import '../model/note.dart';

class NotesRepository {
  late Web3Client web3client;
  late ContractAbi contractAbiCode;
  late EthereumAddress contractAddress;
  late EthPrivateKey credentials;

  /// Remote Procedure Call [RPC Server] Ganash
  final _rpcUrl = 'http://127.0.0.1:7545';

  /// WebSocket Url
  final _wsUrl = 'ws://127.0.0.1:7545';

  /// Never use private keys in production, use walletconnect + metamask instead
  final _mockPrivateGanashKey = 'loremipsum';
  static const notesContractPath = 'build/contracts/NotesContract.json';

  NotesRepository() {
    web3client = Web3Client(
      _rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
  }

  Future<void> getABI() async {
    final abiFile = await rootBundle.loadString(notesContractPath);
    final jsonABI = jsonDecode(abiFile);
    contractAbiCode =
        ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'NotesContract');
  }

  Future<void> getAddress(ContractAbi contractAbi) async {
    final abiFile = await rootBundle.loadString(notesContractPath);
    final jsonABI = jsonDecode(abiFile);
    contractAddress =
        EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    credentials = EthPrivateKey.fromHex(_mockPrivateGanashKey);
  }

  // Future<void> fetchNotes() async {
  //   List totalTaskList = await web3client.call(
  //     contract: deployedContract,
  //     function: noteCount,
  //     params: [],
  //   );
  // }
}
