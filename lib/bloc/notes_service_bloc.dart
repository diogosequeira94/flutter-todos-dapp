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
    on<AddNotePressed>(_onAddNotePressed);
    on<DeleteNotePressed>(_onFetchStarted);
  }

  Future<void> _onFetchStarted(NotesServiceEvent event, Emitter<NotesServiceState> emit) async {
    emit(NotesFetchInProgress());
    try {
      final notes = await notesRepository.fetchNotes();
      emit(NotesFetchSuccess(notes: notes));
    } on Object catch (error) {
      emit(NotesFetchError(error.toString()));
    }
  }

  Future<void> _onAddNotePressed(AddNotePressed event, Emitter<NotesServiceState> emit) async {
    emit(NotesAddInProgress());
    await Future.delayed(const Duration(seconds: 3));
    try {
      await notesRepository.addNote(event.name, event.description);
      emit(NotesAddSuccess());
    } on Object catch (_) {
      emit(NotesAddFailure());
    }
  }
}
