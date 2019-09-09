import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_events.dart';
import '../models/note.dart';

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
  MaterialColor _selectedColor;

  String _title;
  String _body;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AppBloc>(context);
    _selectedColor =
        widget.note?.color != null ? widget.note.color : Colors.grey;
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
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var color in noteColors)
                      CircleAvatar(
                        backgroundColor: color == _selectedColor
                            ? CupertinoColors.lightBackgroundGray
                            : Colors.transparent,
                        radius: 20.0,
                        child: GestureDetector(
                          child: CircleAvatar(
                            radius: 14.0,
                            backgroundColor: color,
                          ),
                          onTap: () {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'action-fab',
        backgroundColor: CupertinoColors.destructiveRed,
        child: Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            (widget.note == null)
                ? _bloc.dispatch(
                    AddNote(
                      note: Note(
                        title: _title,
                        body: _body,
                        created: DateTime.now().millisecondsSinceEpoch,
                        color: _selectedColor ?? Colors.grey,
                      ),
                    ),
                  )
                : _bloc.dispatch(UpdateNote(
                    note: widget.note.copyWith(
                    title: _title,
                    body: _body,
                    color: _selectedColor,
                  )));
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
