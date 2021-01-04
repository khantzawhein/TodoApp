import 'package:TodoByKZH/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  void validateAndLogin() {
    bool validated = _formKey.currentState.validate();
    if (validated) {
      Auth(context).login(
          email: _emailInputController.text,
          password: _passwordInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Log in to continue',
                    style: Theme.of(context).primaryTextTheme.headline5),
                SizedBox(
                  height: 20,
                ),
                loginForm(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    style: ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: Text('Register here!'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailInputController.dispose();
    _passwordInputController.dispose();
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            TextFormField(
              controller: _emailInputController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Email field is required.";
                } else if (!EmailValidator.validate(value)) {
                  return "Seems like not a valid email.";
                }
                return null;
              },
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Email",
              ),
              cursorHeight: 25.0,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _passwordInputController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Password field is required.";
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Password",
              ),
              cursorHeight: 25.0,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Log In'),
                onPressed: validateAndLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
