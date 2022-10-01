import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_dapp/bloc/notes_service_bloc.dart';
import 'package:flutter_todos_dapp/repository/notes_repository.dart';
import 'package:flutter_todos_dapp/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        lazy: false,
        create: (context) => NotesServiceBloc(
          notesRepository: NotesRepository.instance,
        ),
        child: const HomePage(),
      ),
    );
  }
}
