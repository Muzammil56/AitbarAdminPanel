import 'package:aitbar_admin_panel/Screens/pending_vehicle_details.dart';
import 'package:aitbar_admin_panel/Services/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingPosts extends StatefulWidget {
  const PendingPosts({Key? key}) : super(key: key);

  @override
  _PendingPostsState createState() => _PendingPostsState();
}

class _PendingPostsState extends State<PendingPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Pending Vehicles",
              style: TextStyle(fontSize: 30),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .where("status", isEqualTo: "Pending")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Something went wrong',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    "Loading",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    shrinkWrap: true,
                    // itemExtent: MediaQuery.of(context).size.height / 5,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PendingVehicleDetails(
                                images: snapshot.data!.docs[index]["pics"],
                                name: snapshot.data!.docs[index]["name"].toString(),
                                howToTravel: snapshot.data!.docs[index]["howToTravel"].toString(),
                                dailyPrice: snapshot.data!.docs[index]["dailyPrice"].toString(),
                                driverCNIC: snapshot.data!.docs[index]["driverCNIC"].toString(),
                                driverLicenceNumber: snapshot.data!.docs[index]["driverLicenceNumber"].toString(),
                                driverName: snapshot.data!.docs[index]["driverName"].toString(),
                                driverPhone: snapshot.data!.docs[index]["driverPhone"].toString(),
                                driverPic: snapshot.data!.docs[index]["driverPic"],
                                email: snapshot.data!.docs[index]["email"].toString(),
                                monthlyPrice: snapshot.data!.docs[index]["monthlyPrice"].toString(),
                                phone: snapshot.data!.docs[index]["phone"].toString(),
                                travelLimit: snapshot.data!.docs[index]["travelLimit"].toString(),
                                vehicleColor: snapshot.data!.docs[index]["vehicleColor"].toString(),
                                vehicleModel: snapshot.data!.docs[index]["vehicleModel"].toString(),
                                vehicleType: snapshot.data!.docs[index]["vehicleType"].toString(),
                                weeklyPrice: snapshot.data!.docs[index]["weeklyPrice"].toString(),
                                docID: snapshot.data!.docs[index].id,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.docs[index]["pics"][1],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  width: MediaQuery.of(context).size.height / 5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Text(
                                "${snapshot.data!.docs[index]["vehicleModel"]}"),
                          ],
                        ),
                      );

                      // ListTile(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => PendingVehicleDetails(
                      //           images: snapshot.data!.docs[index]["pics"],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   leading: CachedNetworkImage(
                      //     imageUrl: snapshot.data!.docs[index]["pics"][1],
                      //     imageBuilder: (context, imageProvider) => Container(
                      //       height: MediaQuery.of(context).size.height / 5,
                      //       width: MediaQuery.of(context).size.height / 5,
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //             image: imageProvider,
                      //             fit: BoxFit.cover,
                      //             // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      //         ),
                      //       ),
                      //     ),
                      //     placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      //     errorWidget: (context, url, error) => Icon(Icons.error),
                      //   ),
                      //   title: Text(
                      //     "${snapshot.data!.docs[index]["vehicleModel"]}",
                      //     style: TextStyle(
                      //       fontSize: MediaQuery.of(context).size.height / 10
                      //     ),
                      //   ));
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
