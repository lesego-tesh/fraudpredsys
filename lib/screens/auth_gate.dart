import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fraudpredsys/model/user_model.dart';
import 'package:fraudpredsys/screens/dashboard.dart';
import 'package:fraudpredsys/screens/home_screen.dart';
import 'package:fraudpredsys/screens/login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  UserModel? userModel;
  @override
  void initState() {
    getCurrentUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (userModel!.role == "user")
              ? const HomeScreen()
              : const Dashboard();
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  void getCurrentUserDetails() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .withConverter<UserModel>(
              fromFirestore: (snapshots, _) =>
                  UserModel.fromMap(snapshots.data()!),
              toFirestore: (model, _) => model.toMap())
          .get()
          .then((value) {
        setState(() {
          userModel = value.data();
        });
      }).catchError((error) {});

      if (kDebugMode) {
        print('userModel: ${userModel!.firstName}');
      }
    }
  }
}
