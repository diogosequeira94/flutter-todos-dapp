import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notes_service_event.dart';
part 'notes_service_state.dart';

class NotesServiceBloc extends Bloc<NotesServiceEvent, NotesServiceState> {
  NotesServiceBloc() : super(NotesServiceInitial()) {
    on<NotesServiceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
