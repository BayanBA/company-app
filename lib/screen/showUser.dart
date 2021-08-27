import 'dart:convert';

import 'package:b/chatSecreen/chat.dart';
import 'package:b/screen/My_profile.dart';
import 'package:b/screen/savedUser.dart';
import 'package:b/screen/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../stand.dart';

class show_detals extends StatefulWidget {
  var items;
  var items_id;

  show_detals(this.items, this.items_id);

  @override
  _show_detalsState createState() => _show_detalsState();
}

class _show_detalsState extends State<show_detals> {
  int i = 0;
  int j=0;
  var base = new List();
  var base1 = new List();
  //var v;
  var n;
  setData() async {
    j=0;
    i=0;
    n = new List();
    n = widget.items
        .elementAt(0)['num_follow'];
    if(Provider
        .of<MyProvider>(context, listen: false)
        .user ==
        1){
    await FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider
        .of<MyProvider>(context, listen: false)
        .company_id)
        .collection("chance").doc(Provider
        .of<MyProvider>(context, listen: false)
        .data["id"])
        .get()
        .then((value) async {
      base = await value.data()["accepted"];
    });}
    j=1;
    setState(() {

    });






    await FirebaseFirestore.instance.collection("users").doc(widget.items_id.elementAt(0)).collection("chat").get().then((value) {

      value.docs.forEach((element) {
        if (element.data()["comp_id"] == Provider.of<MyProvider>(context, listen: false).company_id){i = 1;
        Provider.of<MyProvider>(context, listen: false)
            .setDocUser(element.id);
        Provider.of<MyProvider>(context, listen: false)
            .setUserId(widget.items_id.elementAt(0));

        }
      });
    });
      if (i == 0){
        await FirebaseFirestore.instance.collection("users").doc(widget.items_id.elementAt(0)).collection("chat")
            .add({
          "name": Provider
              .of<MyProvider>(context, listen: false)
              .CompanyName,
          "img": Provider
              .of<MyProvider>(context, listen: false)
              .compPhoto,
          "comp_id": Provider
              .of<MyProvider>(context, listen: false)
              .company_id,
          "help": 1,
        });
        await FirebaseFirestore.instance.collection("users").doc(widget.items_id.elementAt(0)).collection("chat").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()["comp_id"] == Provider.of<MyProvider>(context, listen: false).company_id) {
            Provider.of<MyProvider>(context, listen: false)
                .setDocUser(element.id);
            Provider.of<MyProvider>(context, listen: false)
                .setUserId(widget.items_id.elementAt(0));

          }
        });
      });}

  }

  String token_owner,token_user,name_company;

  get_Token_user() async {

    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    var userr = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: userr.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {

          name_company = element.data()['company'];

        });
      });
    });

    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          if(element.id==widget.items_id.elementAt(0))
          {
            token_user=element.data()['token'];

            FirebaseFirestore.instance
                .collection("users")
                .doc(widget.items_id.elementAt(0))
                .collection("notifcation").
            add({

              "id":  Provider.of<MyProvider>(context, listen: false).company_id ,
              "title": 'متابعه',
              "body": " تم تصفح البروفايل الخاص بك من قبل شركه, ${name_company}  ",
              'date_publication': {
                'day': DateTime.now().day,
                'month': DateTime.now().month,
                'year': DateTime.now().year,
                'hour': DateTime.now().hour,
              },
              'num': 3,
              "date": Timestamp.now(),
            });

          }


        });
      });
    });

    sendMessage_user("متابعه", " تم تصفح البروفايل الخاص بك من قبل شركه  ${name_company} ",
    );



  }
  get_Token_owner() async {


    await FirebaseFirestore.instance.collection("oner").doc("DPi7T09bNPJGI0lBRqx4").get().then((value) {
      token_owner= value.data()['token'];
    });





  }

  void initState() {
    setData();
    get_Token_owner();
    get_Token_user();
    super.initState();
  }

  sendMessage_user(
      String title, String body ) async {
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
            'id':   Provider.of<MyProvider>(context, listen: false).company_id,
            'num': "3",
          },
          'to': await token_user,
        }));
  }


  sendMessage(
      String title, String body ) async {
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
            'id':  Provider.of<MyProvider>(context, listen: false).chanc_id,
            'id_company': Provider.of<MyProvider>(context, listen: false).company_id,
            'num': "4",
          },
          'to': await token_user,
        }));
  }


  sendMessage_owner(
      String title, String body ) async {
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
            'id':   widget.items_id.elementAt(0),
            'num': "2",
            'type':"2",
          },
          'to': await token_owner,
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(42.0),
            child: AppBar(
              title: Center(
                child: Text(" "),
              ),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     bottomRight: Radius.circular(20.0),
              //   ),
              // ),
            ),
          ),
          body:j==0?Center(
            child: CircularProgressIndicator(),
          )
              :SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme
                                  .of(context)
                                  .primaryColor,
                              Colors.amber
                            ])),
                    child: Container(
                      width: double.infinity,
                      height: 360.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Theme
                                  .of(context)
                                  .accentColor,
                              backgroundImage: widget.items
                                  .elementAt(0)['imageurl'] ==
                                  "not"
                                  ? AssetImage("images/55.jpeg")
                                  : NetworkImage(
                                  widget.items.elementAt(0)['imageurl']),
                              radius: 60.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "${widget.items.elementAt(0)['firstname']}" +
                                  " " +
                                  "${widget.items.elementAt(0)['endname']}",
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 22.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "المتابعين",
                                            style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${widget.items.elementAt(
                                                0)['num_follow'].length}" +
                                                " " +
                                                "شخص",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "الخبرة",
                                            style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${widget.items.elementAt(
                                                0)['experience_year']}" +
                                                " " +
                                                "سنوات",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "مراسلة",
                                            style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          InkWell(
                                            child: Text(
                                              "اضغط هنا",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            onTap: () {
                                              Provider.of<MyProvider>(context,
                                                  listen: false)
                                                  .setChat(2);
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          Chat()));
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              "المستوى العلمي:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(
                                        0)['scientific_level']}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "المهارات:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " + "${widget.items.elementAt(0)['skill']}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "الأعمال السابقة:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(
                                        0)['work_field']}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "اللغات:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(0)['language']}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "الموطن و مكان العمل:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(
                                        0)['originalhome']}" +
                                    " - " +
                                    "${widget.items.elementAt(0)['worksite']}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          children: [
                            Text(
                              " تاريخ الميلاد:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                " " +

                                    // "${widget.items.elementAt(0)['gender']}" +" ,"+
                                    "${widget.items.elementAt(
                                        0)['date']['month']}" +
                                    "/" +
                                    "${widget.items.elementAt(
                                        0)['date']['day']}" +
                                    "/" +
                                    "${widget.items.elementAt(
                                        0)['date']['year']}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          children: [
                            Text(
                              " الجنس:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(0)['gender']}" +
                                    "",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "الهاتف:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " + "${widget.items.elementAt(0)['phone']}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "الايميل:",
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Flexible(
                              child: Text(
                                "  " + "${widget.items.elementAt(0)['gmail']}",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 180.00,
                    child: (Provider
                        .of<MyProvider>(context, listen: false)
                        .user ==
                        1) && !(base.contains(widget.items_id.elementAt(0)))
                        ? RaisedButton(
                        onPressed: () async {
                          if (!base.contains(widget.items_id.elementAt(0))) {
                            base.add(widget.items_id.elementAt(0));
                            await FirebaseFirestore.instance
                                .collection("companies")
                                .doc(Provider
                                .of<MyProvider>(context, listen: false)
                                .company_id)
                                .collection("chance")
                                .doc(Provider
                                .of<MyProvider>(context,
                                listen: false)
                                .data["id"])
                                .update({
                              'accepted': base,
                            });
                            Provider.of<MyProvider>(context, listen: false).data["accepted"]=base;
                          }

                          await FirebaseFirestore.instance
                              .collection("companies")
                              .doc(Provider
                              .of<MyProvider>(context,
                              listen: false)
                              .company_id)
                              .get()
                              .then((value) {
                            base1 = value.data()["all_accepted"];
                          });
                          if (!base1.contains(widget.items_id.elementAt(0))){
                            base1.add(widget.items_id.elementAt(0));
                          await FirebaseFirestore.instance
                              .collection("companies")
                              .doc(Provider
                              .of<MyProvider>(context,
                              listen: false)
                              .company_id)
                              .update({"all_accepted": base1});}
                          sendMessage("تم قبولك", "تم قبولك بشركة ${name_company}");

                          // Provider.of<MyProvider>(context, listen: false)
                          //     .setUser(2);
                          setState(() {});
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
                                  Theme
                                      .of(context)
                                      .primaryColor,
                                  Colors.amber
                                ]),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "قبول",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ))
                        :
                    ( Provider
                        .of<MyProvider>(context, listen: false)
                        .user ==
                        1) &&
                        (base.contains(widget.items_id.elementAt(0)))
                        ? RaisedButton(
                        onPressed: () async {
                          base.remove(widget.items_id.elementAt(0));
                          await FirebaseFirestore.instance
                              .collection("companies")
                              .doc(Provider
                              .of<MyProvider>(context, listen: false)
                              .company_id)
                              .collection("chance")
                              .doc(Provider
                              .of<MyProvider>(context,
                              listen: false)
                              .data["id"])
                              .update({
                            'accepted': base,
                          });
                          await FirebaseFirestore.instance
                              .collection("companies")
                              .doc(Provider
                              .of<MyProvider>(context,
                              listen: false)
                              .company_id)
                              .get()
                              .then((value) {
                            base1 = value.data()["all_accepted"];
                          });
                          if (base1
                              .contains(widget.items_id.elementAt(0))) {
                            base1.remove(widget.items_id.elementAt(0));
                            await FirebaseFirestore.instance
                                .collection("companies")
                                .doc(Provider
                                .of<MyProvider>(context,
                                listen: false)
                                .company_id)
                                .update({"all_accepted": base1});
                          }
                          Provider.of<MyProvider>(context, listen: false).data["accepted"]=base;
                          setState(() {});
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
                                  Theme
                                      .of(context)
                                      .primaryColor,
                                  Colors.amber
                                ]),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "الغاء قبول",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ))
                        : (Provider
                        .of<MyProvider>(context, listen: false)
                        .user ==
                        3)&&(n.contains(Provider
                        .of<MyProvider>(
                        context,
                        listen: false)
                        .company_id))
                        ? RaisedButton(
                        onPressed: () async {
                          var idd;

                          // n = widget.items
                          //     .elementAt(0)['num_follow'];
                          if (n.contains(Provider
                              .of<MyProvider>(
                              context,
                              listen: false)
                              .company_id)) {
                            n.remove(Provider
                                .of<MyProvider>(
                                context,
                                listen: false)
                                .company_id);
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.items_id.elementAt(0))
                                .update({"num_follow": n});
                            await FirebaseFirestore.instance
                                .collection("companies")
                                .doc(Provider
                                .of<MyProvider>(
                                context,
                                listen: false)
                                .company_id)
                                .collection("favorite")
                                .get()
                                .then((value) {
                              value.docs.forEach((element) {
                                if (element.data()["id"] ==
                                    widget.items_id.elementAt(0))
                                  idd = element.id;
                              });
                            });

                            await FirebaseFirestore.instance
                                .collection("companies")
                                .doc(Provider
                                .of<MyProvider>(
                                context,
                                listen: false)
                                .company_id)
                                .collection("favorite")
                                .doc(idd)
                                .delete();

                            Fluttertoast.showToast(
                                msg: "تم الغاء المتابعة",
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_SHORT);


                            setState(() {});
                          }
                          // else {
                          //   Provider.of<MyProvider>(context, listen: false).setUser(0);
                          //   setState(() {
                          //   });
                          // }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(80.0)),
                        elevation: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Theme
                                      .of(context)
                                      .primaryColor,
                                  Colors.amber
                                ]),
                            borderRadius:
                            BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "الغاء متابعة",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ))
                        : RaisedButton(
                        onPressed: () async {
                          if (!n.contains(Provider
                              .of<MyProvider>(
                              context,
                              listen: false)
                              .company_id)) {
                            await FirebaseFirestore.instance
                                .collection("companies")
                                .doc(Provider
                                .of<MyProvider>(
                                context,
                                listen: false)
                                .company_id)
                                .collection("favorite")
                                .add({
                              'id': widget.items_id.elementAt(0),
                            });
                            n.add(Provider
                                .of<MyProvider>(context,
                                listen: false)
                                .company_id);
                            Fluttertoast.showToast(
                                msg: "تمت المتابعة",
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_SHORT);
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.items_id.elementAt(0))
                                .update({"num_follow": n});
                            setState(() {});
                          }
                            // Provider.of<MyProvider>(context,
                            //     listen: false)
                            //     .setUser(3);
                            setState(() {});

                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(80.0)),
                        elevation: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Theme
                                      .of(context)
                                      .primaryColor,
                                  Colors.amber
                                ]),
                            borderRadius:
                            BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "متابعة",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 180.00,
                    child: RaisedButton(
                        onPressed: () async {
                          FirebaseFirestore.instance.collection("oner").doc("DPi7T09bNPJGI0lBRqx4").
                          collection("reports").
                          add({

                            "id": Provider.of<MyProvider>(context, listen: false).company_id,
                            "title": 'اشعار ابلاغ',
                            "body":"  تم الابلاغ عن المستخدم  ${widget.items.elementAt(0)['firstname']} ${widget.items.elementAt(0)['endname']},  من قبل الشركه  ${name_company}",

                            'date_publication': {
                              'day': DateTime.now().day,
                              'month': DateTime.now().month,
                              'year': DateTime.now().year,
                              'hour': DateTime.now().hour,
                            },
                            'num': "2",
                            'type':"2",


                          });



                          sendMessage_owner(  "اشعار ابلاغ",
                            "  تم الابلاغ عن المستخدم  ${widget.items.elementAt(0)['firstname']} ${widget.items.elementAt(0)['endname']},  من قبل شركه  ${name_company}",
                          );

                          Fluttertoast.showToast(
                              msg: "تم الابلاغ عن هذا المستخدم !",
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_SHORT);



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
                                  Theme
                                      .of(context)
                                      .primaryColor,
                                  Colors.amber
                                ]),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "ابلاغ",
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
                  height: 30.0,
                ),
              ],
            ),
          ),
        ));
  }
}
