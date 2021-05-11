import 'package:hive/hive.dart';

import 'dart:async';

import '../models/note_model.dart';

class NoteDatabase {
  String _boxName = "Note";
  // open a box
  Future<Box> noteBox() async {
    var box = await Hive.openBox<Note>(_boxName);
    return box;
  }
   // get full note
  Future<List<Note>> getFullNote() async {
    final box = await noteBox();
    List<Note> notes = box.values.toList();
    return notes;
  }
 // to add data in box
  Future<void> addToBox(Note note) async {
    final box = await noteBox();

    await box.add(note);
  }
  // delete data from box
  Future<void> deleteFromBox(int index) async {
    final box = await noteBox();
    await box.deleteAt(index);
  }
 // delete all data from box
  Future<void> deleteAll() async {
    final box = await noteBox();
    await box.clear();
  }
  // update data
  Future<void> updateNote(int index, Note note) async {
    final box = await noteBox();
    await box.putAt(index, note);
  }
}


