import 'package:flutter/widgets.dart';

class User {
  final String uid;
  final String displayName;
  final String email;

  User({@required this.uid, this.email, this.displayName});
}
