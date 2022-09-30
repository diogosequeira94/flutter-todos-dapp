import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_dapp/bloc/notes_service_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Dapp'),
      ),
      body: BlocBuilder<NotesServiceBloc, NotesServiceState>(
        builder: (context, state) {
          if (state is NotesFetchInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesFetchSuccess) {
            return const Center(child: Text('Success Fetching Notes!'));
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
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height - topPadding,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
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
