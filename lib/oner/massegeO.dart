import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MassegeO extends StatelessWidget {
  var id;
  MassegeO(this.id);
  @override
  Widget build(BuildContext context) {
    print("JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ");
    print(id);
    return StreamBuilder(
      stream:FirebaseFirestore.instance
          .collection("oner")
          .doc("DPi7T09bNPJGI0lBRqx4")
          .collection("chat")
          .doc(id)
          .collection("chats")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.hasData)
          return ListView.builder(
              reverse: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (ctx, index) {
                return Row(
                    mainAxisAlignment: snapshot.data.docs[index]["num"] == 2
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: snapshot.data.docs[index]["num"] == 2
                                  ? Colors.lightBlue[200]
                                  : Colors.purple[400],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                                bottomLeft: snapshot.data.docs[index]["num"] == 2
                                    ? Radius.circular(14)
                                    : Radius.circular(0),
                                bottomRight: snapshot.data.docs[index]["num"] == 2
                                    ? Radius.circular(0)
                                    : Radius.circular(14),
                              )),
                          width: 140,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          margin:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: snapshot.data.docs[index]["num"] == 2
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data.docs[index]["text"],
                                style: TextStyle(fontSize: 20),
                                textAlign: snapshot.data.docs[index]["num"] == 2
                                    ? TextAlign.end
                                    : TextAlign.start,
                              ),
                            ],
                          ))
                    ]);
              });
        else
          return CircularProgressIndicator();
      },
    );
  }

}
