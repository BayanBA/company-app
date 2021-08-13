import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class NewMassage extends StatefulWidget {
  @override
  _NewMassageState createState() => _NewMassageState();
}

class _NewMassageState extends State<NewMassage> {
  String enterdMassage="";
  final control=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: control,
            decoration: InputDecoration(labelText: 'ارسال رسالة'),
            onChanged: (val) {
              setState(() {
                enterdMassage = val;
              });
            },
          )),
          IconButton(
              onPressed: enterdMassage.trim().isEmpty ? null : sendMassage,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }

  sendMassage() {
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<MyProvider>(context, listen: false).user_id)
        .collection("chat").get().then((value){
          value.docs.forEach((element) {
            if(element.data()["comp_id"]==Provider.of<MyProvider>(context, listen: false).company_id)
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(Provider.of<MyProvider>(context, listen: false).user_id)
                  .collection("chat").doc(element.id).collection("chats").add({"text":enterdMassage,"date":Timestamp.now(),"num":1});
          });
    });
        

    control.clear();
  }
}
