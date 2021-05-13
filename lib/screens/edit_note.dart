import 'package:flutter/material.dart';
import 'package:flutter_appl/bloc/note_bloc.dart';
import 'package:flutter_appl/bloc/note_event.dart';
import 'package:flutter_appl/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditNoteScreen extends StatefulWidget {
  final bool newNote;
  final Note note;
  final int index;
  EditNoteScreen({this.note, this.index, @required this.newNote});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  @override
  Widget build(BuildContext context) {
    String title = widget.note != null ? widget.note.title : "";
    String content = widget.note != null ? widget.note.content : "";
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController(text: title);
    final _contentController = TextEditingController(text: content);

    Future<bool> _onWillPop() async {
      if (_titleController.text == title ||
          _contentController.text == content) {
        return showDialog(
          context: context,
            builder:(BuildContext context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Unsaved data will be lost.'),
              actions: <Widget>[
                new ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF))),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No',style: TextStyle(color: Colors.black),),
                ),
                new ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF))),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes',style: TextStyle(color: Colors.black),),
                ),
              ],

            )

        ) ?? false;

      }
      else {
        return true;
      }

    }

    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.orange])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              widget.newNote ? 'New Note' : 'Edit Note',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: (){
              Navigator.pop(context);
            },),

          ),
          floatingActionButton: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: FloatingActionButton.extended(
                backgroundColor: Color(0xFF560bad),
                icon: Icon(Icons.add),
                label: Text(widget.newNote ? 'ADD' : 'UPDATE'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.newNote ? BlocProvider.of<NoteBloc>(context).add(NoteAddEvent(
                        title: _titleController.text,
                        content: _contentController.text))
                        : BlocProvider.of<NoteBloc>(context).add(NoteEditEvent(
                        title: _titleController.text,
                        content: _contentController.text,
                        index: widget.index));
                    Navigator.pop(context);
                  }
                },
              )),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    NoteTitle(titleController: _titleController),
                    SizedBox(
                      height: 20,
                    ),
                    NoteBody(contentController: _contentController,)
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NoteTitle extends StatelessWidget {
  final TextEditingController _titleController;

  const NoteTitle({
    Key key,
    @required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter the note title';
          }
          return null;
        },
        controller: _titleController,
        style: TextStyle(color: Color(0xFFfdffb6)),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black38),
          border: OutlineInputBorder(),
          labelText: 'Note Title',

        ),
      ),
    );
  }
}

class NoteBody extends StatelessWidget {

  const NoteBody({
    Key key,
    @required TextEditingController contentController,
  })  : _contentController = contentController,
        super(key: key);

  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Container(
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter the note body!';
            }
            return null;
          },
          maxLines: 50,
          controller: _contentController,
          style: TextStyle(color: Color(0xFFfdffb6)),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

