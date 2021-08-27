import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatO.dart';

class OnerCompany extends StatefulWidget {

  @override
  _OnerCompanyState createState() => _OnerCompanyState();
}

class _OnerCompanyState extends State<OnerCompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("كل الشركات"),),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("companies").snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasData)
            return ListView.builder(itemCount:snapshot.data.docs.length ,
                itemBuilder: (context,i){
                  return Row(
                    children: [
                      Text(snapshot.data.docs[i]["company"]),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(onPressed:(){
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) => ChatO(snapshot.data.docs[i])));

                      }, icon:Icon(Icons.mark_chat_read_outlined))
                    ],
                  );
                });
          else
            return CircularProgressIndicator();

        },
      ),
    );
  }
}
