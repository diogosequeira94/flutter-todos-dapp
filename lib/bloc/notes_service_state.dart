part of 'notes_service_bloc.dart';

abstract class NotesServiceState extends Equatable {
  const NotesServiceState();
}

class NotesServiceInitial extends NotesServiceState {
  @override
  List<Object> get props => [];
}
