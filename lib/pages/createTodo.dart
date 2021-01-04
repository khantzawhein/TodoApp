import 'package:TodoByKZH/models/todo.dart';
import 'package:TodoByKZH/models/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:TodoByKZH/services/database.dart';

class CreateTodo extends StatefulWidget {
  final User user;

  CreateTodo(this.user);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a todo"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Title",
                              labelStyle: TextStyle(fontSize: 18)),
                          cursorHeight: 25.0,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Title field is required";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _bodyController,
                          minLines: 2,
                          maxLines: 7,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "What is it about?",
                              labelStyle: TextStyle(fontSize: 18)),
                          cursorHeight: 25.0,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Title field is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Builder(
                      builder: (newContext) => ElevatedButton(
                        onPressed: () {
                          validateAndSaveTodo(newContext);
                        },
                        child: Text('Create!'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bodyController.dispose();
    _titleController.dispose();
  }

  void validateAndSaveTodo(BuildContext newContext) async {
    ConnectivityResult internet = await Connectivity().checkConnectivity();
    if (internet == ConnectivityResult.none) {
      Scaffold.of(newContext).showSnackBar(
        SnackBar(
          content: Text("Seems like you don't have internet connection."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    bool validated = _formKey.currentState.validate();
    if (validated) {
      EasyLoading.show(status: 'Saving...');
      Todo todo = Todo(title: _titleController.text, body: _bodyController.text);
      await Database(widget.user.uid).storeTodo(todo.toJson());
      EasyLoading.dismiss();
      Navigator.pop(context);
    }
  }
}
