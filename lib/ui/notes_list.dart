import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_events.dart';
import '../bloc/app_states.dart';
import 'note_tile.dart';

class NotesList extends StatefulWidget {
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
          return state.notes.length > 0
              ? ListView.builder(
                  itemCount: state.notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NoteTile(
                      key: ValueKey(state.notes[index].id),
                      note: state.notes[index],
                    );
                  },
                )
              : Center(child: Text('No notes yet :('));
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
