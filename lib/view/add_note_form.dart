import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_dapp/bloc/notes_service_bloc.dart';

class AddNoteFormWidget extends StatefulWidget {
  const AddNoteFormWidget({Key? key}) : super(key: key);

  @override
  State<AddNoteFormWidget> createState() => _AddNoteFormWidgetState();
}

class _AddNoteFormWidgetState extends State<AddNoteFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Add a note',
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 20.0),
          TextFormField(),
          TextFormField(),
          BlocBuilder<NotesServiceBloc, NotesServiceState>(
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    context.read<NotesServiceBloc>().add(
                          const AddNotePressed(
                              name: 'Note 1 ', description: 'Some Description'),
                        );
                  },
                  child: state is NotesAddInProgress
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Add note'));
            },
          )
        ],
      ),
    );
  }
}
