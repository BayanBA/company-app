import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NewMassageO extends StatefulWidget {

  var id;
  NewMassageO(this.id);
  @override
  _NewMassageOState createState() => _NewMassageOState();
}

class _NewMassageOState extends State<NewMassageO> {
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

  sendMassage() async{
    FocusScope.of(context).unfocus();
    control.clear();

    await FirebaseFirestore.instance
        .collection("oner")
        .doc("DPi7T09bNPJGI0lBRqx4")
        .collection("chat")
        .doc(widget.id)
        .collection("chats").add({"text":enterdMassage,"date":Timestamp.now(),"num":2});



  }
}
