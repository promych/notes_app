import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_events.dart';
import '../bloc/app_states.dart';
import 'note.dart';
import 'note_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AppBloc>(context);
    _bloc.dispatch(LoadNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, AppState state) {
            if (state is AppLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AppLoaded) {
              return state.notes.length > 0
                  ? ListView.builder(
                      itemCount: state.notes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NoteTile(note: state.notes[index]);
                      },
                    )
                  : Center(child: Text('No notes yet :('));
            } else if (state is AppError) {
              return Center(child: Text('${state.message}'));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => NotePage()));
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
