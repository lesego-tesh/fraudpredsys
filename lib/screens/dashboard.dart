import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fraudpredsys/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fraudpredsys/widget/navigation_drawer_widget.dart';
import 'login_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? _userName;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  List<String> menuChoices = ["Sign Out"];

  late String _selectedChoice;
  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(await user!.uid)
        .get()
        .then((value) {
      setState(() {
        loggedInUser = UserModel.fromMap(value.data());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserName();
    /*FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });*/
  }

  void _select(String choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    switch (choice) {
      case 'Sign Out':
        _showLogOutDialog();
        break;
      case 'Delete Account':
        //_showDeleteDialog();
        //showInSnackBar("You have selected $choice");
        break;
    }
    setState(() {
      _selectedChoice = choice;
    });
  }

  void _showLogOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                logout(context);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Administration"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            elevation: 3.2,
            initialValue: menuChoices[0],
            onSelected: (String value) {
              _select(value);
            },
            onCanceled: () {
              if (kDebugMode) {
                print('You have not chosen anything');
              }
            },
            tooltip: 'This is tooltip',
            itemBuilder: (BuildContext context) {
              return menuChoices.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              Text("${loggedInUser.email}",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 15,
              ),
              /*ActionChip(
                  label: const Text("Proceed"),
                  onPressed: () {
                    logout(context);
                  }),*/
            ],
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
