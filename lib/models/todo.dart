import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Todo extends ChangeNotifier {
  String id;
  String title;
  String body;
  bool done;
  int timestamp;

  Todo({@required this.title, this.body, this.done: false, this.id, this.timestamp}) {
    if (timestamp == null) {
      timestamp = DateTime.now().millisecondsSinceEpoch;
    }
  }

  factory Todo.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return Todo(id: snapshot.id, title: data['title'], body: data['body'], done: data['done']);
  }
  void updateTodo(String id, {@required String title, String body, bool done: false}) {
    this.title = title;
    this.body = body;
    this.done = done;

    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'body': this.body,
      'done': this.done,
      'timestamp': this.timestamp
    };
  }
}
