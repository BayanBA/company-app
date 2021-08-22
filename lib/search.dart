import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class datasearch extends SearchDelegate<String> {


  var bayan;
  date(context) async {
    CollectionReference ref =FirebaseFirestore.instance.collection("companies").doc(Provider.of<MyProvider>(context, listen: false).company_id).collection("chance");

    String u;
    await ref.where("title", isEqualTo: query).get().then((value) {
      value.docs.forEach((element) {
        u = element.id;
        bayan=element.data();

      });
    });

  }


  List<dynamic> list=new List();

  datasearch(this.list);

  String u;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {

    return Container(child:Column(children:<Widget> [

      Text(bayan["title"]),
      SizedBox(height: 20,),
      Text("data_save[1]"),
      SizedBox(height: 20,),
    ],));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var sl = query.isEmpty
        ? list
        : list.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
        itemCount: sl.length,
        itemBuilder: (context, i) {
          return ListTile(
              leading: Icon(Icons.nature_people),
              title: Text(sl[i]),
              onTap: () {
                query = sl[i];

                bbbb(context);
              });
        });
  }
  bbbb(context)async{
    await date(context);
    showResults(context);
  }
}
