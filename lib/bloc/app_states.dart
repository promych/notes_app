import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/note.dart';

@immutable
abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);
}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  final List<Note> notes;

  AppLoaded({@required this.notes}) : super([notes]);
}

class AppError extends AppState {
  final String message;

  AppError({@required this.message}) : super([message]);
}
