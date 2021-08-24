import 'package:b/chatSecreen/chat.dart';
import 'package:b/enter/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class Setting1Widget extends StatefulWidget {
  @override
  _Setting1WidgetState createState() => _Setting1WidgetState();
}

class _Setting1WidgetState extends State<Setting1Widget> {
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
          body:
          Stack(children: [
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


            ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "اعداداتي:",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 30),
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
                            style: TextStyle(fontSize: 20,color: Colors.black),
                          ),
                          trailing: IconButton(icon:Icon(Icons.arrow_right,size: 20,),onPressed: (){
                            Provider.of<MyProvider>(context, listen: false).setChat(1);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) {
                                                  return Chat();
                                                }));
                          },),
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
                            style: TextStyle(fontSize: 20,color: Colors.black),
                          ),
                          trailing: Icon(Icons.arrow_right,size: 20,),
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
                            style: TextStyle(fontSize: 20,color: Colors.black),
                          ),
                          trailing: IconButton(icon:Icon(Icons.arrow_right,size: 20,),onPressed: ()async{
                            await sign_out_Alart(context);
                          },),
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
                            " الوضع النهاري",
                            style: TextStyle(fontSize: 20,color: Colors.black),
                          ),
                          trailing: Switch(value: true, onChanged: (v) {},activeColor: Theme.of(context).primaryColor,),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),]),
        ));
  }

  sign_out_Alart(context) {
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
}
