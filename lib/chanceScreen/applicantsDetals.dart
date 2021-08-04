import 'package:b/screen/My_profile.dart';
import 'package:b/screen/savedUser.dart';
import 'package:b/screen/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class ApplicantsDetals extends StatefulWidget {
  var items;
  var items_id;


  ApplicantsDetals(this.items, this.items_id);

  @override
  _ApplicantsDetalsState createState() => _ApplicantsDetalsState();
}

class _ApplicantsDetalsState extends State<ApplicantsDetals> {

  var base=new List();
  var v;

  getData()async{
    v =await FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context,
        listen: false)
        .company_id)
        .collection("chance");
    v.doc(Provider.of<MyProvider>(context,listen: false).data["id"]).get().then((value) async{
       base=await value.data()["accepted"];

    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
                title: Center(
                  child: Text(" "),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
              ),
            ),
            body:
            SingleChildScrollView(child: Column(children: [
              Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.amber[50],
                child: Material(
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.pink)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.trending_up,
                                      size: 30,
                                    ),
                                  )),
                              Text("للمراسله",
                                  style: TextStyle(color: Colors.black))
                            ],
                          ),
                          onTap: () {}),
                      InkWell(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.contacts_outlined,
                                      size: 30,
                                    ),
                                  )),
                              Text("للتأكيد",
                                  style: TextStyle(color: Colors.black))
                            ],
                          ),
                          onTap: () {
                            base.add(widget.items_id.elementAt(0));
                            v.doc(Provider.of<MyProvider>(context,listen: false).data["id"]).update({
                              'accepted': base,
                            });
                          })
                    ],
                  ),
                  color: Colors.teal[50],
                ),
              ),
              Container(
                height: 170.0,
                width: MediaQuery.of(context).size.width,
                //decoration: BoxDecoration(border:Border.all(color:Colors.black)),

                color: Colors.black,
                child: Material(
                  //  border:Border.all(color:Colors.black)
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50.0)),

                  child: Container(
                    margin: EdgeInsets.only(top: 20, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            "الاسم: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.items.elementAt(0)['firstname']}",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            " " + "${widget.items.elementAt(0)['endname']}",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            "الايميل: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.items.elementAt(0)['gmail']}",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            "الهاتف: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " " + "${widget.items.elementAt(0)['phone']}",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ]),
                        Row(
                          children: [
                            Text(
                              "الميلاد والجنس:  ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " " +
                                  "${widget.items.elementAt(0)['date']['month']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              "/" +
                                  "${widget.items.elementAt(0)['date']['day']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              "/" +
                                  "${widget.items.elementAt(0)['date']['year']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              "${widget.items.elementAt(0)['gender']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),

                        ///7777
                      ],
                    ),
                  ),
                  color: Colors.amber[50],
                ),

                //   constraints: BoxConstraints.expand(),
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: new AssetImage("images/55.jpeg"),
                //           fit: BoxFit.cover)),
                //   child: Stack(alignment: Alignment.topCenter, children: <
                //       Widget>[
                //     // Positioned(
                //     //   top: -100,
                //     //   left: -100,
                //     //   child: InkWell(
                //     //       onTap: () => Navigator.push(
                //     //           context,
                //     //           new MaterialPageRoute(
                //     //               builder: (context) => new show_user())),
                //     //       child: CircleAvatar(
                //     //           radius: 100,
                //     //           backgroundImage: AssetImage("images/22.png"))),
                //     // ),
                //     // Positioned(
                //     //     top: -20,
                //     //     left: -20,
                //     //     child: IconButton(
                //     //       onPressed: () {
                //     //         // Navigator.push(context,
                //     //         //     new MaterialPageRoute(builder: (context) => new show_user()));
                //     //
                //     //         return showDialog(
                //     //           builder: (context) => AlertDialog(
                //     //             title: Text(
                //     //                 '     ....ماذا تريد قبل المغادره....    '),
                //     //             actions: <Widget>[
                //     //               FlatButton(
                //     //                   child: Text('الحفظ'),
                //     //                   onPressed: () {
                //     //                     Navigator.push(
                //     //                         context,
                //     //                         new MaterialPageRoute(
                //     //                             builder: (context) =>
                //     //                             new saves(widget.items
                //     //                                 .elementAt(0)[
                //     //                             'firstname'])));
                //     //                     print(
                //     //                         "____________________");
                //     //                     print(
                //     //                         "${widget.items.elementAt(0)['firstname']}");
                //     //                   }),
                //     //               FlatButton(
                //     //                 child: Text('المراسله '),
                //     //                 onPressed: () =>
                //     //                     Navigator.pop(context, true),
                //     //               ),
                //     //               FlatButton(
                //     //                 child: Text(' رجوع'),
                //     //                 onPressed: () => Navigator.pushReplacement(context,
                //     //                     new MaterialPageRoute(builder: (context) => new HomePage()))
                //     //               ),
                //     //             ],
                //     //           ),
                //     //           context: context,
                //     //         );
                //     //       },
                //     //       icon: Icon(Icons.arrow_forward),
                //     //       iconSize: 100,
                //     //       color: Colors.white.withOpacity(0.4),
                //     //     )),
                //     Positioned(
                //       top: 20,
                //       left: 80,
                //       child: Container(
                //         height: 10,
                //         width: 350,
                //         margin: EdgeInsets.all(20),
                //         child: Container(
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           ),
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //         top: 50,
                //         child: Card(
                //           child: Container(
                //             height: 200,
                //             width: 350,
                //             margin: EdgeInsets.all(20),
                //             child: Container(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment:
                //                 MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Row(children: [
                //                     Text(
                //                       "${widget.items.elementAt(0)['firstname']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       " " +
                //                           "${widget.items.elementAt(0)['endname']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                   ]),
                //                   Row(children: [
                //                     Text(
                //                       "${widget.items.elementAt(0)['gender']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       " " +
                //                           "${widget.items.elementAt(0)['date']['month']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       "/" +
                //                           "${widget.items.elementAt(0)['date']['day']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       "/" +
                //                           "${widget.items.elementAt(0)['date']['year']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                   ]),
                //                   Row(children: [
                //                     Text(
                //                       "${widget.items.elementAt(0)['Nationality']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       " , " +
                //                           "${widget.items.elementAt(0)['originalhome']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       ",  " +
                //                           "${widget.items.elementAt(0)['placerecident']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                   ]),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           elevation: 8,
                //           color: Colors.white70.withOpacity(0.6),
                //           shadowColor: Colors.green,
                //           shape: BeveledRectangleBorder(
                //               borderRadius: BorderRadius.circular(15)),
                //         )),
                //     Positioned(
                //         top: 340,
                //         child: Card(
                //           child: Container(
                //             height: 200,
                //             width: 350,
                //             margin: EdgeInsets.all(20),
                //             child: Container(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment:
                //                 MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Text(
                //                     "${widget.items.elementAt(0)['skill']}",
                //                     style: TextStyle(
                //                         fontSize: 20, color: Colors.black),
                //                   ),
                //                   Row(children: [
                //                     Text(
                //                       "${widget.items.elementAt(0)['work_field'][0]}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     // Text(
                //                     //   ", " +
                //                     //       "${widget.items.elementAt(0)['work_field']}",
                //                     //   style: TextStyle(
                //                     //       fontSize: 20, color: Colors.black),
                //                     // ),
                //                     // Text(
                //                     //   " ," +
                //                     //       "${widget.items.elementAt(0)['work_field'][2]}",
                //                     //   style: TextStyle(
                //                     //       fontSize: 20, color: Colors.black),
                //                     // ),
                //                   ]),
                //                   Text(
                //                     "${widget.items.elementAt(0)['scientific_level']}",
                //                     style: TextStyle(
                //                         fontSize: 20, color: Colors.black),
                //                   ),
                //                   Text(
                //                     "${widget.items.elementAt(0)['type_work']}",
                //                     style: TextStyle(
                //                         fontSize: 20, color: Colors.black),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           elevation: 8,
                //           color: Colors.white70.withOpacity(0.6),
                //           shadowColor: Colors.green,
                //           shape: BeveledRectangleBorder(
                //               borderRadius: BorderRadius.circular(15)),
                //         ))
                //   ])
                //
                //
                // )
              ),
              Container(
                height: 5.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.amber[50],
                child: Material(
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50.0)),
                  color: Colors.black,
                ),
              ),
              Container(
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                //decoration: BoxDecoration(border:Border.all(color:Colors.black)),

                color: Colors.black,
                child: Material(
                  //  border:Border.all(color:Colors.black)
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50.0)),
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "الموطن و مكان العمل:  ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " , " +
                                  "${widget.items.elementAt(0)['originalhome']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              ",  " +
                                  "${widget.items.elementAt(0)['worksite']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "المهارات:  ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${widget.items.elementAt(0)['skill']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "المستوى العلمي:  ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " , " +
                                  "${widget.items.elementAt(0)['scientific_level']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "الاعمال السابقه:  ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " , " +
                                  "${widget.items.elementAt(0)['work_field']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "اللغات:  ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " , " +
                                  "${widget.items.elementAt(0)['language']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "عدد سنوات الخبره",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " , " +
                                  "${widget.items.elementAt(0)['experience_year']}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  color: Colors.amber[50],
                ),

                //   constraints: BoxConstraints.expand(),
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: new AssetImage("images/55.jpeg"),
                //           fit: BoxFit.cover)),
                //   child: Stack(alignment: Alignment.topCenter, children: <
                //       Widget>[
                //     // Positioned(
                //     //   top: -100,
                //     //   left: -100,
                //     //   child: InkWell(
                //     //       onTap: () => Navigator.push(
                //     //           context,
                //     //           new MaterialPageRoute(
                //     //               builder: (context) => new show_user())),
                //     //       child: CircleAvatar(
                //     //           radius: 100,
                //     //           backgroundImage: AssetImage("images/22.png"))),
                //     // ),
                //     // Positioned(
                //     //     top: -20,
                //     //     left: -20,
                //     //     child: IconButton(
                //     //       onPressed: () {
                //     //         // Navigator.push(context,
                //     //         //     new MaterialPageRoute(builder: (context) => new show_user()));
                //     //
                //     //         return showDialog(
                //     //           builder: (context) => AlertDialog(
                //     //             title: Text(
                //     //                 '     ....ماذا تريد قبل المغادره....    '),
                //     //             actions: <Widget>[
                //     //               FlatButton(
                //     //                   child: Text('الحفظ'),
                //     //                   onPressed: () {
                //     //                     Navigator.push(
                //     //                         context,
                //     //                         new MaterialPageRoute(
                //     //                             builder: (context) =>
                //     //                             new saves(widget.items
                //     //                                 .elementAt(0)[
                //     //                             'firstname'])));
                //     //                     print(
                //     //                         "____________________");
                //     //                     print(
                //     //                         "${widget.items.elementAt(0)['firstname']}");
                //     //                   }),
                //     //               FlatButton(
                //     //                 child: Text('المراسله '),
                //     //                 onPressed: () =>
                //     //                     Navigator.pop(context, true),
                //     //               ),
                //     //               FlatButton(
                //     //                 child: Text(' رجوع'),
                //     //                 onPressed: () => Navigator.pushReplacement(context,
                //     //                     new MaterialPageRoute(builder: (context) => new HomePage()))
                //     //               ),
                //     //             ],
                //     //           ),
                //     //           context: context,
                //     //         );
                //     //       },
                //     //       icon: Icon(Icons.arrow_forward),
                //     //       iconSize: 100,
                //     //       color: Colors.white.withOpacity(0.4),
                //     //     )),
                //     Positioned(
                //       top: 20,
                //       left: 80,
                //       child: Container(
                //         height: 10,
                //         width: 350,
                //         margin: EdgeInsets.all(20),
                //         child: Container(
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           ),
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //         top: 50,
                //         child: Card(
                //           child: Container(
                //             height: 200,
                //             width: 350,
                //             margin: EdgeInsets.all(20),
                //             child: Container(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment:
                //                 MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Row(children: [
                //                     Text(
                //                       "${widget.items.elementAt(0)['firstname']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       " " +
                //                           "${widget.items.elementAt(0)['endname']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                   ]),
                //                   Row(children: [
                //                     Text(
                //                       "${widget.items.elementAt(0)['gender']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       " " +
                //                           "${widget.items.elementAt(0)['date']['month']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       "/" +
                //                           "${widget.items.elementAt(0)['date']['day']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       "/" +
                //                           "${widget.items.elementAt(0)['date']['year']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                   ]),
                //                   Row(children: [
                //                     Text(
                //                       "${widget.items.elementAt(0)['Nationality']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       " , " +
                //                           "${widget.items.elementAt(0)['originalhome']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     Text(
                //                       ",  " +
                //                           "${widget.items.elementAt(0)['placerecident']}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                   ]),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           elevation: 8,
                //           color: Colors.white70.withOpacity(0.6),
                //           shadowColor: Colors.green,
                //           shape: BeveledRectangleBorder(
                //               borderRadius: BorderRadius.circular(15)),
                //         )),
                //     Positioned(
                //         top: 340,
                //         child: Card(
                //           child: Container(
                //             height: 200,
                //             width: 350,
                //             margin: EdgeInsets.all(20),
                //             child: Container(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment:
                //                 MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Text(
                //                     "${widget.items.elementAt(0)['skill']}",
                //                     style: TextStyle(
                //                         fontSize: 20, color: Colors.black),
                //                   ),
                //                   Row(children: [
                //                     Text(
                //                       "${widget.items.elementAt(0)['work_field'][0]}",
                //                       style: TextStyle(
                //                           fontSize: 20, color: Colors.black),
                //                     ),
                //                     // Text(
                //                     //   ", " +
                //                     //       "${widget.items.elementAt(0)['work_field']}",
                //                     //   style: TextStyle(
                //                     //       fontSize: 20, color: Colors.black),
                //                     // ),
                //                     // Text(
                //                     //   " ," +
                //                     //       "${widget.items.elementAt(0)['work_field'][2]}",
                //                     //   style: TextStyle(
                //                     //       fontSize: 20, color: Colors.black),
                //                     // ),
                //                   ]),
                //                   Text(
                //                     "${widget.items.elementAt(0)['scientific_level']}",
                //                     style: TextStyle(
                //                         fontSize: 20, color: Colors.black),
                //                   ),
                //                   Text(
                //                     "${widget.items.elementAt(0)['type_work']}",
                //                     style: TextStyle(
                //                         fontSize: 20, color: Colors.black),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           elevation: 8,
                //           color: Colors.white70.withOpacity(0.6),
                //           shadowColor: Colors.green,
                //           shape: BeveledRectangleBorder(
                //               borderRadius: BorderRadius.circular(15)),
                //         ))
                //   ])
                //
                //
                // )
              ),
              Container(
                //height: 5.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.amber[50],
                child: Material(
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50.0)),
                  color: Colors.black,
                ),
              ),
            ]),)
            ));
  }
}
