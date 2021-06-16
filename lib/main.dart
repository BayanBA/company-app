import 'dart:async';
import 'dart:math';
import 'package:b/screen/My_profile.dart';
import 'package:b/screen/chance.dart';
import 'package:b/screen/edit.dart';
import 'package:b/screen/job_screen.dart';
import 'package:b/screen/login.dart';
import 'package:b/screen/post.dart';
import 'package:b/screen/signup.dart';
import 'package:b/screen/view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Navigation Basics',
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.indigo[300], accentColor: Colors.indigo[300]),
        debugShowCheckedModeBanner: false,
        home: towRoute(),
        routes: {
          'signup': (context) {
            return SignUp();
          },
          'login': (context) {
            return login();
          },
          'listview': (context) {
            return HomePage();
          },
        });
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
      Duration(seconds: 3),
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
  TextEditingController myController = TextEditingController();
  UserCredential userCredential;
  List<String> messages = List();




  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool islogin;
    JobScreen jobScreen = new JobScreen();


    var user = FirebaseAuth.instance.currentUser;
    if (user == null)
      islogin = false;
    else {
      islogin = true;
    }
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.indigo[300], accentColor: Colors.indigo[300]),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(

          body:
          islogin == false ? login() :
          IndexedStack( index: _currentIndex,
              children: [
                for (final i in koko) i,

              ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.indigo[300],
            buttonBackgroundColor: Colors.indigo[300],
            backgroundColor: Colors.white,
            animationDuration: Duration(seconds: 1),
            animationCurve: Curves.bounceOut,
            items: <Widget>[
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              Icon(
                Icons.restaurant_menu,
                color: Colors.white,
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              }

              );
            },
          ),
        ),
      ),
    );

  }


}
