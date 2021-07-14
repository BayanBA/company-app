
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  var save;
  GlobalKey<FormState> ff = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
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
      body:  Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: ff,
            child: Container(
              color: Colors.indigoAccent,
              child: TextFormField(
                onSaved: (val) {
                  save = val;
                },
                decoration: InputDecoration(
                  fillColor: Colors.brown.withOpacity(0.3),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                  hintText: 'المنشور',
                ),

              ),

            ),

          )

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saving();
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    ) ;


  }

  saving() {
    var fo = ff.currentState;
    fo.save();
    var user = FirebaseAuth.instance.currentUser;
    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post");
    v.add({
      "myPost":save
    });
  }
}
