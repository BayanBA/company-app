import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OnerComp extends StatefulWidget {

  var item;

  OnerComp(this.item,);

  @override
  _OnerCompState createState() => _OnerCompState();
}

class _OnerCompState extends State<OnerComp> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("معلومات الشركة"),),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.done),
          onPressed: ()async{


            await FirebaseFirestore.instance.collection("companies").add({
              'company': widget.item["company"],
              'region': widget.item["region"],
              'city': widget.item["city"],
              'followers':[],
              "all_accepted":[],
              'specialization': widget.item["specialization"],
              'email_advance': widget.item["email_advance"],
              'description': widget.item["description"],
              'size_company': widget.item["size_company"],
              'phone': widget.item["phone"],
              'link_image': "not",
              "bayan":widget.item["bayan"]
            });

            var id;
            FirebaseFirestore.instance.collection("companies").get().then((value){
              value.docs.forEach((element) {
                if(element.data()["bayan"]==num)
                  id=element.id;
              });
            });

            FirebaseFirestore.instance
                .collection("oner")
                .doc("DPi7T09bNPJGI0lBRqx4")
                .collection("chat")
                .add({
              "comp_id": id,
              "help": 1
            });
          },
        ),
      ),
    );
  }
}
