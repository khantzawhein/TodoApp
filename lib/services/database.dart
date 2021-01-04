import 'package:TodoByKZH/models/todo.dart';
import 'package:TodoByKZH/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId;

  CollectionReference get todos => firestore.collection('users').doc(userId).collection('todos');

  Database(this.userId);

  Future<DocumentReference> storeTodo(Map<String, dynamic> data) async {
    return todos.add(data);
  }

  Stream<List<Todo>> getAllTodo() {
    return todos.orderBy('timestamp', descending: true).snapshots().map((QuerySnapshot query) {
      return query.docs.map((snapshot) {
        return Todo.fromDocumentSnapshot(snapshot);
      }).toList();
    });
  }

}