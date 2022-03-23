
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fraudpredsys/screens/confirmEmail.dart';
import 'package:fraudpredsys/screens/login_screen.dart';


class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';
  final String message =
      "An email has just been sent to you, Click the link provided to complete password reset";

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late String _email;
  TextEditingController emailController = TextEditingController();

  _passwordReset() async {
    try {
      _formKey.currentState?.save();
      final user = await _auth.sendPasswordResetEmail(email:emailController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ConfirmEmail(message: widget.message,);
        }
      ));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: Image.asset("assets/logo.png", fit: BoxFit.contain),
              ),
              const Text(
                'Enter Your Email',
                style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 17, 17, 17)),
              ),
              TextFormField(
                onSaved: (newEmail) {
                _email = newEmail!;
                },
                controller: emailController,
                style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      errorStyle: TextStyle(color: Colors.blue),
                      labelStyle: TextStyle(color: Colors.blue),
                      hintStyle: TextStyle(color: Colors.blue),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
              const SizedBox(height: 20),
              RaisedButton(
                child: const Text('Send Email'),
                onPressed: () {
                  _passwordReset();
                  if (kDebugMode) {
                    print(_email);
                  }

                },
              ),
              FlatButton(
                child: const Text('Sign In'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        const LoginScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
