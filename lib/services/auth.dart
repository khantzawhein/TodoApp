import 'package:TodoByKZH/models/user.dart' as UserModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:connectivity/connectivity.dart';

class Auth {
  BuildContext _context;
  FirebaseAuth auth = FirebaseAuth.instance;

  Auth(BuildContext context) : _context = context;

  Stream<UserModel.User> get user => auth.authStateChanges().map(_userMapper);

  UserModel.User _userMapper(User user) {
    if (user == null) {
      return null;
    }
    return UserModel.User(uid: user.uid, email: user.email, displayName: user.displayName);
  }

  void logout() async {
    EasyLoading.show(status: "Signing out...");
    try {
      await auth.signOut();
    } catch (e) {
      Widget _snackBar = SnackBar(
        content: Text(e),
        backgroundColor: Colors.red,
      );
      Scaffold.of(_context).showSnackBar(_snackBar);
    }
    EasyLoading.dismiss();
  }

  Future<void> login({@required email, @required password}) async {
    String message;
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      EasyLoading.show(status: "Please wait...");
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          message = "Invalid email or password.";
        } else if (e.code == 'user-disabled') {
          message = "This user has been disabled";
        } else if (e.code == 'invalid-email') {
          message = "Invalid email";
        }
      } catch (e) {
        message = e;
        print(e);
      }
      EasyLoading.dismiss();
    } else {
      message = "Seems like you don't have internet connection.";
    }

    showSnackBar(message);
  }

  Future<bool> register({@required email, @required password}) async {
    String message;
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    EasyLoading.show(status: "Signing up...");
    if (connectivityResult != ConnectivityResult.none) {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        EasyLoading.dismiss();
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = "The password provided is too weak.";
        } else if (e.code == 'email-already-in-use') {
          message = "The account already exists for that email.";
        }
      } catch (e) {
        message = e;
        print(e);
      }
    } else {
      message = "Seems like you don't have internet connection.";
    }

    showSnackBar(message);
    EasyLoading.dismiss();
    return false;
  }

  void showSnackBar(String message) {
    if (message != null) {
      Widget snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      );
      Scaffold.of(_context).showSnackBar(snackBar);
    }
  }
}
