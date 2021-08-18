import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class Massege extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(Provider.of<MyProvider>(context, listen: false).user_id)
          .collection("chat")
          .doc(Provider.of<MyProvider>(context, listen: false).docUser)
          .collection("chats")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        final docs = snapshot.data.docs;
        return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
              return Row(
                  mainAxisAlignment: docs[index]["num"] == 1
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: docs[index]["num"] == 1
                                ? Colors.lightGreen
                                : Colors.lightGreenAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                              bottomLeft: docs[index]["num"] == 1
                                  ? Radius.circular(14)
                                  : Radius.circular(0),
                              bottomRight: docs[index]["num"] == 1
                                  ? Radius.circular(0)
                                  : Radius.circular(14),
                            )),
                        width: 140,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: docs[index]["num"] == 1
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              docs[index]["text"],
                              style: TextStyle(fontSize: 20),
                              textAlign: docs[index]["num"] == 1
                                  ? TextAlign.end
                                  : TextAlign.start,
                            ),
                          ],
                        ))
                  ]);
            });
      },
    );
  }

  sendMassage(context) async{
    await FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<MyProvider>(context, listen: false).user_id)
        .collection("chat")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()["comp_id"] ==
            Provider.of<MyProvider>(context, listen: false).company_id)
          FirebaseFirestore.instance
              .collection("users")
              .doc(Provider.of<MyProvider>(context, listen: false).user_id)
              .collection("chat")
              .doc(element.id)
              .collection("chats");
      });
    });
  }
}
