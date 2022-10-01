import 'package:flutter_todos_dapp/models/note.dart';
import 'package:flutter_todos_dapp/repository/notes_web3_api_client.dart';
import 'package:web3dart/web3dart.dart';

/// Notes Repository
/// Responsible for CRUD operations and Error handling

class NotesRepository {
  final NotesWeb3Client _notesWeb3ApiClient = NotesWeb3Client();

  static final _instance = NotesRepository._internal();

  static NotesRepository get instance => _instance;

  NotesRepository._internal(){
    /// Calling init() instance method inside this constructor makes Dart code run in sequence
    /// Calling init() inside NotesWeb3Client constructor will trigger NotesRepository's event before class is fully initialized
    _notesWeb3ApiClient.init();
  }

  Future<void> addNote(String title, String description) async {
    await _notesWeb3ApiClient.web3client.sendTransaction(
      _notesWeb3ApiClient.getCredentials,
      Transaction.callContract(
        contract: _notesWeb3ApiClient.getNotesDeployedContract,
        function: _notesWeb3ApiClient.createNote,
        parameters: [title, description],
      ),
    );
  }

  Future<void> deleteNote(int id) async {
    await _notesWeb3ApiClient.web3client.sendTransaction(
      _notesWeb3ApiClient.getCredentials,
      Transaction.callContract(
        contract: _notesWeb3ApiClient.getNotesDeployedContract,
        function: _notesWeb3ApiClient.deleteNote,
        parameters: [BigInt.from(id)],
      ),
    );
  }

  Future<List<Note>> fetchNotes() async {
    List<Note> notes = [];
    print('###### Fetching notes from repo.....');
    final rawNotesList = await _notesWeb3ApiClient.web3client.call(
      contract: _notesWeb3ApiClient.getNotesDeployedContract,
      function: _notesWeb3ApiClient.noteCount,
      params: [],
    );

    print('###### Notes List: $rawNotesList');
    return notes;

    int totalTaskLen = rawNotesList[0].toInt();

    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await _notesWeb3ApiClient.web3client.call(
          contract:
              _notesWeb3ApiClient.getNotesDeployedContract,
          function: _notesWeb3ApiClient.notes,
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
