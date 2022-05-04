import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fraudpredsys/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fraudpredsys/widget/navigation_drawer_widget.dart';
import 'login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  String? _userName;
  UserModel? loggedInUser;

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
      backgroundColor: Color.fromARGB(239, 219, 215, 215),
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
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: FutureBuilder(
      //         future: _getUserName(),
      //         builder: (context, AsyncSnapshot<UserModel> userModel) {
      //           return userModel.connectionState != ConnectionState.done
      //               ? const Center(
      //                   child: CircularProgressIndicator.adaptive(),
      //                 )
      //               : Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: <Widget>[

      //                ],
      //                 );
      //         }),
      //   ),

      // ),

      body: ListView(
        children: [
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaGLGy-YSDIDNhbimW7f7D3b4XH1wsKqbfo42T6IlRcptJ53H0St2-q4V8cCGVxjslSIQ&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //2nd Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRd_mjaG2cxqI_P55EJMtxMICh3-__Q_jLNVNnxvtFBtqyi4DZanMGIU3KQV8AkZ0BPJg&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //3rd Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ750GJXElPUyldC4802NNTjOKxxERb1fAm8-pFOF25cppoPLV3JoX3ABlg-3_vXqeLvRc&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //4th Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM-6-6_vXuk7_S4zTT6xHK_Lg5PIpkp_NZ0hwj6pMS-zahAOHBkwCSIo1fKgF1h7iokq8&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //5th Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy6nPywwywG8Q0hyfNa16pj1fBSRIrai7QCtyKIAXInfldARPHfMru6IgNQT68rL3QKIk&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
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
}
