import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String content;

  Note({this.title, this.content});

}

// create a model class
// add annotations to generated typeadapter
// add a section where type adapter will be generated
// to annotate on each field we'will use @hivefield