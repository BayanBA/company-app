import 'package:b/chatSecreen/chat.dart';
import 'package:b/enter/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class Setting1Widget extends StatefulWidget {
  @override
  _Setting1WidgetState createState() => _Setting1WidgetState();
}

class _Setting1WidgetState extends State<Setting1Widget> {
  bool isSwitched = false;
  bool isSwitched2 = false;

  @override
  Widget build(BuildContext context) {
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
            del == 0
                ? ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "اعداداتي:",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 30),
                        ),
                      ),
                      Card(
                        color: Theme.of(context).accentColor.withOpacity(0.3),
                        elevation: 4.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 100,
                              child: ListTile(
                                leading: Icon(
                                  Icons.mark_chat_read_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                title: Text(
                                  "    مراسله الاداره",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .setChat(1);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return Chat();
                                    }));
                                  },
                                ),
                              ),
                            ),
                            Divider(
                              height: 2,
                              color: Theme.of(context).primaryColor,
                              thickness: 2,
                            ),
                            Container(
                              height: 100,
                              child: ListTile(
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                title: Text(
                                  " حذف الحساب ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    size: 20,
                                  ),
                                  onPressed: () async {
                                    await deletAlart(context);
                                  },
                                ),
                              ),
                            ),
                            Divider(
                              height: 2,
                              color: Theme.of(context).primaryColor,
                              thickness: 2,
                            ),
                            Container(
                              height: 100,
                              child: ListTile(
                                leading: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                title: Text(
                                  " تسجيل الخروج",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.arrow_right,
                                    size: 20,
                                  ),
                                  onPressed: () async {
                                    await sign_out_Alart(context);
                                  },
                                ),
                              ),
                            ),
                            Divider(
                              height: 2,
                              color: Theme.of(context).primaryColor,
                              thickness: 2,
                            ),
                            Container(
                              height: 100,
                              child: ListTile(
                                leading: Icon(
                                  Icons.wb_sunny_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                title: Text(
                                  isSwitched == true
                                      ? " الوضع النهاري"
                                      : "الوضع الليلي",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                trailing: Switch(
                                  value: isSwitched,
                                  onChanged: (value) async {
                                    setState(() {
                                      isSwitched = value;
                                      if (isSwitched == true) {
                                        setState(() {
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .setDark(1);
                                        });
                                      } else {
                                        setState(() {
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .setDark(0);
                                        });
                                      }
                                    });
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                                // activeColor: Theme.of(context).primaryColor,
                                // ),
                              ),
                            ),
                            Divider(
                              height: 2,
                              color: Theme.of(context).primaryColor,
                              thickness: 2,
                            ),
                            Container(
                              height: 100,
                              child: ListTile(
                                leading: Icon(
                                  Icons.wb_sunny_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                title: Text(
                                  isSwitched2 == true
                                      ? "تفعيل الاشعارات"
                                      : "كتم الاشعارات",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                trailing: Switch(
                                  value: isSwitched2,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched2 = value;
                                      if (isSwitched2 == true) {
                                        setState(() {
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .setNoti(1);
                                          print(Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .noti);
                                        });
                                      } else {
                                        setState(() {
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .setNoti(0);

                                          print(Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .noti);
                                        });
                                      }
                                    });
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                                // activeColor: Theme.of(context).primaryColor,
                                // ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ]),
        ));
  }

  sign_out_Alart(context) {
    FirebaseAuth.instance.signOut();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Text(
                        "هل انت متاكد من تسجيل الخروج",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  )),
              content: Container(
                height: 20,
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () => setState(() {
                      Navigator.of(context).pop();
                    }),
                    child: Text(
                      "لا",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () {
                      //  await _signOut();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Login()));
                    },
                    child: Text(
                      '  نعم',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ]);
        });
  }

  var del = 0;

  deletedata(context) async {
    var e;
    CollectionReference t =
        await FirebaseFirestore.instance.collection("companies");
    var user = await FirebaseAuth.instance.currentUser;
    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() async {
          DocumentReference d = await FirebaseFirestore.instance
              .collection("companies")
              .doc(element.id);

          e = element.id;
          await d.collection("Post").get().then((value) {
            value.docs.forEach((element1) {
              d.collection("Post").doc(element1.id).delete();
            });
          });

          await d.collection("chance").get().then((value) {
            value.docs.forEach((element1) {
              d.collection("chance").doc(element1.id).delete();
            });
          });

          await d.collection("notification").get().then((value) {
            value.docs.forEach((element1) {
              d.collection("notification").doc(element1.id).delete();
            });
          });

          await d.collection("favorite").get().then((value) {
            value.docs.forEach((element1) {
              d.collection("favorite").doc(element1.id).delete();
            });
          });
          await user.delete();

          await d.delete();

          delete_company(e);
        });
      });
    });
    setState(() {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => new Login()));
    });
  }

  delete_company(var comp_id) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    CollectionReference company =
        FirebaseFirestore.instance.collection('companies');
    ///////delete company from user
    var num_companies_follow;
    await user.get().then((value) async {
      if (value.docs.isNotEmpty) {
        for (int k = 0; k < value.docs.length; k++) {
          num_companies_follow =
              value.docs[k].data()['companies_follow'].length;

          for (int i = 0; i < num_companies_follow; i++) {
            if (value.docs[k].data()['companies_follow'][i] == comp_id) {
              var val =
                  []; //blank list for add elements which you want to delete
              val.add('${value.docs[k].data()['companies_follow'][i]}');
              user.doc(value.docs[k].id).update({
                "companies_follow": FieldValue.arrayRemove(val)
              }).then((value) {
                print('Sucsess');
              }).catchError((e) {
                print("errroee");
              });
            }
          }
        }
      }
    });
    //////////delete company from companies saved
    List user_Id = [];
    await user.get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          user_Id.add(element.id);
        });
      }
    });
    for (int k = 0; k < user_Id.length; k++) {
      await user
          .doc(user_Id[k])
          .collection('companies_saved')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (int j = 0; j < value.docs.length; j++) {
            if (value.docs[j].data()['company_Id'] == comp_id) {
              user
                  .doc(user_Id[k])
                  .collection('companies_saved')
                  .where("company_Id", isEqualTo: comp_id)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  user
                      .doc(user_Id[k])
                      .collection('companies_saved')
                      .doc(element.id)
                      .delete()
                      .then((value) {
                    print("Success!");
                  });
                });
              });
            }
          }
        }
      });
    }
    /////////delete from notification
    for (int k = 0; k < user_Id.length; k++) {
      await user
          .doc(user_Id[k])
          .collection('notifcation')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (int j = 0; j < value.docs.length; j++) {
            if (value.docs[j].data()['id'] == comp_id) {
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
              user
                  .doc(user_Id[k])
                  .collection('notifcation')
                  .where("id", isEqualTo: comp_id)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  user
                      .doc(user_Id[k])
                      .collection('notifcation')
                      .doc(element.id)
                      .delete()
                      .then((value) {
                    print("Success!");
                  });
                });
              });
            }
          }
        }
      });
    }
  }

  deletAlart(context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Text(
                        "هل انت متاكد من حذف الحساب",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  )),
              content: Container(
                height: 20,
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () => setState(() {
                      Navigator.of(context).pop();
                    }),
                    child: Text(
                      "لا",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                        onPrimary: Colors.black,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                      ),
                      onPressed: () => setState(() {
                            Navigator.of(context).pop();
                            del = 1;
                            setState(() {});
                            deletedata(context);
                          }),
                      child: Text(
                        '  نعم',
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ]);
        });
  }
}
