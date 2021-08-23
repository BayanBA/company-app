import 'package:b/chatSecreen/massege.dart';
import 'package:b/chatSecreen/newMassage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  GlobalKey<FormState> k1 = new GlobalKey<FormState>();

  // int i=0;
  //
  // getData() async {
  //   CollectionReference t = FirebaseFirestore.instance.collection("users").where("id", isEqualTo:Provider.of<MyProvider>(context, listen: false).user_id);
  //
  //   await t.get().then((value) {
  //     if (value != null) {
  //       value.docs.forEach((element) {
  //         FirebaseFirestore.instance
  //             .collection("users")
  //             .doc(element.id)
  //             .collection("chat").where("comp_id", arrayContains:Provider.of<MyProvider>(context, listen: false).company_id).get().then((value) {
  //           if (value != null){
  //             i=1;
  //           }
  //         });
  //         if(i==0){
  //           FirebaseFirestore.instance
  //               .collection("users")
  //               .doc(element.id)
  //               .collection("chat") .add({
  //             "comp_id":
  //             Provider.of<MyProvider>(context, listen: false).company_id,
  //           });
  //         }
  //
  //       });
  //     }
  //   });
  // }
  var t;
  getdata()async{
    Provider.of<MyProvider>(context, listen: false).chat==1?
    await FirebaseFirestore.instance
        .collection("oner")
        .doc("DPi7T09bNPJGI0lBRqx4")
        .collection("chat").get().then((value){
          value.docs.forEach((element) {
            if(element.data()["comp_id"]== Provider.of<MyProvider>(context, listen: false).company_id){
            Provider.of<MyProvider>(context, listen: false).setDocUser(element.id);
            print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
            print(Provider.of<MyProvider>(context, listen: false).docUser);}
          });
    }):t=0;
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
