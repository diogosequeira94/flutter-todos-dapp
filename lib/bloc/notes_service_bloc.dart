import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos_dapp/models/note.dart';
import 'package:flutter_todos_dapp/repository/notes_repository.dart';

part 'notes_service_event.dart';
part 'notes_service_state.dart';

class NotesServiceBloc extends Bloc<NotesServiceEvent, NotesServiceState> {
  final NotesRepository notesRepository;
  NotesServiceBloc({required this.notesRepository})
      : super(NotesServiceInitial()) {
    List<Note> notes = [];
    on<FetchNotesStarted>(_onFetchStarted);
    on<AddNotePressed>(_onFetchStarted);
    on<DeleteNotePressed>(_onFetchStarted);
  }

  Future<void> _onFetchStarted(NotesServiceEvent event, Emitter<NotesServiceState> emit) async {
    emit(NotesFetchInProgress());
    try {
      // final notes = await notesRepository.fetchNotes();
      final List<Note>notes = [];
      emit(NotesFetchSuccess(notes: notes));
    } catch (_) {
      emit(NotesFetchError());
    }
  }
}
