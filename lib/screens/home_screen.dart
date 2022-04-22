import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fraudpredsys/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fraudpredsys/widget/navigation_drawer_widget.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;
  UserModel loggedInUser = UserModel();

  List<String> menuChoices = ["Sign Out"];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _selectedChoice;
  Future<UserModel> _getUserName() async {
    if (kDebugMode) {
      print("Starting to get User....");
    }
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .withConverter<UserModel>(
          fromFirestore: ((snapshots, _) =>
              UserModel.fromMap(snapshots.data()!)),
          toFirestore: (usermodel, _) => usermodel.toMap(),
        )
        .get()
        .then((value) {
      if (kDebugMode) {
        print(
            "User is : ${UserModel.fromMap(value.data()!.toMap()).firstName}");
      }
      return UserModel.fromMap(value.data()!.toMap());
    });
  }

  @override
  void initState() {
    super.initState();
    // _getUserName();
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
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Welcome"),
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
          child: FutureBuilder(
              future: _getUserName(),
              builder: (context, AsyncSnapshot<UserModel> userModel) {
                return userModel.connectionState != ConnectionState.done
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(
                          //   height: 150,
                          //   child: Image.asset("assets/logo.png", fit: BoxFit.contain),
                          // ),
                          // const Text(
                          //   "Welcome, let's go",
                          //   style:
                          //       const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Text("${userModel.data?.firstName} ${userModel.data?.secondName}",
                          //     style: const TextStyle(
                          //       color: Colors.black54,
                          //       fontWeight: FontWeight.w500,
                          //     )),
                          // Text("${userModel.data?.email}",
                          //     style: const TextStyle(
                          //       color: Colors.black54,
                          //       fontWeight: FontWeight.w500,
                          //     )),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          /*ActionChip(
                      label: const Text("Proceed"),
                      onPressed: () {
                        logout(context);
                      }),*/
                        ],
                      );
              }),
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
