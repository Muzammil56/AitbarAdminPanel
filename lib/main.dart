import 'package:aitbar_admin_panel/screens/dash_board.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/login.dart';
import 'package:aitbar_admin_panel/Screens/pending_posts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aitbar Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Home(
              index: 0,
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  late int index;

  Home({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    PendingPosts(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      DrawerHeader(
                        child: Text(
                          "Aitbar",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Dashboard
                  Container(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          widget.index = 0;
                        });
                      },
                      title: const Text("Dashboard"),
                    ),
                    color: widget.index == 0 ? Colors.tealAccent : Colors.white,
                  ),
                  //Pending Vehicles
                  Container(
                    color: widget.index == 1 ? Colors.tealAccent : Colors.white,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          widget.index = 1;
                        });
                      },
                      title: const Text("Pending Vehicles"),
                    ),
                  ),
                  // Container(
                  //   color: index == 2 ? Colors.tealAccent : Colors.white,
                  //   child: ListTile(
                  //     onTap: () {
                  //       setState(() {
                  //         index = 2;
                  //       });
                  //     },
                  //     title: Text("Requests"),
                  //   ),
                  // ),
                  // Container(
                  //   color: index == 3 ? Colors.tealAccent : Colors.white,
                  //   child: ListTile(
                  //     onTap: () {
                  //       setState(() {
                  //         index = 3;
                  //       });
                  //     },
                  //     title: Text("Logout"),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(flex: 4, child: _widgetOptions[widget.index])
        ],
      ),
    );
  }
}
