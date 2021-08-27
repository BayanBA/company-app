import 'package:b/oner/chatO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'onerCompany.dart';
import 'oner_comp.dart';

class OnerCompanies extends StatefulWidget {

  @override
  _OnerCompaniesState createState() => _OnerCompaniesState();
}

class _OnerCompaniesState extends State<OnerCompanies> {

  var lis=new List();
  getData()async{
    await FirebaseFirestore.instance.collection("oner").doc("DPi7T09bNPJGI0lBRqx4").collection("new_company").get().then((value){
      value.docs.forEach((element) {
        lis.add(element.data());
      });
    });
  }


  void initState() {
   getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الشركات الجديدة"),
      ),
      body:
        Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("oner").doc("DPi7T09bNPJGI0lBRqx4").collection("new_company").snapshots(),
                builder: (context, snapshot){
                  if (snapshot.hasData)
                    return ListView.builder(itemCount:snapshot.data.docs.length ,
                        itemBuilder: (context,i){
                      return Row(
                        children: [
                          InkWell(child: Text(snapshot.data.docs[i]["company"]),onTap: (){
                            Navigator.push(context,
                                     new MaterialPageRoute(builder: (context) => OnerComp(snapshot.data.docs[i])));
                          },),
                        ],
                      );
                    });
                  else
                    return CircularProgressIndicator();

    },
              ),
            ),
            IconButton(onPressed: (){Navigator.push(context,
         new MaterialPageRoute(builder: (context) => OnerCompany()));}, icon: Icon(Icons.mark_chat_read_outlined))
          ],
        ),



    );
  }
}
