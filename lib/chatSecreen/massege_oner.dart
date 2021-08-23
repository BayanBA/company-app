import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class MassegeOner extends StatelessWidget {

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
        var doc = snapshot.data.docs;
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if(snapshot.data == null) return CircularProgressIndicator();
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            reverse: true,
            itemCount: doc.length,
            itemBuilder: (ctx, index) {
              return Row(
                  mainAxisAlignment: doc[index]["num"] == 1
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: doc[index]["num"] == 1
                                ? Colors.lightGreen
                                : Colors.lightGreenAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                              bottomLeft: doc[index]["num"] == 1
                                  ? Radius.circular(14)
                                  : Radius.circular(0),
                              bottomRight: doc[index]["num"] == 1
                                  ? Radius.circular(0)
                                  : Radius.circular(14),
                            )),
                        width: 140,
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        margin:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: doc[index]["num"] == 1
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc[index]["text"],
                              style: TextStyle(fontSize: 20),
                              textAlign: doc[index]["num"] == 1
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
}
