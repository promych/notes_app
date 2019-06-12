import 'package:bloc/bloc.dart';
import 'package:notes_app/bloc/app_events.dart';
import 'package:notes_app/bloc/app_states.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/data/notes_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  NotesRepository _notesRepository = NotesRepository();

  @override
  AppState get initialState => AppLoading();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is LoadNotes) {
      yield AppLoading();
      yield* _reloadNotes();
    }
    if (event is AddNote) {
      await _notesRepository.addNote(event.note);
      yield* _reloadNotes();
    }
    if (event is UpdateNote) {
      await _notesRepository.updateNote(event.note);
      yield* _reloadNotes();
    }
    if (event is DeleteNote) {
      await _notesRepository.deleteNote(event.note);
      yield* _reloadNotes();
    }
  }

  Stream<AppState> _reloadNotes() async* {
    List<Note> notes = await _notesRepository.getAllNotes();
    yield AppLoaded(notes: notes);
  }
}
