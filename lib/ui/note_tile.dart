import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/app_bloc.dart';
import 'package:notes_app/bloc/app_events.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/ui/note.dart';

class NoteTile extends StatefulWidget {
  final Note note;

  const NoteTile({Key key, @required this.note}) : super(key: key);

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.note.title}'),
      subtitle: Text(DateFormat('dd-MM-yy hh:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(widget.note.created))),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => BlocProvider.of<AppBloc>(context)
            .dispatch(DeleteNote(note: widget.note)),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NotePage(
                  note: widget.note,
                )));
      },
    );
  }
}
