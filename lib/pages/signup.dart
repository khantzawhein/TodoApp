import 'package:TodoByKZH/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          backgroundColor: Colors.black,
        ),
        body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  void validateAndSignup() async {
    bool validated = _formKey.currentState.validate();
    if (validated) {
      bool result = await Auth(context).register(
          email: _emailInputController.text,
          password: _passwordInputController.text);
      if (result) {
        Navigator.pop(context);
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
    _emailInputController.dispose();
    _passwordInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Register an account',
              style: Theme.of(context).primaryTextTheme.headline5),
          SizedBox(
            height: 20,
          ),
          Form(
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
                      child: Text('Register'),
                      onPressed: validateAndSignup,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
