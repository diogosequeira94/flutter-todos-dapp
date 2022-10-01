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
  const NotesFetchSuccess({required this.notes});

  final List<Note> notes;

  @override
  List<Object> get props => [notes];
}

class NotesFetchError extends NotesServiceState {
  const NotesFetchError(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}

class NotesAddInProgress extends NotesServiceState {
  @override
  List<Object> get props => [];
}

class NotesAddSuccess extends NotesServiceState {
  @override
  List<Object> get props => [];
}

class NotesAddFailure extends NotesServiceState {
  @override
  List<Object> get props => [];
}
