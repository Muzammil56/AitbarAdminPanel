import 'package:aitbar_admin_panel/Screens/pending_posts.dart';
import 'package:aitbar_admin_panel/Services/helping_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aitbar_admin_panel/Services/constants.dart';

import '../main.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(
                          index: 1,
                        ),
                      ));
                },
                child: ReusableContainer(
                  context: context,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Pending Vehicles",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("posts")
                            .where("status", isEqualTo: "Pending")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                              'Something went wrong',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              "Loading",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Total: ",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "${snapshot.data!.size}",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                )
                              ],
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              ),
              ReusableContainer(
                context: context,
                child: Text("ajdajhksdf"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReusableContainer(
                context: context,
                child: Text("sjfajsdgfj"),
              ),
              ReusableContainer(
                context: context,
                child: Text("ajdajhksdf"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
