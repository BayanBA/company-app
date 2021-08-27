import 'dart:convert';

import 'package:b/postSecreen/postUpdate.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chanceScreen/detals.dart';
import 'chanceScreen/updatChanceT.dart';
import 'chanceScreen/updatChanceV.dart';
import 'chanceScreen/updatData.dart';
import 'employeeSecreen/acceptable.dart';
import 'employeeSecreen/applicants.dart';
import 'package:http/http.dart' as http;

class datasearch extends SearchDelegate<String> {
  var bayan;
  GlobalKey<FormState> ff = new GlobalKey<FormState>();
  GlobalKey<FormState> ff1 = new GlobalKey<FormState>();

  var list = new List();
  int sana;
  var listData = new Map();

  datasearch(this.list, this.listData, this.sana);

  String y, k;

  delete_chance(var chance_id) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    CollectionReference company =
        FirebaseFirestore.instance.collection('companies');
    ////////////delete from chance_saved
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
          .collection('chance_saved')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (int j = 0; j < value.docs.length; j++) {
            if (value.docs[j].data()['chance_Id'] == chance_id) {
              user
                  .doc(user_Id[k])
                  .collection('chance_saved')
                  .where("chance_Id", isEqualTo: chance_id)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  user
                      .doc(user_Id[k])
                      .collection('chance_saved')
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
    /////////delete from notification
    for (int k = 0; k < user_Id.length; k++) {
      await user
          .doc(user_Id[k])
          .collection('notifcation')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (int j = 0; j < value.docs.length; j++) {
            if (value.docs[j].data()['id'] == chance_id) {
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
              user
                  .doc(user_Id[k])
                  .collection('notifcation')
                  .where("id", isEqualTo: chance_id)
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
        // setState(() {
        k = element.data()['company'];

        //  });
      });
    });
  }

  void initState() {
    get_Token();
    // super.initState();
  }

  Delete_Chance(context) async {
    var data = Provider.of<MyProvider>(context, listen: false).data;

    await FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("chance")
        .doc(data['id'])
        .delete();

    delete_chance(data['id']);

    sendMessage(
        "حذف فرصه",
        "  تم حذف فرصه  ${data['title']}  من قبل الشركه  ${k}",
        Provider.of<MyProvider>(context, listen: false).company_id,
        data['title'],
        context);
  }

