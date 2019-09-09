import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/note.dart';
import '../theme.dart';
import 'note.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  const NoteTile({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: CupertinoColors.lightBackgroundGray,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${note.title}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Styles.textColor),
                  ),
                  Text(
                    DateFormat('HH:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(note.created)),
                  ),
                ],
              ),
              note.body != ''
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '${note.body}',
                        style:
                            TextStyle(color: Styles.textColor, fontSize: 16.0),
                      ),
                    )
                  : SizedBox(height: 10.0),
              Text(
                DateFormat('yMMMMd')
                    .format(DateTime.fromMillisecondsSinceEpoch(note.created)),
                style: TextStyle(fontSize: 12.0, color: Styles.textColor),
              ),
            ],
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
