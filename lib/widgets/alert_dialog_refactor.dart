import 'package:flutter/material.dart';
import 'package:flutter_appl/bloc/note_bloc.dart';
import 'package:flutter_appl/bloc/note_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertDialogRefactor extends StatelessWidget {
  final int index;
  const AlertDialogRefactor({this.index});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete?',
        style: TextStyle(color: Color(0xFF49565e)),
      ),
      actions: [
        ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF))),
            child: Text(
              'YES',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              BlocProvider.of<NoteBloc>(context)
                  .add(NoteDeleteEvent(index: index));
              Navigator.pop(context);
            }),
        ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF))),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: TextStyle(color: Color(0xFF49565e)),
            ))
      ],

    );
}}
