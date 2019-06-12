import 'package:notes_app/data/database.dart';
import 'package:notes_app/models/note.dart';
import 'package:sembast/sembast.dart';

class NotesRepository {
  var _store = StoreRef<int, Map<String, dynamic>>.main();
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<Note>> getAllNotes() async {
    Finder finder = Finder(sortOrders: [SortOrder('created')]);
    var records = await _store.find(await _db, finder: finder);
    return records.map((snapshot) {
      Note note = Note.fromMap(snapshot.value);
      note.id = snapshot.key;
      return note;
    }).toList();
  }

  Future addNote(Note note) async {
    await _store.add(await _db, note.toMap());
  }

  Future updateNote(Note note) async {
    await _store.update(await _db, note.toMap(),
        finder: Finder(filter: Filter.byKey(note.id)));
  }

  Future deleteNote(Note note) async {
    await _store.delete(await _db,
        finder: Finder(filter: Filter.byKey(note.id)));
  }
}
