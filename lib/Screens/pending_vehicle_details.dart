import 'package:aitbar_admin_panel/Services/constants.dart';
import 'package:aitbar_admin_panel/Services/helping_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aitbar_admin_panel/Screens/enlarge_images.dart';
import 'package:aitbar_admin_panel/Services/helper_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'enlarge_images.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PendingVehicleDetails extends StatefulWidget {
  final List images, driverPic;
  final String name,
      email,
      phone,
      dailyPrice,
      driverCNIC,
      driverLicenceNumber,
      driverName,
      driverPhone,
      howToTravel,
      monthlyPrice,
      travelLimit,
      vehicleColor,
      vehicleModel,
      vehicleType,
      weeklyPrice,
      docID;

  const PendingVehicleDetails({
    Key? key,
    required this.images,
    required this.name,
    required this.email,
    required this.phone,
    required this.dailyPrice,
    required this.driverCNIC,
    required this.driverLicenceNumber,
    required this.driverName,
    required this.driverPhone,
    required this.driverPic,
    required this.howToTravel,
    required this.monthlyPrice,
    required this.travelLimit,
    required this.vehicleColor,
    required this.vehicleModel,
    required this.vehicleType,
    required this.weeklyPrice,
    required this.docID,
  }) : super(key: key);

  @override
  _PendingVehicleDetailsState createState() => _PendingVehicleDetailsState();
}

class _PendingVehicleDetailsState extends State<PendingVehicleDetails> {
  final controller = CarouselController();
  int activeIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Scaffold(
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20,),
                    Text("Deleting All Data"),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: kBGColor,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Vehicle Details",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 15,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              previous();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnlargeImages(
                                    enlargeImages: widget.images,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.height / 2,
                              height: MediaQuery.of(context).size.height / 3,
                              child: CarouselSlider.builder(
                                carouselController: controller,
                                itemCount: widget.images.length,
                                itemBuilder: (context, index, realIndex) {
                                  final urlImage = widget.images[index];
                                  return buildImage(urlImage, index);
                                },
                                options: CarouselOptions(
                                  initialPage: 0,
                                  height:
                                      MediaQuery.of(context).size.height / 2.1,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (index, reason) =>
                                      setState(() => activeIndex = index),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              next();
                            },
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Name: "),
                                      Text("${widget.name}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Email: "),
                                      Text("${widget.email}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("phone: "),
                                      Text("${widget.phone}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("How To Travel: "),
                                      Text("${widget.howToTravel}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Travel Limit: "),
                                      Text("${widget.travelLimit}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Vehicle Type: "),
                                      Text("${widget.vehicleType}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Vehicle Model: "),
                                      Text("${widget.vehicleModel}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Vehicle Color: "),
                                      Text("${widget.vehicleColor}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Daily Price: "),
                                      Text("${widget.dailyPrice}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Weekly Price: "),
                                      Text("${widget.weeklyPrice}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Monthly Price: "),
                                      Text("${widget.monthlyPrice}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "DriverDetails",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EnlargeImages(
                                        enlargeImages: widget.driverPic),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.height / 4,
                                height: MediaQuery.of(context).size.height / 4,
                                child: CachedNetworkImage(
                                  imageUrl: widget.driverPic[0],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Driver Name: "),
                                      Text(widget.driverName)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Driver CNIC: "),
                                      Text(widget.driverCNIC)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Driver Phone"),
                                      Text(widget.driverPhone)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Driving Licence Number: "),
                                      Text(widget.driverLicenceNumber)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ReusableButton(
                                  text: 'Approve',
                                  color: Colors.green,
                                  onPressed: () {
                                    print("approve");
                                    vehicleApprove();
                                  }),
                              ReusableButton(
                                  text: 'deny',
                                  color: Colors.red,
                                  onPressed: () {
                                    print("deny");
                                    _displayTextInputDialog(context);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  TextEditingController message = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Causes of Denying vehicle'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              // onChanged: (value) {
              //   setState(() {
              //     message.text = value;
              //   });
              // },
              autovalidateMode: AutovalidateMode.always,
              controller: message,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Input Some text";
                }
              },
              maxLines: null,
              decoration: InputDecoration(hintText: "Enter Text Here"),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  if (_formKey.currentState!.validate()) {
                    createSupportInboxCollection();
                    setState(() {
                      isLoading = true;
                    });
                  } else {
                    print("not Validate");
                  }
                  // sendMessageForDenyingVehicle();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void createSupportInboxCollection() {
    Navigator.pop(context);
    final Map<String, dynamic> senderDataMap = {
      "vehicleModel": widget.vehicleModel,
      "email": widget.email,
      "message": "Your ${widget.vehicleModel} has been denied because ${message.text}",
      "time" : DateTime.now().millisecondsSinceEpoch,
    };
    FirebaseFirestore.instance
        .collection("supportInbox")
        .doc()
        .set(senderDataMap)
        .then((value) => {
      updateStatus(),
            });
  }

  // late List picsData;

  // void deleteVehiclePics() async {
  //    var postData = await FirebaseFirestore.instance
  //       .collection("posts")
  //       .doc(widget.docID)
  //       .get();
  //    picsData = postData["pics"];
  //    picsData.forEach((element) {
  //      FirebaseStorage.instance.refFromURL(element).delete();
  //    });
  //    deleteDriverPic(postData);
  // }
  //
  // void deleteDriverPic(dynamic postData)async {
  //   await FirebaseStorage.instance.refFromURL(postData["driverPic"][0]).delete();
  //   deletePost();
  // }

  void updateStatus(){
    FirebaseFirestore.instance.collection("posts").doc(widget.docID).update({"status": "Denied"}).then((value) => {
      getToken(message.text),
    });
  }

  void vehicleApprove() {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.docID)
        .update({"status": "Available"}).then((value) => {
              Navigator.pop(context),
              Helper().message(context, "Vehicle Approved"),
            });
  }

  Widget buildImage(String urlImage, int index) => Container(
        width: MediaQuery.of(context).size.width / 4,
        margin: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey,
        child: CachedNetworkImage(
          imageUrl: urlImage,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );

  next() => controller.nextPage();

  previous() => controller.previousPage();

  getToken(String messageBody) async {
    FirebaseFirestore.instance
        .collection('tokens')
        .doc(widget.email)
        .get()
        .then((value) =>
    {sendNotification(value.data()!['token'], messageBody,)});
  }

  Future<void> sendNotification(token, String messageBody) async {
    final data = {
      "notification": {"body": "Your ${widget.vehicleModel} has been denied because $messageBody", "title": "Phalsa Team"},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "userId": widget.email,
        "userName": widget.name,
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'key=AAAAgr0cR8Q:APA91bFUresfbN8NhD2HkoDul-2XIgK4bSH5X-tbWcwnJNCrTRV0BW2D1ecsDQLCxREw7H-eHw9Vx1Up8DMLq6UFwVSj1nm2jCJpuvgSHTbVzb7IwFxis6nj_D3WHLHIexHkTTK8lBjn'
    };

    try {
      final response = await http.post(
          Uri.https('fcm.googleapis.com', '/fcm/send'),
          body: jsonEncode(data),
          headers: headers);

      if (response.statusCode == 200) {
        print('Request Sent To person');
      } else {
        print('notification sending failed');
        // on failure do sth
      }
    } catch (e) {
      print('exception $e');
    }
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

}