  alert_delete(context) {
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
                        "هل تريد حذف الفرصه ",
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
                    onPressed: () {
                      //setState(() {
                      Navigator.of(context).pop();
                      // });
                    },
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
                    onPressed: () async {
                      await Delete_Chance(context);

                      Navigator.of(context).pop();
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

  sendMessage(String title, String body, String u, String c, context) async {
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
            // 'id_company': Provider.of<MyProvider>(context, listen: false).company_id,
            'id': data["id"],
            'num': "1",
            'type': "3",
          },
          'to': await y,
        }));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var data = bayan;

    Size size = MediaQuery.of(context).size;

    return sana == 1
        ? bayan["chanceId"] == 0
            ? Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(40.0),
                      child: AppBar(
                        title: Center(
                          child: Text(" "),
                        ),
                      ),
                    ),
                    body: Column(children: [
                      Stack(
                        children: [
                          Column(
                            children: <Widget>[
                              ClipPath(
                                clipper: MyClipper(),
                                child: Container(
                                  height: size.height * 0.2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              Center(
                                child: Text(
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .data["title"],
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 70, right: 150),
                            child: CircleAvatar(
                                child: CircleAvatar(
                                    child: Icon(Icons.apartment,
                                        size: 80, color: Colors.lime),
                                    radius: 50,
                                    backgroundColor: Colors.white),
                                radius: 60,
                                backgroundColor: Colors.black
                                //Theme.of(context).primaryColor,
                                ),
                          ),
                          Positioned(
                            top: 155,
                            left: 160,
                            child: CircleAvatar(
                                child: InkWell(
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return UpdatData();
                                    }));
                                    // setState(() {
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .data = Provider.of<MyProvider>(context,
                                            listen: false)
                                        .data;
                                    // });
                                  },
                                ),
                                radius: 25,
                                backgroundColor: Colors.black),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.all(30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "أوقات العمل :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .data["workTime"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.attach_money_rounded,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "الراتب:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .data["salary"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.local_library_outlined,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              " المهارات :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .data["skillNum"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.language,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "اللغات :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    Provider.of<MyProvider>(
                                                            context,
                                                            listen: false)
                                                        .data["langNum"]
                                                        .length;
                                                i++)
                                              Text(
                                                Provider.of<MyProvider>(context,
                                                            listen: false)
                                                        .data["langNum"]
                                                        .elementAt(i) +
                                                    " , ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.wallet_giftcard,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "عدد الشواغر :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              "    ${Provider.of<MyProvider>(context, listen: false).data["Vacancies"]}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.account_circle_outlined,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "المتقدمين :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${Provider.of<MyProvider>(context, listen: false).data["Presenting_A_Job"].length}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.wb_incandescent_outlined,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "الوصف :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .data["describsion"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "التخصص المطلوب: :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .data["specialties"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.perm_contact_cal,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "المستوى العلمي :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .data["degree"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.account_balance_outlined,
                                              size: 30, color: Colors.black),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "المستوى الوظيفي المطلوب :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 30),
                                        child: Row(
                                          children: [
                                            Text(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .data["level"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Theme.of(context).primaryColor,
                                        thickness: 2,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(children: [
                                        Container(
                                          width: 110,
                                          height: 60,
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80.0)),
                                              elevation: 0.0,
                                              padding: EdgeInsets.all(0.0),
                                              child: Ink(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerRight,
                                                      end: Alignment.centerLeft,
                                                      colors: [
                                                        Theme.of(context)
                                                            .primaryColor,
                                                        Colors.amber
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 300.0,
                                                      minHeight: 50.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "المتقدمين",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .setchanc_id(
                                                        Provider.of<MyProvider>(
                                                                context,
                                                                listen: false)
                                                            .data["id"]);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return Applicants();
                                                }));
                                              }),
                                        ),
                                        SizedBox(width: 25),
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          child: FlatButton(
                                              child: Text(
                                                "للحذف",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                alert_delete(context);
                                              }),
                                        ),
                                        SizedBox(width: 25),
                                        Container(
                                          width: 110,
                                          height: 60,
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80.0)),
                                              elevation: 0.0,
                                              padding: EdgeInsets.all(0.0),
                                              child: Ink(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerRight,
                                                      end: Alignment.centerLeft,
                                                      colors: [
                                                        Theme.of(context)
                                                            .primaryColor,
                                                        Colors.amber
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 300.0,
                                                      minHeight: 50.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "المقبولين",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .setchanc_id(
                                                        Provider.of<MyProvider>(
                                                                context,
                                                                listen: false)
                                                            .data["id"]);

                                                Provider.of<MyProvider>(context,
                                                            listen: false)
                                                        .data1 =
                                                    Provider.of<MyProvider>(
                                                            context,
                                                            listen: false)
                                                        .data;
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return Acceptable();
                                                }));
                                              }),
                                        ),
                                      ])
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ])))
            : bayan["chanceId"] == 1
                ? Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(40.0),
                        child: AppBar(
                          title: Center(
                            child: Text(" "),
                          ),
                        ),
                      ),
                      body: Column(
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: <Widget>[
                                  ClipPath(
                                    clipper: MyClipper(),
                                    child: Container(
                                      //margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
                                      height: size.height * 0.2,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Center(
                                    child: Text(
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .data["title"],
                                      style: TextStyle(fontSize: 35),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 70, right: 150),
                                child: CircleAvatar(
                                    child: CircleAvatar(
                                        child: Icon(Icons.apartment,
                                            size: 80, color: Colors.lime),
                                        radius: 50,
                                        backgroundColor: Colors.white),
                                    radius: 60,
                                    backgroundColor: Colors.black
                                    //Theme.of(context).primaryColor,
                                    ),
                              ),
                              Positioned(
                                top: 150,
                                left: 160,
                                child: CircleAvatar(
                                    child: CircleAvatar(
                                      child: FloatingActionButton(
                                        heroTag: "tag30",
                                        child: Icon(
                                          Icons.edit,
                                          color: Theme.of(context).primaryColor,
                                          size: 30,
                                        ),
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return UpdatDataV();
                                          }));
                                          //setState(() {
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .data = Provider.of<MyProvider>(
                                                  context,
                                                  listen: false)
                                              .data;
                                          // });
                                        },
                                      ),
                                    ),
                                    radius: 25,
                                    backgroundColor: Colors.black),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView(children: [
                              Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "أوقات العمل :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .data["workTime"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.local_library_outlined,
                                                  size: 30,
                                                  color: Colors.black),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                " المهارات :",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 30),
                                            child: Row(
                                              children: [
                                                Text(
                                                  Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .data["skillNum"],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.language,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "اللغات :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .data["langNum"]
                                                          .length;
                                                  i++)
                                                Text(
                                                  Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .data["langNum"]
                                                          .elementAt(i) +
                                                      " , ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.account_circle_outlined,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "المتقدمين :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${Provider.of<MyProvider>(context, listen: false).data["Presenting_A_Job"].length}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.wallet_giftcard,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "عدد الشواغر :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                "    ${Provider.of<MyProvider>(context, listen: false).data["Vacancies"]}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(children: [
                                          Icon(
                                            Icons.wb_incandescent_outlined,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "الوصف :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(children: [
                                          Flexible(
                                            child: Text(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .data["describsion"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(children: [
                                          Container(
                                            width: 110,
                                            height: 60,
                                            child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.0)),
                                                elevation: 0.0,
                                                padding: EdgeInsets.all(0.0),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerRight,
                                                        end: Alignment
                                                            .centerLeft,
                                                        colors: [
                                                          Theme.of(context)
                                                              .primaryColor,
                                                          Colors.amber
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 300.0,
                                                        minHeight: 50.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "المتقدمين",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return Applicants();
                                                  }));
                                                }),
                                          ),
                                          SizedBox(width: 25),
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            child: FlatButton(
                                                child: Text(
                                                  "للحذف",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  alert_delete(context);
                                                }),
                                          ),
                                          SizedBox(width: 25),
                                          Container(
                                            width: 110,
                                            height: 60,
                                            child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.0)),
                                                elevation: 0.0,
                                                padding: EdgeInsets.all(0.0),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerRight,
                                                        end: Alignment
                                                            .centerLeft,
                                                        colors: [
                                                          Theme.of(context)
                                                              .primaryColor,
                                                          Colors.amber
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 300.0,
                                                        minHeight: 50.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "المقبولين",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .data1 =
                                                      Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .data;
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return Acceptable();
                                                  }));
                                                }),
                                          ),
                                        ])
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(40.0),
                        child: AppBar(
                          title: Center(
                            child: Text(" "),
                          ),
                        ),
                      ),
                      body: Column(
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: <Widget>[
                                  ClipPath(
                                    clipper: MyClipper(),
                                    child: Container(
                                      //margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
                                      height: size.height * 0.2,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Center(
                                    child: Text(
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .data["title"],
                                      style: TextStyle(fontSize: 35),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 70, right: 150),
                                child: CircleAvatar(
                                    child: CircleAvatar(
                                        child: Icon(Icons.apartment,
                                            size: 80, color: Colors.lime),
                                        radius: 50,
                                        backgroundColor: Colors.white),
                                    radius: 60,
                                    backgroundColor: Colors.black
                                    //Theme.of(context).primaryColor,
                                    ),
                              ),
                              Positioned(
                                top: 150,
                                left: 160,
                                child: CircleAvatar(
                                    child: CircleAvatar(
                                      child: FloatingActionButton(
                                        heroTag: "tag30",
                                        child: Icon(
                                          Icons.edit,
                                          color: Theme.of(context).primaryColor,
                                          size: 30,
                                        ),
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Provider.of<MyProvider>(
                                                            context,
                                                            listen: false)
                                                        .data["chanceId"] ==
                                                    0
                                                ? UpdatData()
                                                : Provider.of<MyProvider>(
                                                                context,
                                                                listen: false)
                                                            .data["chanceId"] ==
                                                        1
                                                    ? UpdatDataV()
                                                    : UpdatDataT();
                                          }));
                                          //  setState(() {
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .data = Provider.of<MyProvider>(
                                                  context,
                                                  listen: false)
                                              .data;
                                          //});
                                        },
                                      ),
                                    ),
                                    radius: 25,
                                    backgroundColor: Colors.black),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView(children: [
                              Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "أوقات العمل :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .data["workTime"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.local_library_outlined,
                                                  size: 30,
                                                  color: Colors.black),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                " المهارات :",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 30),
                                            child: Row(
                                              children: [
                                                Text(
                                                  Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .data["skillNum"],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.language,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "اللغات :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .data["langNum"]
                                                          .length;
                                                  i++)
                                                Text(
                                                  Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .data["langNum"]
                                                          .elementAt(i) +
                                                      " , ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.account_circle_outlined,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "المتقدمين :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${Provider.of<MyProvider>(context, listen: false).data["Presenting_A_Job"].length}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.wallet_giftcard,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "عدد الشواغر :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                "    ${Provider.of<MyProvider>(context, listen: false).data["Vacancies"]}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(children: [
                                          Icon(
                                            Icons.wb_incandescent_outlined,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "الوصف :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(children: [
                                          Flexible(
                                            child: Text(
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .data["describsion"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "التخصص المطلوب: :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .data["specialties"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.perm_contact_cal,
                                                size: 30, color: Colors.black),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "المستوى العلمي :",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .data["degree"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                          thickness: 2,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(children: [
                                          Container(
                                            width: 110,
                                            height: 60,
                                            child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.0)),
                                                elevation: 0.0,
                                                padding: EdgeInsets.all(0.0),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerRight,
                                                        end: Alignment
                                                            .centerLeft,
                                                        colors: [
                                                          Theme.of(context)
                                                              .primaryColor,
                                                          Colors.amber
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 300.0,
                                                        minHeight: 50.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "المتقدمين",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ),
                                                // color:Theme.of(context).primaryColor,
                                                // child: Text("المتقدمين",
                                                //     style: TextStyle(fontSize: 20)),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return Applicants();
                                                  }));
                                                }),
                                          ),
                                          SizedBox(width: 25),
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            child: FlatButton(
                                                child: Text(
                                                  "للحذف",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  alert_delete(context);
                                                }),
                                          ),
                                          SizedBox(width: 25),
                                          Container(
                                            width: 110,
                                            height: 60,
                                            child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.0)),
                                                elevation: 0.0,
                                                padding: EdgeInsets.all(0.0),
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerRight,
                                                        end: Alignment
                                                            .centerLeft,
                                                        colors: [
                                                          Theme.of(context)
                                                              .primaryColor,
                                                          Colors.amber
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 300.0,
                                                        minHeight: 50.0),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "المقبولين",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .data1 =
                                                      Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .data;
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return Acceptable();
                                                  }));
                                                }),
                                          ),
                                        ])
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  )
        : Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
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
              data.isEmpty
                  ? CircularProgressIndicator()
                  : Column(children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Form(
                          key: ff1,
                          child: Container(
                            margin: EdgeInsets.only(left: 22, right: 22),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0))),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 8, bottom: 8),
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 10, right: 20),
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      topRight: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(50.0),
                                      bottomRight: Radius.circular(50.0))),
                              child: TextFormField(
                                initialValue: data["title"],
                                onSaved: (val) {
                                  data["title"] = val;
                                },
                                onChanged: (val) {
                                  data["title"] = val;
                                },
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
                                  hintText: 'العنوان',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Form(
                                key: ff,
                                child: Container(
                                  margin: EdgeInsets.only(left: 22, right: 22),
                                  height: 500,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.0),
                                          topRight: Radius.circular(50.0),
                                          bottomLeft: Radius.circular(50.0),
                                          bottomRight: Radius.circular(50.0))),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 5),
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        bottom: 10,
                                        right: 30,
                                        top: 20),
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50.0),
                                            topRight: Radius.circular(50.0),
                                            bottomLeft: Radius.circular(50.0),
                                            bottomRight:
                                                Radius.circular(50.0))),
                                    child: TextFormField(
                                      initialValue: data["myPost"],
                                      onSaved: (val) {
                                        data["myPost"] = val;
                                      },
                                      onChanged: (val) {
                                        data["myPost"] = val;
                                      },
                                      onEditingComplete: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'المنشور',
                                      ),
                                      maxLines: 30,
                                    ),
                                  ),
                                ))),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).accentColor
                              ]),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          width: 10,
                          //constraints:
                          //BoxConstraints(maxWidth: 100.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Provider.of<MyProvider>(context, listen: false)
                                  .data = data;
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PostUpdate();
                              }));
                            },
                            child: Text(
                              "تعديل",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ])
            ])));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var sl = query.isEmpty
        ? list
        : list.where((element) => element.startsWith(query)).toList();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
          itemCount: sl.length,
          itemBuilder: (context, i) {
            return ListTile(
                leading: Icon(
                  Icons.send,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                  textDirection: TextDirection.ltr,
                ),
                title: Text(
                  sl[i],
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  query = sl[i];
                  bayan = listData[query];
                  Provider.of<MyProvider>(context, listen: false).data = bayan;
                  showResults(context);
                });
          }),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
