import 'dart:async';

import 'package:b/employeeSecreen/applicants.dart';
import 'package:b/chanceScreen/updatChanceT.dart';
import 'package:b/chanceScreen/updatChanceV.dart';
import 'package:b/stand.dart';
import 'package:b/chanceScreen/updatData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalsT extends StatefulWidget {
  @override
  _DetalsState createState() => _DetalsState();
}

class _DetalsState extends State<DetalsT> {

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<MyProvider>(context, listen: false).data;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
            body: Stack(children: [
              Opacity(
                opacity: 0.4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: new AssetImage("images/55.jpeg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Color(0xFF5C6BC0), BlendMode.overlay))),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    CircleAvatar(
                      child: CircleAvatar(
                          child: Icon(Icons.apartment,
                              size: 50, color: Colors.white),
                          radius: 30,
                          backgroundColor: Colors.deepPurpleAccent),
                      radius: 50,
                      backgroundColor: Colors.black38,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          data["title"],
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.black38,
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("معلومات عن الفرصة",style: TextStyle(fontSize: 25,color: Colors.white),),
                            SizedBox(
                              height: 10,),
                            Row(
                              children: [
                                Icon(Icons.wb_incandescent_outlined),
                                SizedBox(width: 30,),
                                Text(data["describsion"],style: TextStyle(fontSize: 20,color: Colors.white),),
                              ],
                            ),
                            SizedBox(
                              height: 20,),
                            Text("نوع العمل",style: TextStyle(fontSize: 25,color: Colors.white),),
                            SizedBox(
                              height: 10,),
                            Row(
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(width: 30,),
                                Text(data["workTime"],style: TextStyle(fontSize: 20,color: Colors.white),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.black38,
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(data["skillNum"]),
                            Text(data["gender"]),
                            Text(data["degree"]),
                            Text(data["specialties"]),
                            for (int i = 0; i < data["langNum"].length; i++)
                              Text(data["langNum"].elementAt(i)),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10),
                      child: TextButton(child:Text("${data["Presenting_A_Job"].length}") ,onPressed:(){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Applicants();

                        }));
                      })
                      ,),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.black38,
                        elevation: 10,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("${data["Vacancies"]}"),
                            SizedBox(width: 70,),
                            Text("${data["Presenting_A_Job"].length}"),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return UpdatDataT();

                          }));
                          setState(() {
                            data = Provider.of<MyProvider>(context,
                                listen: false)
                                .data;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }
}
