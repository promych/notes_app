import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/note.dart';
import '../theme.dart';
import 'note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final Function onDismiss;

  const NoteTile({
    Key key,
    @required this.note,
    @required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dismissible(
          key: key,
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) onDismiss();
          },
          background: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: CupertinoColors.destructiveRed,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: CupertinoColors.lightBackgroundGray,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${note.title}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Styles.textColor),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      DateFormat('yMMMMd').add_Hm().format(
                          DateTime.fromMillisecondsSinceEpoch(note.created)),
                      style: TextStyle(fontSize: 12.0, color: Styles.textColor),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: note.color,
                  radius: 10.0,
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => NotePage(note: note),
          ),
        );
      },
    );
  }
}
