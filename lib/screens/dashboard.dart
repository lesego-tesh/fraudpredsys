import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fraudpredsys/model/user_model.dart';
import 'package:fraudpredsys/page/view.dart';
import 'package:fraudpredsys/page/Upload.dart';
import 'package:fraudpredsys/page/home_page.dart';
import 'package:fraudpredsys/page/settings.dart';

import '../page/user_page.dart';
import 'home_screen.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _currentIndex = 0;
  final List<Widget> _children = [
    home_page(),
    Upload(),
    view(),
    settings(),
  ];

  List<String> menuChoices = ["Sign Out"];

  late String _selectedChoice;
  Future<void> _getUserName() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .withConverter<UserModel>(
          fromFirestore: ((snapshots, _) =>
              UserModel.fromMap(snapshots.data()!)),
          toFirestore: (usermodel, _) => usermodel.toMap(),
        )
        .get()
        .then((value) {
      setState(() {
        loggedInUser = UserModel.fromMap(value.data()!.toMap());
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

  void OnTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
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

      body: _children[_currentIndex],
      //  Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[],
      //     ),
      //   ),
      // ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: OnTappedBar,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda),
            label: 'View',
            backgroundColor: Colors.blue,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.analytics),
          //   label: 'Analysis',
          //   backgroundColor: Colors.blue,
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    //   switch (index) {
    //     case 0:
    //       Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => const HomeScreen(),
    //       ));
    //       break;
    //     case 1:
    //       Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => PeoplePage(),
    //       ));
    //       break;
    //     case 2:
    //       Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => PeoplePage(),
    //       ));
    //       break;
    //     case 3:
    //       Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => PeoplePage(),
    //       ));
    //       break;
    //     case 4:
    //       Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => PeoplePage(),
    //       ));
    //       break;
    //     case 5:
    //       Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => PeoplePage(),
    //       ));
    //       break;
    //   }
  }
}

class OnTappedBar {}
