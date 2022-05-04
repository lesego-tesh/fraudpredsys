import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fraudpredsys/page/Upload.dart';
import 'package:fraudpredsys/page/home_page.dart';
import 'package:fraudpredsys/page/user_page.dart';
import 'package:fraudpredsys/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fraudpredsys/screens/home_screen.dart';
import 'package:fraudpredsys/userPages/predict.dart';
import 'package:fraudpredsys/userPages/uploadFile.dart';

class NavigationDrawerWidget extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser;

  final _auth = FirebaseAuth.instance;

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  NavigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const name = '';
    const email = '';

    return Drawer(
      child: Material(
        color: const Color.fromRGBO(50, 75, 205, 1),
        child: FutureBuilder(
            future: _getUserName(),
            builder: (context, AsyncSnapshot<UserModel> userModel) {
              return userModel.connectionState != ConnectionState.done
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : ListView(
                      children: <Widget>[
                        buildHeader(
                          name:
                              "${userModel.data?.firstName} ${userModel.data?.secondName}",
                          email: "${userModel.data?.email}",
                          onClicked: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserPage(
                              name: ' ',
                            ),
                          )),
                        ),
                        Container(
                          padding: padding,
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              buildSearchField(),
                              const SizedBox(height: 24),
                              buildMenuItem(
                                text: 'Home',
                                icon: Icons.home,
                                onClicked: () => selectedItem(context, 0),
                              ),
                              const SizedBox(height: 24),
                              buildMenuItem(
                                text: 'view key performance indicators',
                                icon: Icons.auto_graph,
                                onClicked: () => selectedItem(context, 1),
                              ),
                              const SizedBox(height: 16),
                              buildMenuItem(
                                text: 'predict',
                                icon: Icons.question_mark,
                                onClicked: () => selectedItem(context, 2),
                              ),
                              const SizedBox(height: 16),
                              buildMenuItem(
                                text: 'view file',
                                icon: Icons.view_agenda,
                                onClicked: () => selectedItem(context, 3),
                              ),
                              const SizedBox(height: 16),
                              buildMenuItem(
                                text: 'upload file',
                                icon: Icons.update,
                                onClicked: () => selectedItem(context, 4),
                              ),
                              const SizedBox(height: 24),
                              const Divider(color: Colors.white70),
                              const SizedBox(height: 24),
                              buildMenuItem(
                                text: 'Notifications',
                                icon: Icons.notification_add_outlined,
                                onClicked: () => selectedItem(context, 4),
                              ),
                              /* const SizedBox(height: 16),
                      buildMenuItem(
                        text: 'Notifications',
                        icon: Icons.notifications_outlined,
                        onClicked: () => selectedItem(context, 5),
                      ),*/
                            ],
                          ),
                        ),
                      ],
                    );
            }),
      ),
    );
  }

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

  Widget buildHeader({
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    const color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Predict(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Predict(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Predict(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Uploadfile(),
        ));
        break;
      // case 5:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => PredictionStateful(),
      //   ));
      //   break;
    }
  }
}
