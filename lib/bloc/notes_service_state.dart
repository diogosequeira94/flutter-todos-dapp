part of 'notes_service_bloc.dart';

abstract class NotesServiceState extends Equatable {
  const NotesServiceState();
}

class NotesServiceInitial extends NotesServiceState {
  @override
  List<Object> get props => [];
}

class NotesFetchInProgress extends NotesServiceState {
  @override
  List<Object> get props => [];
}

class NotesFetchSuccess extends NotesServiceState {
  final List<Note> notes;
  const NotesFetchSuccess({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NotesFetchFailure extends NotesServiceState {
  @override
  List<Object> get props => [];
}

class NotesAddInProgress extends NotesServiceState {
  @override
  List<Object> get props => [];
}

class NotesAddSuccess extends NotesServiceState {
  final Note note;
  const NotesAddSuccess({required this.note});

  @override
  List<Object> get props => [note];
}

class NotesAddFailure extends NotesServiceState {
  @override
  List<Object> get props => [];
}
