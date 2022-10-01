import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_dapp/bloc/notes_service_bloc.dart';
import 'package:flutter_todos_dapp/view/add_note_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotesServiceBloc _notesServiceBloc;

  @override
  void initState() {
    super.initState();
    _notesServiceBloc = context.read<NotesServiceBloc>();
    _notesServiceBloc.add(FetchNotesStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Dapp'),
        actions: [
          BlocBuilder<NotesServiceBloc, NotesServiceState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                enableFeedback: state is NotesFetchInProgress,
                onPressed: () {
                  context.read<NotesServiceBloc>().add(FetchNotesStarted());
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotesServiceBloc, NotesServiceState>(
        builder: (context, state) {
          if (state is NotesFetchInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesFetchSuccess) {
            return const Center(child: Text('Success Fetching Notes!'));
          } else if (state is NotesFetchError) {
            return const Center(child: Text('Oops something went wrong!'));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final topPadding = MediaQuery.of(context).padding.top;
          showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) {
                return Container(
                  height: MediaQuery.of(context).size.height - topPadding,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: BlocProvider.value(
                    value: context.read<NotesServiceBloc>(),
                    child: const AddNoteFormWidget(),
                  ),
                );
              });
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
