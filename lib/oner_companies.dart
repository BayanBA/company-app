import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      body: lis.isEmpty?Center(child: CircularProgressIndicator()
        ,)
          :ListView.builder(itemBuilder: (context,i){
            return InkWell(
              child: Text(lis.elementAt(i)["company"]),
              onTap: (){
                Navigator.push(context,
                         new MaterialPageRoute(builder: (context) => OnerComp(lis.elementAt(i))));
              },
            );
      })
    );
  }
}
