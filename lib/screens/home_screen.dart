import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fraudpredsys/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fraudpredsys/widget/navigation_drawer_widget.dart';
import 'login_screen.dart';
// import 'package:fraudpredsys/model/card_model.dart';
// import 'package:fraudpredsys/model/operation_model.dart';
// import 'package:fraudpredsys/model/transaction_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_fonts/google_fonts.dart';

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
                       //============================
              //          // Card Section
              // SizedBox(
              //   height: 25,
              // ),

              // Padding(
              //   padding: EdgeInsets.only(left: 16, bottom: 16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         'Good Morning',
              //         style: GoogleFonts.inter(
              //             fontSize: 18,
              //             fontWeight: FontWeight.w500,
              //             color: kBlackColor),
              //       ),
              //       Text(
              //         'Amanda Alex',
              //         style: GoogleFonts.inter(
              //             fontSize: 30,
              //             fontWeight: FontWeight.w700,
              //             color: kBlackColor),
              //       )
              //     ],
              //   ),
              // ),

              // Container(
              //   height: 199,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: EdgeInsets.only(left: 16, right: 6),
              //     itemCount: cards.length,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         margin: EdgeInsets.only(right: 10),
              //         height: 199,
              //         width: 344,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(28),
              //           color: Color(cards[index].cardBackground),
              //         ),
              //         child: Stack(
              //           children: <Widget>[
              //             Positioned(
              //               child: SvgPicture.asset(cards[index].cardElementTop),
              //             ),
              //             Positioned(
              //               bottom: 0,
              //               right: 0,
              //               child:
              //                   SvgPicture.asset(cards[index].cardElementBottom),
              //             ),
              //             Positioned(
              //               left: 29,
              //               top: 48,
              //               child: Text(
              //                 'CARD NUMBER',
              //                 style: GoogleFonts.inter(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w400,
              //                     color: kWhiteColor),
              //               ),
              //             ),
              //             Positioned(
              //               left: 29,
              //               top: 65,
              //               child: Text(
              //                 cards[index].cardNumber,
              //                 style: GoogleFonts.inter(
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.w700,
              //                     color: kWhiteColor),
              //               ),
              //             ),
              //             Positioned(
              //               right: 21,
              //               top: 35,
              //               child: Image.asset(
              //                 cards[index].cardType,
              //                 width: 27,
              //                 height: 27,
              //               ),
              //             ),
              //             Positioned(
              //               left: 29,
              //               bottom: 45,
              //               child: Text(
              //                 'CARD HOLDERNAME',
              //                 style: GoogleFonts.inter(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w400,
              //                     color: kWhiteColor),
              //               ),
              //             ),
              //             Positioned(
              //               left: 29,
              //               bottom: 21,
              //               child: Text(
              //                 cards[index].user,
              //                 style: GoogleFonts.inter(
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.w700,
              //                     color: kWhiteColor),
              //               ),
              //             ),
              //             Positioned(
              //               left: 202,
              //               bottom: 45,
              //               child: Text(
              //                 'EXPIRY DATE',
              //                 style: GoogleFonts.inter(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w400,
              //                     color: kWhiteColor),
              //               ),
              //             ),
              //             Positioned(
              //               left: 202,
              //               bottom: 21,
              //               child: Text(
              //                 cards[index].cardExpired,
              //                 style: GoogleFonts.inter(
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.w700,
              //                     color: kWhiteColor),
              //               ),
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //   ),


              //          //===========================
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
