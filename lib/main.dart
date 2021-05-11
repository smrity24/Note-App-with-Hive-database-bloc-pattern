import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/note_bloc.dart';
import 'bloc/note_event.dart';
import 'models/note_model.dart';
import 'note_database/note_database.dart';
import 'screens/notes_screen.dart';

void main() async {
 await Hive.initFlutter();
 Hive.registerAdapter<Note>(NoteAdapter());
 await Hive.openBox<Note>("Note");

 runApp(BlocProvider(
   create: (context) => NoteBloc(NoteDatabase()),
   child: MyApp(),
 ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(NoteInitialEvent());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //backgroundColor: Color(0xFFf0f5f9),
        cardColor: Color(0xFFc9d6df),
        primaryColor: Color(0xFF83c5be),
        //accentColor: Color(0xFF52616b),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

