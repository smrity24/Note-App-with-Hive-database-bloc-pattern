
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// initial event
class NoteInitialEvent extends NoteEvent {

}
// add event
class NoteAddEvent extends NoteEvent {
  final String title, content;

  NoteAddEvent({@required this.title, @required this.content});
}
// edit event
class NoteEditEvent extends NoteEvent {
  final String title, content;
  final int index;

  NoteEditEvent(
      {@required this.title, @required this.content, @required this.index});
}
// delete event
class NoteDeleteEvent extends NoteEvent {
  final int index;

  NoteDeleteEvent({@required this.index});
}