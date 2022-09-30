import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class NotesRepository {
  final Web3Client web3client;
  final httpClient = http.Client();

  NotesRepository({
    required this.web3client,
  });
}
