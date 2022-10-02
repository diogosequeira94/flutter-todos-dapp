import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_dapp/bloc/notes_service_bloc.dart';

class AddNoteFormWidget extends StatefulWidget {
  const AddNoteFormWidget({Key? key}) : super(key: key);

  @override
  State<AddNoteFormWidget> createState() => _AddNoteFormWidgetState();
}

class _AddNoteFormWidgetState extends State<AddNoteFormWidget> {
  late TextEditingController nameTextEditingController;
  late TextEditingController descriptionTextEditingController;

  @override
  void initState() {
    nameTextEditingController = TextEditingController();
    descriptionTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name'),
              TextFormField(
                controller: nameTextEditingController,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Description'),
              TextFormField(
                controller: descriptionTextEditingController,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          BlocBuilder<NotesServiceBloc, NotesServiceState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    onPressed: () {
                      context.read<NotesServiceBloc>().add(
                            AddNotePressed(
                              name: nameTextEditingController.text,
                              description:
                                  descriptionTextEditingController.text,
                            ),
                          );
                    },
                    child: state is NotesAddInProgress
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Add note')),
              );
            },
          )
        ],
      ),
    );
  }
}
