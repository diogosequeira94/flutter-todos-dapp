part of 'notes_service_bloc.dart';

abstract class NotesServiceEvent extends Equatable {
  const NotesServiceEvent();
}

class FetchNotes extends NotesServiceEvent {
  @override
  List<Object?> get props => [];
}

class AddNotePressed extends NotesServiceEvent {
  final String name;
  final String description;

  const AddNotePressed({
    required this.name,
    required this.description,
  });
  @override
  List<Object?> get props => [name, description];
}

class DeleteNotePressed extends NotesServiceEvent {
  final String id;

  const DeleteNotePressed({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
