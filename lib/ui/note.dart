import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/app_bloc.dart';
import 'package:notes_app/bloc/app_events.dart';
import 'package:notes_app/models/note.dart';

class NotePage extends StatefulWidget {
  final Note note;
  final bool isEditing;

  const NotePage({Key key, this.note, this.isEditing}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  AppBloc _bloc;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;
  String _body;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: (widget.note != null) ? widget.note.title : '',
                  decoration: InputDecoration(hintText: 'Title'),
                  onSaved: (value) => _title = value,
                  validator: (value) =>
                      value.trim().isEmpty ? 'Title can\'t be empty' : null,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: (widget.note != null) ? widget.note.body : '',
                  decoration: InputDecoration(hintText: 'Body'),
                  maxLines: 10,
                  onSaved: (value) => _body = value,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            (widget.note == null)
                ? _bloc.dispatch(AddNote(
                    note: Note(
                        title: _title,
                        body: _body,
                        created: DateTime.now().millisecondsSinceEpoch),
                  ))
                : _bloc.dispatch(UpdateNote(
                    note: widget.note.copyWith(title: _title, body: _body)));
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
