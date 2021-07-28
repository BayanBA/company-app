import 'package:b/screen/savedUser.dart';
import 'package:b/screen/users.dart';
import 'package:flutter/material.dart';

class show_detals extends StatefulWidget {
  var items;

  show_detals(this.items);

  @override
  _show_detalsState createState() => _show_detalsState();
}

class _show_detalsState extends State<show_detals> {
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
                body: Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: new AssetImage("images/55.jpeg"),
                            fit: BoxFit.cover)),
                    child: Stack(alignment: Alignment.topCenter, children: <
                        Widget>[
                      Positioned(
                        top: -100,
                        left: -100,
                        child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new show_user())),
                            child: CircleAvatar(
                                radius: 100,
                                backgroundImage: AssetImage("images/22.png"))),
                      ),
                      Positioned(
                          top: -20,
                          left: -20,
                          child: IconButton(
                            onPressed: () {
                              // Navigator.push(context,
                              //     new MaterialPageRoute(builder: (context) => new show_user()));

                              return showDialog(
                                builder: (context) => AlertDialog(
                                  title: Text(
                                      '     ....ماذا تريد قبل المغادره....    '),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text('الحفظ'),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                  new saves(widget.items
                                                      .elementAt(0)[
                                                  'firstname'])));
                                          print(
                                              "____________________");
                                          print(
                                              "${widget.items.elementAt(0)['firstname']}");
                                        }),
                                    FlatButton(
                                      child: Text('المراسله '),
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                    ),
                                    FlatButton(
                                      child: Text(' رجوع'),
                                      onPressed: () => Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                              new show_user())),
                                    ),
                                  ],
                                ),
                                context: context,
                              );
                            },
                            icon: Icon(Icons.arrow_forward),
                            iconSize: 100,
                            color: Colors.white.withOpacity(0.4),
                          )),
                      Positioned(
                        top: 60,
                        left: 80,
                        child: Container(
                          height: 30,
                          width: 350,
                          margin: EdgeInsets.all(20),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 175,
                          child: Card(
                            child: Container(
                              height: 200,
                              width: 350,
                              margin: EdgeInsets.all(20),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(children: [
                                      Text(
                                        "${widget.items.elementAt(0)['firstname']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        " " +
                                            "${widget.items.elementAt(0)['endname']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ]),
                                    Row(children: [
                                      Text(
                                        "${widget.items.elementAt(0)['gender']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        " " +
                                            "${widget.items.elementAt(0)['date']['month']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        "/" +
                                            "${widget.items.elementAt(0)['date']['day']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        "/" +
                                            "${widget.items.elementAt(0)['date']['year']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ]),
                                    Row(children: [
                                      Text(
                                        "${widget.items.elementAt(0)['Nationality']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        " , " +
                                            "${widget.items.elementAt(0)['originalhome']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        ",  " +
                                            "${widget.items.elementAt(0)['placerecident']}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 8,
                            color: Colors.white70.withOpacity(0.6),
                            shadowColor: Colors.green,
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          )),
                      Positioned(
                          top: 450,
                          child: Card(
                            child: Container(
                              height: 200,
                              width: 350,
                              margin: EdgeInsets.all(20),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${widget.items.elementAt(0)['skill']}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Row(children: [
                                      Text(
                                        "${widget.items.elementAt(0)['work_field'][0]}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        ", " +
                                            "${widget.items.elementAt(0)['work_field'][1]}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        " ," +
                                            "${widget.items.elementAt(0)['work_field'][2]}",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ]),
                                    Text(
                                      "${widget.items.elementAt(0)['scientific_level']}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      "${widget.items.elementAt(0)['type_work']}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 8,
                            color: Colors.white70.withOpacity(0.6),
                            shadowColor: Colors.green,
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ))
                    ])))));
  }
}