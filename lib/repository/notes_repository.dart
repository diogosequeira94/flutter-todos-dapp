import 'package:flutter_todos_dapp/models/note.dart';
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

  Future<void> fetchNotes() async {
    List<Note> notes = [];
    final rawNotesList = await notesWeb3ApiClient.web3client.call(
      contract: notesWeb3ApiClient.getNotesDeployedContract.deployedContract,
      function: notesWeb3ApiClient.getNotesDeployedContract.noteCount,
      params: [],
    );

    int totalTaskLen = rawNotesList[0].toInt();

    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await notesWeb3ApiClient.web3client.call(
          contract: notesWeb3ApiClient.getNotesDeployedContract.deployedContract,
          function: notesWeb3ApiClient.getNotesDeployedContract.notes,
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
  }
}
