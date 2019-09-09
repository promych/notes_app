import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import 'note.dart';
import 'notes_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.short_text,
                    color: Styles.textColor,
                    size: 40.0,
                  ),
                  Icon(
                    Icons.person,
                    color: Styles.textColor,
                    size: 30.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Notes',
                    style: TextStyle(color: Styles.textColor, fontSize: 40.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      padding: const EdgeInsets.all(8.0),
                      placeholder: 'Search',
                      placeholderStyle:
                          TextStyle(color: CupertinoColors.inactiveGray),
                      decoration: BoxDecoration(
                        color: CupertinoColors.lightBackgroundGray,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.search,
                          color: CupertinoColors.inactiveGray,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Notes'),
                  Text('Bookmarks'),
                  Icon(
                    Icons.dashboard,
                    color: Styles.textColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: NotesList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.destructiveRed,
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (BuildContext context) => NotePage()));
        },
      ),
    );
  }
}
