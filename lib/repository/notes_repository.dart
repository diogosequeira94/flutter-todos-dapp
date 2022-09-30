import 'package:flutter_todos_dapp/repository/notes_web3_api_client.dart';
import 'package:web3dart/web3dart.dart';

/// Notes Repository
/// Responsible for CRUD operations and Error handling

class NotesRepository {
  late NotesWeb3Client notesWeb3ApiClient;
  NotesRepository({required this.notesWeb3ApiClient}) {
    notesWeb3ApiClient.init();
  }

  Future<void> addNote(String title, String description) async {
    await notesWeb3ApiClient.web3client.sendTransaction(
      notesWeb3ApiClient.getCredentials,
      Transaction.callContract(
        contract: notesWeb3ApiClient.getNotesDeployedContract.deployedContract,
        function: notesWeb3ApiClient.getNotesDeployedContract.createNote,
        parameters: [title, description],
      ),
    );
    // fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await notesWeb3ApiClient.web3client.sendTransaction(
      notesWeb3ApiClient.getCredentials,
      Transaction.callContract(
        contract: notesWeb3ApiClient.getNotesDeployedContract.deployedContract,
        function: notesWeb3ApiClient.getNotesDeployedContract.deleteNote,
        parameters: [BigInt.from(id)],
      ),
    );
  }

  // Future<void> fetchNotes() async {
  //   List totalTaskList = await web3client.call(
  //     contract: deployedContract,
  //     function: noteCount,
  //     params: [],
  //   );
  // }
}
