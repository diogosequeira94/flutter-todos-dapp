import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos_dapp/model/note.dart';
import 'package:flutter_todos_dapp/repository/notes_repository.dart';

part 'notes_service_event.dart';
part 'notes_service_state.dart';

class NotesServiceBloc extends Bloc<NotesServiceEvent, NotesServiceState> {
  final NotesRepository notesRepository;
  NotesServiceBloc({required this.notesRepository})
      : super(NotesServiceInitial()) {
    List<Note> notes = [];

    on<FetchNotesStarted>((event, emit) async {
      print('Fetching in progress...');
      emit(NotesFetchInProgress());
      await Future.delayed(const Duration(seconds: 3));
      emit(NotesFetchSuccess(notes: notes));
      print('Fetching complete...');
    });
  }
}
