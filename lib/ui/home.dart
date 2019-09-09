import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import 'note.dart';
import 'notes_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                      controller: _controller,
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
            Expanded(
              child: NotesList(
                searchController: _controller,
              ),
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
