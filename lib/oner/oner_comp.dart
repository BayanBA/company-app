import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnerComp extends StatefulWidget {
  var list;

  OnerComp(
    this.list,
  );

  @override
  _OnerCompState createState() => _OnerCompState();
}

class _OnerCompState extends State<OnerComp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات الشركة"),
      ),
      body: Center(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                await FirebaseFirestore.instance.collection("companies").add({
                  'company': widget.list["company"],
                  'region': widget.list["region"],
                  'city': widget.list["city"],
                  'followers': [],
                  "all_accepted": [],
                  "batool": 1,
                  'specialization': widget.list["specialization"],
                  'email_advance': widget.list["email_advance"],
                  'description': widget.list["description"],
                  'size_company': widget.list["size_company"],
                  'phone': widget.list["phone"],
                  'link_image': "not",
                  "bayan": widget.list["bayan"]
                });

                var id;
                await FirebaseFirestore.instance
                    .collection("companies")
                    .get()
                    .then((value) {
                  value.docs.forEach((element) {
                    if (element.data()["bayan"] == widget.list["bayan"])
                      id = element.id;
                  });
                });

                await FirebaseFirestore.instance
                    .collection("oner")
                    .doc("DPi7T09bNPJGI0lBRqx4")
                    .collection("chat")
                    .add({
                  "comp_id": id,
                  "help": 1,
                  "bayan": widget.list["bayan"]
                });

                var d;
                await FirebaseFirestore.instance
                    .collection("oner")
                    .doc("DPi7T09bNPJGI0lBRqx4")
                    .collection("new_company")
                    .get()
                    .then((value) {
                  value.docs.forEach((element) {
                    if (element.data()["bayan"] == widget.list["bayan"])
                      d = element.id;
                  });
                });

                await FirebaseFirestore.instance
                    .collection("oner")
                    .doc("DPi7T09bNPJGI0lBRqx4")
                    .collection("new_company")
                    .doc(d)
                    .delete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
