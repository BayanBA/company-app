
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'massegeO.dart';
import 'newMassegeO.dart';


class ChatO extends StatefulWidget {
  var item;
  ChatO(this.item);

  @override
  _ChatOState createState() => _ChatOState();
}

class _ChatOState extends State<ChatO> {
  GlobalKey<FormState> k1 = new GlobalKey<FormState>();



  var iddd;
  getdata()async{

    await FirebaseFirestore.instance
        .collection("oner")
        .doc("DPi7T09bNPJGI0lBRqx4")
        .collection("chat").get().then((value){
      value.docs.forEach((element) {
        if(element.data()["bayan"]==widget.item["bayan"]){
          iddd= element.id;
          setState(() {
          });
        }
      });
    });
  }


  @override
  void initState() {
    getdata();
    super.initState();
  }

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
              iddd==null?CircularProgressIndicator():
              Column(
                children: [
                  Expanded(child: MassegeO(iddd)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20,left: 5,right: 5),
                    child: NewMassageO(iddd),
                  ),

                ],
              )
            ])));
  }
}
