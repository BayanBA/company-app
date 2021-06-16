import 'dart:async';
import 'package:b/screen/My_profile.dart';
import 'package:b/screen/chance.dart';
import 'package:b/screen/login.dart';
import 'package:b/screen/signup.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


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
        theme: ThemeData.light()
            .copyWith(primaryColor: Colors.
        amber, accentColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: towRoute(),
        routes: {
          // 'signup': (context) {
          //   return signup();
          // },
          'login': (context) {
            return login();
          },
          'listview': (context) {
            return ListViewjobs();
          },

       }
        );
  }
}

class towRoute extends StatefulWidget {
  @override
  _towRouteState createState() => new _towRouteState();
}

class _towRouteState extends State<towRoute> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
          () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FirstRoute()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Directionality(textDirection: TextDirection.rtl,child:
        Scaffold(
            body: Container(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: new AssetImage("images/4.png"))),
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
  TextEditingController myController = TextEditingController();
  //UserCredential userCredential;
  List<String> messages = List();

  getCompanyId() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    var user = FirebaseAuth.instance.currentUser;
    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach((element) {
        Provider.of<MyProvider>(context, listen: false).setCompId(element.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool islogin;
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      islogin = false;
    } else {
      islogin = true;
      getCompanyId();
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 1,
          child:Directionality(textDirection: TextDirection.rtl,child:
          Scaffold(

            body: Container(
              child: TabBarView(
                  children: <Widget>[
                    //   islogin == false ? login() :
                     AddJop()
                    //Quiz(),
                    //VerticalCardPagerUI(),
                    //SideMenuAnimationUI()
                    //AddJop(),
                    //VerticalCardPagerUI()
                   // CurvedNavigationDrawer()
                   // signup()

                  ],
                  //carusol
                  physics: new NeverScrollableScrollPhysics(),
                ),
              ),

          ),),
        ),
        routes: {
          // 'signup': (context) {
          //   return signup();
          // },

          'login': (context) {
            return login();
          },
          'listview': (context) {
            return ListViewjobs();
          },

        }
    );
  }
}

