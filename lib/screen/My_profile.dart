import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../jobs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _options = ["H", "CART", "MENU", "SETTINGS", "FAVORITES"];
  int _currentIndex = 0;
  String link_image;
  jobs jobk;
  getdata() async {
    CollectionReference t =
    await FirebaseFirestore.instance.collection("companies");
    var user = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach(
            (element) {
          setState(() {
            Provider.of<MyProvider>(context, listen: false).setCompId(element.id);
            String k2 = element.data()['size_company'];
            String k3 = element.data()['email_advance'];
            String k4 = element.data()['company'];
            String k888 = element.data()['city'];
            String k111 = element.data()['specialization'];

            String k5 = element.data()['region'];
            String k6 = element.data()['description'];
            String k8 = element.data()['phone'];
            String k222 = element.data()['link_image'];

            jobk = new jobs('', k5, k888, k111, k4, k6, k3, k2, k222, k8);
            link_image = element.data()['link_image'];
          });
        },
      );
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

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
          body: ListView(children: [Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 90,
                    ),
                    Text("عرض فرص العمل"),
                    SizedBox(
                      width: 50,
                      height: 90,
                    ),
                    Text("المتابعين"),
                    SizedBox(
                      width: 80,
                      height: 90,
                    ),
                    Text("الموظفين"),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  // decoration: BoxDecoration(
                  //
                  //   //  borderRadius: BorderRadius.circular(30.0),
                  //   image: DecorationImage(
                  //       image: NetworkImage(
                  //        link_image
                  //
                  //
                  //       ),  fit: BoxFit.fitWidth
                  //   ),),
                ),

               _formUI(jobk),


              ],
            ),
          )
          ],),





          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,


          floatingActionButton: Row(

            children: [
              SizedBox(
                width: 30,
              ),
              FloatingActionButton(
                child: Icon(
                  Icons.account_balance,
                  color: Colors.indigo[300],
                  size: 30,
                ),
                backgroundColor: Colors.white,
                onPressed: () {},
              ),
              SizedBox(
                width: 70,
              ),
              FloatingActionButton(
                child: Icon(
                  Icons.accessibility,
                  color: Colors.indigo[300],
                  size: 30,
                ),
                backgroundColor: Colors.white,
                onPressed: () {},
              ),
              SizedBox(
                width: 70,
              ),
              FloatingActionButton(
                child: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.indigo[300],
                  size: 30,
                ),
                backgroundColor: Colors.white,
                onPressed: () {},
              ),

            ],
          ),
          // bottomNavigationBar: CurvedNavigationBar(
          //   color: Colors.indigo[300],
          //   buttonBackgroundColor: Colors.indigo[300],
          //   backgroundColor: Colors.white,
          //   animationDuration: Duration(seconds: 1),
          //   animationCurve: Curves.bounceOut,
          //   items: <Widget>[
          //     Icon(
          //       Icons.home,
          //       color: Colors.white,
          //     ),
          //     Icon(
          //       Icons.shopping_cart,
          //       color: Colors.white,
          //     ),
          //     Icon(
          //       Icons.restaurant_menu,
          //       color: Colors.white,
          //     ),
          //     Icon(
          //       Icons.settings,
          //       color: Colors.white,
          //     ),
          //     Icon(
          //       Icons.favorite,
          //       color: Colors.white,
          //     ),
          //   ],
          //   onTap: (index) {
          //
          //
          //     setState(() {
          //       _currentIndex = index;
          //       if(_options[ index ]=="CART")
          //         Navigator.push(context,
          //             new MaterialPageRoute(builder: (context) => new Post()));
          //
          //
          //     }
          //
          //    );
          //   },
          // ),
        ),
      ),
    );
  }


  _formUI(position) {
    return  new Container(


        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.black.withOpacity(0.009999),
          shadowColor:Colors.blueAccent.withOpacity(0.09),
          semanticContainer : true,
          borderOnForeground :true,

          elevation:50,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              _company(position),
              SizedBox(height: 12.0),
              _description(position),
              // SizedBox(height: 12.0),
              // _place(position),
              //  SizedBox(height: 12.0),
              //  _size(position),
              //  SizedBox(height: 12.0),
            ],
          ),)
    );
  }

  _size(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.accessibility_new),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('  حجم الشركه: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.deepPurple)),
          SizedBox(height: 1),
          Text("     "+position.size_company,style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.black))
        ],
      )
    ]);
  }

  _description(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.account_balance),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('   الوصف العام:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.deepPurple)),
          SizedBox(height: 1),
          Text("     "+position.description,style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.black))
        ],
      )
    ]);
  }

  _place(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.add_location_alt),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('   المقر الرئيسي:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.deepPurple)),
          SizedBox(height: 1),
          Text("     "+position.region,style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.black))
        ],
      )
    ]);
  }

  _company(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.account_circle_sharp),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('   اسم الشركه:  '  ,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.deepPurple)),
          SizedBox(height: 1),
          Text("     "+position.company, style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.black))
        ],
      )
    ]);
  }

  _prefixIcon(IconData iconData) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
      child: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          margin: const EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(10.0))),
          child: Icon(
            iconData,
            size: 25,
            color: Colors.black,
          )),
    );
  }



}
