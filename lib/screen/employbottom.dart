import 'package:b/screen/savedUser.dart';
import 'package:b/screen/users.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'myEmploy.dart';

class navigator extends StatefulWidget {
  @override
  _navigatorState createState() => _navigatorState();
}

class _navigatorState extends State<navigator> {
  int curr = 0;

  List<dynamic> bobo = [show_user(), MyEmploy(),saves()];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Stack(
              children: [

                IndexedStack(
                  index: curr,
                  children: [
                    for (final i in bobo) i,
                  ],
                ),
              ]
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: curr,
            color: Theme.of(context).primaryColor,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            animationDuration: Duration(seconds: 1),
            animationCurve: Curves.bounceOut,
            items: <Widget>[
              Icon(
                Icons.attribution_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.done,
                color: Colors.white,
              ),
              Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ],
            onTap: (index) {
              setState(() {
                curr = index;
              });
            },
          ),
        ));
  }
}
