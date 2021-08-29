import 'package:b/chanceScreen/detals.dart';
import 'package:b/postSecreen/postDetals.dart';
import 'package:b/postSecreen/postUpdate.dart';
import 'package:b/screen/My_profile.dart';
import 'package:b/search.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const _horizontalPadding = 32.0;
const _carouselItemMargin = 8.0;

class ShowingPost extends StatefulWidget {
  @override
  _ShowingPostState createState() => _ShowingPostState();
}

class _ShowingPostState extends State<ShowingPost> {
  String y, k;

  var list = new List();
  var listData = new Map();

  getdata() async {
    await FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        list.add(element.data()["title"]);
        listData[element.data()["title"]] = element.data();
      });
    });
  }

  get_Token() async {
    FirebaseFirestore.instance
        .collection("oner")
        .doc("DPi7T09bNPJGI0lBRqx4")
        .get()
        .then((value) {
      y = value.data()['token'];
    });

    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    var userr = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: userr.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          k = element.data()['company'];
        });
      });
    });
  }

  void initState() {
    get_Token();
    getdata();
    super.initState();
  }

  Delete_Post(List lis) async {
    var data = Provider.of<MyProvider>(context, listen: false).data;

    FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post")
        .doc(lis[currentPage]["id"])
        .delete();

    delete_Post(lis[currentPage]["id"]);

    sendMessage(
        "حذف بوست",
        "  تم حذف بوست  ${lis[currentPage]['title']}  من قبل الشركه  ${k}",
        Provider.of<MyProvider>(context, listen: false).company_id,
        lis[currentPage]['title'],
        lis[currentPage]["id"]);
  }

  alert_delete(context, List lis) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Text(
                        "هل تريد حذف البوست ",
                        style: TextStyle(
                            color: Colors.black, fontStyle: FontStyle.italic),
                      ),
                    ],
                  )),
              content: Container(
                height: 20,
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal[50],
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () => setState(() {
                      Navigator.of(context).pop();
                    }),
                    child: Text(
                      "لا",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal[50],
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () {
                      Delete_Post(lis);
                      setState(() {
                        Navigator.of(context).pop();
                        //currentPage = currentPage + 1;
                        setState(() {});

                        // Navigator.of(context).pop();
                        // Navigator.push(context,
                        //     new MaterialPageRoute(builder: (context) => HomePage()));
                        //
                        //
                      });
                    },
                    child: Text(
                      '  نعم',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ]);
        });
  }

  delete_Post(var post_id) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    CollectionReference company =
        FirebaseFirestore.instance.collection('companies');
    ////////////delete from posts_saved
    List user_Id = [];
    await user.get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          user_Id.add(element.id);
        });
      }
    });
    for (int k = 0; k < user_Id.length; k++) {
      await user
          .doc(user_Id[k])
          .collection('posts_saved')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (int j = 0; j < value.docs.length; j++) {
            print('____________________________');
            print(value.docs[j].data()['post_Id']);
            if (value.docs[j].data()['post_Id'] == post_id) {
              print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
              user
                  .doc(user_Id[k])
                  .collection('posts_saved')
                  .where("post_Id", isEqualTo: post_id)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  user
                      .doc(user_Id[k])
                      .collection('posts_saved')
                      .doc(element.id)
                      .delete()
                      .then((value) {
                    print("Success!");
                  });
                });
              });
            }
          }
        }
      });
    }
    print("**********************");
    /////////delete from notification
    for (int k = 0; k < user_Id.length; k++) {
      await user
          .doc(user_Id[k])
          .collection('notifcation')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (int j = 0; j < value.docs.length; j++) {
            if (value.docs[j].data()['id'] == post_id) {
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
              user
                  .doc(user_Id[k])
                  .collection('notifcation')
                  .where("id", isEqualTo: post_id)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  user
                      .doc(user_Id[k])
                      .collection('notifcation')
                      .doc(element.id)
                      .delete()
                      .then((value) {
                    print("Success!");
                  });
                });
              });
            }
          }
        }
      });
    }
  }

  sendMessage(
      String title, String body, String u, String c, String id_post) async {
    var data = Provider.of<MyProvider>(context, listen: false).data;

    var serverToken =
        "AAAAUnOn5ZE:APA91bGSkIL6DLpOfbulM_K3Yp5W1mlcp8F0IWu2mcKWloc4eQcF8C230XaHhXBfBYphuyp2P92dc_Js19rBEuU6UqPBGYOSjJfXsBJVmIu9TsLe44jaSOLDAovPTspwePb1gw7-1GNZ";
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(<String, dynamic>{
          'notification': {
            'title': title.toString(),
            'body': body.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'flutter notifcation_click',
            'id': id_post,
            'num': "1",
            'type': "2",
          },
          'to': await y,
        }));
  }

  CollectionReference comp;
  int currentPage = 0;

  Widget done(lis, int i) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: 130,
        width: 150,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(left: 20, bottom: 10),
          height: 130,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          child: Center(
            child: InkWell(
              child: ListTile(
                title: Text(
                  lis["title"],
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              onTap: () {
                setState(() {
                  currentPage = i;
                });
              },
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: AppBar(
                actions: [
                  IconButton(
                      tooltip: 'Search',
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        await showSearch(
                            context: context,
                            delegate: datasearch(list, listData, 2));
                      }),
                ],
                title: Center(
                  child: Text(" "),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60.0),
                  ),
                ),
              ),
            ),
            body: Stack(children: [
              Opacity(
                opacity: 0.4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: new AssetImage("images/55.jpeg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Color(0xFF5C6BC0), BlendMode.overlay))),
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("companies")
                      .doc(Provider.of<MyProvider>(context, listen: false)
                          .company_id)
                      .collection("Post")
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return Center(
                        child: Text("لم يتم نشر أي منشور"),
                      );
                    else if (snapshot.hasData)
                      return ff(snapshot.data.docs);
                    else
                      return Center(child: CircularProgressIndicator());
                  }),
            ])));
  }

  ff(lis) {
    Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
              color: Colors.black12,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      done(lis[i], i),
                    ],
                  );
                },
                itemCount: lis.length,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  margin: EdgeInsets.only(left: 22, right: 22),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Center(
                              child: Text(
                                lis[currentPage]["title"],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(lis[currentPage]["myPost"]),
                          ),
                          ButtonBar(
                            children: [
                              Text(
                                lis[currentPage]["date_publication"]['day']
                                        .toString() +
                                    "/" +
                                    lis[currentPage]["date_publication"]
                                            ['month']
                                        .toString() +
                                    "/" +
                                    lis[currentPage]["date_publication"]['year']
                                        .toString(),
                              )
                            ],
                          ),
                        ],
                      ))),
            ),
          ),
          Row(children: [
            SizedBox(
              width: 70.0,
            ),
            Container(
                width: 120.00,
                child: RaisedButton(
                    onPressed: () async {
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false).data =
                            lis[currentPage].data();
                      });
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PostUpdate();
                      }));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    elevation: 0.0,
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Theme.of(context).primaryColor,
                              Colors.amber
                            ]),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "تعديل",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ))),
            SizedBox(
              width: 20.0,
            ),
            Container(
              width: 120.00,
              child: RaisedButton(
                  onPressed: () async {
                    alert_delete(context, lis);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  elevation: 0.0,
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Theme.of(context).primaryColor,
                            Colors.amber
                          ]),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "حذف",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  )),
            ),
          ]),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
