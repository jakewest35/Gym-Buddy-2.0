import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_buddy_2/screens/previous_data_screen.dart';
import 'package:gym_buddy_2/utilities/firebase_init.dart';
import 'package:gym_buddy_2/utilities/google_authentication.dart';
import 'package:provider/provider.dart';

/// Dashboard page
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    bool loggedIn = Provider.of<UserAuthenticationState>(context).loggedIn;
    if (loggedIn) {
      final userName = FirebaseAuth.instance.currentUser!.displayName;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome back, \n$userName!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 120.0),
              child: Text(
                "Get data from previous days",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: _dateTime,
                maximumDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (date) {
                  setState(() {
                    _dateTime = date;
                  });
                },
              ),
            ),
            SizedBox(
              width: 225.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviousDataPage(
                            date:
                                "${_dateTime.month}-${_dateTime.day}-${_dateTime.year}"),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                child: const Text("Get data"),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Consumer<UserAuthenticationState>(
              builder: (context, appState, _) => GoogleAuthenticationPage(
                  loggedIn: appState.loggedIn,
                  signOut: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ),
          ],
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.fitness_center,
            size: 100.0,
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            "Welcome to Gym-Buddy!",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Consumer<UserAuthenticationState>(
              builder: (context, appState, _) => GoogleAuthenticationPage(
                  loggedIn: appState.loggedIn,
                  signOut: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ),
          ),
        ],
      );
    }
  }
}
