import 'dart:async';

import 'package:b/stand.dart';
import 'package:b/chanceScreen/updatData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Detals extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var data =Provider.of<MyProvider>(context,listen: false).data;
    return Scaffold(
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
      body: Column(
        children: [
          Center(
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return UpdatData();
                }));
              },
            ),
          ),
          Text("${data["Vacancies"]}")
        ],
      ),
    );
  }
}
