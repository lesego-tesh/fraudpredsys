import 'package:flutter/material.dart';
import 'package:fraudpredsys/screens/login_screen.dart';

class ConfirmEmail extends StatelessWidget {
  static String id = 'confirm-email';
  final String message;

  const ConfirmEmail({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 248, 248),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/logo.png", fit: BoxFit.contain),
              ),
                Text(
                  message
                ,
                style: const TextStyle(color: Color.fromARGB(255, 8, 8, 8), fontSize: 16),
              ),
              FlatButton(
                child:const Text('Sign In'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          const LoginScreen()
                      )
                    );
                  },
              )
            ]
          ),
        )
      ),
    );
  }
}