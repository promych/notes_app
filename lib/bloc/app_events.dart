import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/note.dart';

@immutable
abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

class LoadNotes extends AppEvent {}

class AddNote extends AppEvent {
  final Note note;

  AddNote({@required this.note}) : super([note]);
}

class UpdateNote extends AppEvent {
  final Note note;

  UpdateNote({@required this.note}) : super([note]);
}

class DeleteNote extends AppEvent {
  final Note note;

  DeleteNote({@required this.note}) : super([note]);
}
