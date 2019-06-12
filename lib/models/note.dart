import 'package:meta/meta.dart';

class Note {
  final String title;
  final String body;
  final int created;

  int id;

  Note({@required this.title, @required this.body, @required this.created});

  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body, 'created': created};
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
        title: map['title'], body: map['body'], created: map['created']);
  }

  Note copyWith({@required String title, String body}) {
    Note note =
        Note(title: title, body: body ?? this.body, created: this.created)
          ..id = this.id;
    return note;
  }
}
