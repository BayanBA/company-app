import 'dart:async';
import 'package:b/screen/My_profile.dart';
import 'package:b/chanceScreen/chance.dart';
import 'package:b/screen/edit.dart';
import 'package:b/screen/job_screen.dart';
import 'package:b/enter/login.dart';
import 'package:b/postSecreen/post.dart';
import 'package:b/screen/savedUser.dart';
import 'package:b/screen/users.dart';
import 'package:b/enter/wait.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'employeeSecreen/Initial_acceptance.dart';
import 'oner/oner_companies.dart';

List<String> nn = new List();
Map<String, List> kk = new Map();
List<String> nn2 = new List();
JobScreen jobScreen = new JobScreen();

List<dynamic> koko = [
  AddJop(),
  Post(),
  HomePage(),
  JobScreenEdit(),
  //OnerCompanies(),
  Setting1Widget(),
];
Map<String, dynamic> homePageData = new Map<String, dynamic>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (_) => MyProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Basics',
      theme: Provider.of<MyProvider>(context, listen: false).dark==0?
      ThemeData.light(). copyWith(primaryColor: Colors.red[900], accentColor: Colors.orangeAccent[200],cardColor: Colors.grey[100]):
      ThemeData.light(). copyWith(primaryColor: Colors.black, accentColor: Colors.tealAccent,cardColor: Colors.teal[50]),
      debugShowCheckedModeBanner: false,
      home: towRoute(),
    );
  }
}

class towRoute extends StatefulWidget {
  @override
  _towRouteState createState() => new _towRouteState();
}

class _towRouteState extends State<towRoute> {
  bool islogin = false;
  var user;

  @override
  getdata() async {
   b=1;
    await FirebaseFirestore.instance.collection("oner").doc("DPi7T09bNPJGI0lBRqx4").collection("new_company").get().then((value) {
      value.docs.forEach((element) {
        if(element.data()["email_advance"]==user.email)
          b=element.data()["batool"];

      });
    });

    CollectionReference t =
        await FirebaseFirestore.instance.collection("location");
    await t.doc("Pju9ofIYjWDZF86czL75").get().then((value) {
      for (int i = 0; i < 5; i++) nn.add(value.data()['array'][i]);
      bbb();
    });
  }

  bbb() async {
    await getdata2();
  }

  var b=1;

  getdata2() async {



    CollectionReference t =
        await FirebaseFirestore.instance.collection("location");
    await t.doc("zgmM6DkhtzXh1S4F4Atd").get().then((value) {
      for (int j = 0; j < nn.length; j++) {
        nn2 = new List();
        for (int i = 0; i < 5; i++)
          nn2.add(value.data()['map'][nn.elementAt(j)][i]);

        kk[nn.elementAt(j)] = nn2;
      }
    });
  }

  void initState() {
    super.initState();
    nn = new List();
    nn2 = new List();
    getdata();



    user = FirebaseAuth.instance.currentUser;
    if (user == null)
      islogin = false;
    else {
      islogin = true;
    }


    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => islogin == false ? Login() :b==1? FirstRoute():Wait(),
              ),
            ));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              body: Container(
                  child: Center(
            child: Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: new AssetImage("images/4.png"))),
              child: SpinKitRipple(
                color: Colors.red,
                size: 80,
              ),
            ),
          ))),
        ));
  }
}

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => new _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  void initState() {
    super.initState();
  }

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<MyProvider>(context, listen: false).dark==0?
      ThemeData.light(). copyWith(primaryColor: Colors.red[900], accentColor: Colors.orangeAccent[200],cardColor: Colors.grey[100]):
      ThemeData.light(). copyWith(primaryColor: Colors.black, accentColor: Colors.tealAccent,cardColor: Colors.teal[50]),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Stack(
            children: [
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
              IndexedStack(
                index: _currentIndex,
                children: [
                  for (final i in koko) i,
                ],
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: _currentIndex,
            color:Provider.of<MyProvider>(context, listen: false).dark==0?Theme.of(context).primaryColor:Colors.black ,

            buttonBackgroundColor: Provider.of<MyProvider>(context, listen: false).dark==0?Theme.of(context).primaryColor:Colors.black ,
            backgroundColor: Colors.white,
            animationDuration: Duration(seconds: 1),
            animationCurve: Curves.bounceOut,
            items: <Widget>[
              Icon(
                Icons.work,
                color: Colors.white,
              ),
              Icon(
                Icons.post_add,
                color: Colors.white,
              ),
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
