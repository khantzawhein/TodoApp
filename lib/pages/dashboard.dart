import 'package:TodoByKZH/models/todo.dart';
import 'package:TodoByKZH/models/user.dart';
import 'package:TodoByKZH/services/database.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = CurrentUser.of(context).user;

    return Container(
      child: StreamBuilder(
        stream: Database(user.uid).getAllTodo(),
        builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              Text('error fetching todo list');
            }
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Todo todo = snapshot.data[index];
                  return Container(
                    height: 50,
                    child: Column(
                      children: [
                        Text("${todo.title}"),
                        Text("${todo.body}")
                      ],
                    ),
                  );
                },
              );
            }
          }
          return Text('Loading');
        },
      ),
    );
  }
}
