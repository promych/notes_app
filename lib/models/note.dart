import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

const noteColors = <MaterialColor>[
  Colors.grey,
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.cyan,
  Colors.pink,
];

class Note {
  final String title;
  final String body;
  final int created;
  final MaterialColor color;

  int id;

  Note({
    @required this.title,
    @required this.body,
    @required this.created,
    this.color = Colors.grey,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'created': created,
      'color': noteColors.indexOf(color),
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      body: map['body'],
      created: map['created'],
      color: map['color'] == -1 ? noteColors[0] : noteColors[map['color']],
    );
  }

  Note copyWith({
    @required String title,
    String body,
    MaterialColor color,
  }) {
    final note = Note(
      title: title,
      body: body ?? this.body,
      created: this.created,
      color: color ?? this.color,
    )..id = this.id;
    return note;
  }
}
