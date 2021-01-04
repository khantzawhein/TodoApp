import 'package:TodoByKZH/models/user.dart';
import 'package:TodoByKZH/pages/createTodo.dart';
import 'package:TodoByKZH/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class CurrentUser extends InheritedWidget {
  final User user;

  CurrentUser({@required this.user, @required Widget child})
      : super(child: child);

  static CurrentUser of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CurrentUser>();
  }

  @override
  bool updateShouldNotify(CurrentUser oldWidget) => oldWidget.user != user;
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: Auth(context).user,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (!snapshot.hasData) {
            return GuestScaffold(Login());
          }
          return CurrentUser(
              user: snapshot.data,
              child: UserScaffold(Dashboard()),
            );

        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error'),
          );
        }
        return Center(
          child: Text("loading"),
        );
      },
    );
  }
}

class GuestScaffold extends StatelessWidget {
  final Widget _child;

  GuestScaffold(this._child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Welcome from TODO App"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: _child,
    );
  }
}

class UserScaffold extends StatelessWidget {
  final Widget _child;

  UserScaffold(this._child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("TODO"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Auth(context).logout();
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateTodo(CurrentUser.of(context).user),
            ),
          );
        },
      ),
      body: _child,
    );
  }
}


