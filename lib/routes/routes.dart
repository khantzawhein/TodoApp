import 'package:TodoByKZH/pages/error.dart';
import 'package:TodoByKZH/pages/home.dart';
import 'package:TodoByKZH/pages/loading.dart';
import 'package:TodoByKZH/pages/login.dart';
import 'package:TodoByKZH/pages/signup.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => Home(),
    '/error': (_) => Error(),
    '/loading': (_) => Loading(),
    '/signup': (_) => Signup(),
    '/login': (_) => Login(),
    // '/create-todo': (_) => CreateTodo(_),
  };
}
