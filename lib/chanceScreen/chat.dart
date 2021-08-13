import 'package:b/chanceScreen/massege.dart';
import 'package:b/chanceScreen/newMassage.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  GlobalKey<FormState> k1 = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
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
              Column(
                children: [

                  Expanded(child: Massege()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20,left: 5,right: 5),
                    child: NewMassage(),
                  ),

                ],
              )
            ])));
  }
}
