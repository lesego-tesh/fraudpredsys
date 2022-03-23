// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firrebase_auth_forgot_password/utils.dart';
import 'package:flutter/material.dart';
// import 'package:basic_utils/basic_utils.dart';

class ForgotPasswordPage extends StatefulWidget {

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formkey= GlobalKey<FormState>();
  final emailController= TextEditingController();

  @override
 void dispose() {
   emailController.dispose();

    super.dispose();
 }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text('Reset Password'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        )),
            Text(
              'Recieve an email to\n reset your password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Enter Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                  ? 'Entrer valid email'
                  : null,
            ),

            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.email_outlined),
              label: Text(
                'Reset password',
                style:  TextStyle(fontSize: 24),
              ),
              onPressed: (){
                resetPassword(); 
              },  
            )
          ],
        ),
      ),
    ),
  );

  Future resetPassword() async{
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
      );
    try{
      await FirebaseAuth.instance
    .sendPasswordResetEmail(email: emailController.text.trim());

    //showSnackBar(SnackBar(content: Text('Password reset email sent'))
    Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e){
      print(e);

      //Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
  
}