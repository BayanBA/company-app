import 'package:b/screen/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class saves extends StatefulWidget {
  var list;
  saves(this.list);
  @override
  _savesState createState() => _savesState();
}

CollectionReference t =  FirebaseFirestore.instance.collection("users");

class _savesState extends State<saves> {
  @override


  @override
  void initState() {
    //widget.list = new List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'jobs',
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.indigo[300], accentColor: Colors.indigo[300]),
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: AppBar(
                actions: [
                  IconButton(onPressed: (){
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new show_user()));

                  }, icon: Icon(Icons.arrow_forward_ios))

                ],
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
            body:Card(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children:[
                      Text("${widget.list}",style: TextStyle(fontSize: 20,color: Colors.black),) ,
                      Text(" "+"${widget.list}",style: TextStyle(fontSize: 20,color: Colors.black),),
                    ]),





                  ],


                ),),



              elevation: 8,
              shadowColor: Colors.green,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
        ));

  }
}
