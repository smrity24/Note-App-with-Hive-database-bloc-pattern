import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appl/models/note_model.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object> get props => [];
}

// initial
class NoteInitial extends NoteState {

}

// loading
class NotesLoading extends NoteState {}

// edit notes
class EditNotesState extends NoteState {
  final Note note;

  EditNotesState({@required this.note});

}
//  your notes
class YourNotesState extends NoteState {
  final List<Note> notes; // get all notes

  YourNotesState({@required this.notes});

}
// new note
class NewNoteState extends NoteState {}