
import 'package:b/chanceScreen/chance.dart';
import 'package:b/postSecreen/post.dart';
import 'package:b/screen/signup.dart';
import 'package:b/chanceScreen/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class mydrawer extends StatefulWidget {
  @override
  _mydrawerState createState() => _mydrawerState();
}

class _mydrawerState extends State<mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "BRB",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            accountEmail: Text(
              "BRB.1945.PAR@gmail.com",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage('images/2.png'), fit: BoxFit.cover),
            ),
          ),
          ListTile(
              title: Text(
                "عرض الفرص",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ShowingData()));
              }),
          ListTile(
              title: Text(
                "اعدادات حسابي",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: Icon(Icons.settings),
              onTap: () async {
                // if(setting=="تعديل الحساب")
                // Navigator.push(context, new MaterialPageRoute(builder: (context) => new JobScreenEdit()));
                // else if(setting=="تسجيل خروج"){
                //   await _signOut();
                //   Navigator.push(context, new MaterialPageRoute(builder: (context) => new signup()));
                // }
                // else if(setting=="حذف حسابي")
                deletAlart();
              }),
          ListTile(
              title: Text(
                "اضافة فرصة",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new AddJop()));
              }),
          ListTile(
              title: Text(
                "انشاء منشور",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: Icon(Icons.plus_one),
              onTap: () { Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Post()));}),
          ListTile(
              title: Text(
                "عرض المستخدمين",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: Icon(Icons.ad_units),
              onTap: () {}),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  deletedata() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    var user = FirebaseAuth.instance.currentUser;
    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach((element) {
        print("company :${element.data()['company']}");

        setState(() {
          DocumentReference d = FirebaseFirestore.instance
              .collection("companies")
              .doc(element.id);
          d.delete();
        });
      });
    });
    await user.delete();
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new SignUp()));
  }

  deletAlart() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                "are you sure delete",
              ),
              content: Container(
                height: 20,
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => setState(() {
                    deletedata();
                    Navigator.of(context).pop();
                  }),
                  child: Text("yes"),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    Navigator.of(context).pop();
                  }),
                  child: Text('no'),
                ),
              ]);
        });
  }
}
