import 'dart:async';
import 'package:b/employeeSecreen/acceptable.dart';
import 'package:flutter/cupertino.dart';
import 'package:b/employeeSecreen/applicants.dart';
import 'package:b/chanceScreen/updatChanceT.dart';
import 'package:b/chanceScreen/updatChanceV.dart';
import 'package:b/stand.dart';
import 'package:b/chanceScreen/updatData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalsV extends StatefulWidget {
  @override
  _DetalsState createState() => _DetalsState();
}

class _DetalsState extends State<DetalsV> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<MyProvider>(context, listen: false).data;

    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: Center(
              child: Text(" "),
            ),
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: <Widget>[
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        //margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
                        height: size.height * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        data["title"],
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 70, right: 150),
                  child: CircleAvatar(
                      child: CircleAvatar(
                          child:
                              Icon(Icons.apartment, size: 80, color: Colors.lime),
                          radius: 50,
                          backgroundColor: Colors.white),
                      radius: 60,
                      backgroundColor: Colors.black
                      //Theme.of(context).primaryColor,
                      ),
                ),
                Positioned(
                  top: 150,
                  left: 160,
                  child: CircleAvatar(
                      child: CircleAvatar(
                        child: FloatingActionButton(
                          heroTag: "tag30",
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return data["chanceId"] == 0
                                  ? UpdatData()
                                  : data["chanceId"] == 1
                                      ? UpdatDataV()
                                      : UpdatDataT();
                            }));
                            setState(() {
                              data = Provider.of<MyProvider>(context, listen: false)
                                  .data;
                            });
                          },
                        ),
                      ),
                      radius: 25,
                      backgroundColor: Colors.black),
                ),

              ],
            ),
            Expanded(
              child: ListView(children: [

                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 30, color: Colors.black),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "أوقات العمل :",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Row(
                              children: [
                                Text(
                                  data["workTime"],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.local_library_outlined,
                                    size: 30, color: Colors.black),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  " المهارات :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: Row(
                                children: [
                                  Text(
                                    data["skillNum"],
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.language,
                                  size: 30, color: Colors.black),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "اللغات :",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Row(
                              children: [
                                for (int i = 0; i < data["langNum"].length; i++)
                                  Text(
                                    data["langNum"].elementAt(i) + " , ",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.account_circle_outlined,
                                  size: 30, color: Colors.black),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "المتقدمين :",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Row(
                              children: [
                                Text(
                                  "${data["Presenting_A_Job"].length}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.wallet_giftcard,
                                  size: 30, color: Colors.black),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "عدد الشواغر :",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Row(
                              children: [
                                Text(
                                  "    ${data["Vacancies"]}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Icon(
                              Icons.wb_incandescent_outlined,
                              size: 30,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "الوصف :",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Flexible(
                              child: Text(
                                data["describsion"],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ]),
                          Divider(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              children: [

                                RaisedButton(
                                    color:Theme.of(context).primaryColor,
                                    child: Text("المتقدمين",
                                        style: TextStyle(fontSize: 30)),
                                    onPressed: ()  {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (context) {
                                        return Applicants();
                                      }));

                                    }),
                                SizedBox(width: 50,),

                                RaisedButton(
                                    color:Theme.of(context).primaryColor,
                                    child: Text("المقبولين",
                                      style: TextStyle(fontSize: 30),),
                                    onPressed: () {
                                       Provider.of<MyProvider>(context, listen: false).data1=data;
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (context) {
                                        return Acceptable();
                                      }));
                                    }),
                              ])
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
