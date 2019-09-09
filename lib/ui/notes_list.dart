import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_events.dart';
import '../bloc/app_states.dart';
import 'note_tile.dart';

class NotesList extends StatefulWidget {
  final TextEditingController searchController;

  NotesList({this.searchController});

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  AppBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AppBloc>(context);
    _bloc.dispatch(LoadNotes(withSampleData: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, AppState state) {
        if (state is AppLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AppLoaded) {
          if (state.notes.length == 0)
            return Center(child: Text('No notes yet :('));
          final notes = widget.searchController.text == null
              ? state.notes
              : state.notes
                  .where((note) => note.title.toLowerCase().contains(
                      widget.searchController.text.toString().toLowerCase()))
                  .toList();
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return NoteTile(
                key: ValueKey(notes[index].id),
                note: notes[index],
                onDismiss: () {
                  _bloc.dispatch(DeleteNote(note: notes[index]));
                },
              );
            },
          );
        } else if (state is AppError) {
          return Center(child: Text('${state.message}'));
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
