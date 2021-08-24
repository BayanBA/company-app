import 'package:b/chanceScreen/detals.dart';
import 'package:b/postSecreen/postDetals.dart';
import 'package:b/postSecreen/postUpdate.dart';
import 'package:b/search.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

const _horizontalPadding = 32.0;
const _carouselItemMargin = 8.0;

class ShowingPost extends StatefulWidget {
  @override
  _ShowingPostState createState() => _ShowingPostState();
}

class _ShowingPostState extends State<ShowingPost> {
  CollectionReference comp;
  int currentPage = 0;

  Widget done(lis, int i) {
    return Container(
        margin: EdgeInsets.only(left: 22, right: 22),
        height: 130,
        width: 150,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(left: 20, bottom: 10),
          height: 130,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          child: Center(
            child: InkWell(
              child: ListTile(
                title:
                    Text(lis["title"], style: TextStyle(color: Colors.black,fontSize: 12),),
              ),
              onTap: () {
                setState(() {
                  currentPage = i;
                });
              },
            ),
          ),
        ));
  }

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
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("companies")
                      .doc(Provider.of<MyProvider>(context, listen: false)
                          .company_id)
                      .collection("Post")
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return Center(
                        child: Text("لم يتم نشر أي منشور"),
                      );
                    else if (snapshot.hasData)
                      return ff(snapshot.data.docs);
                    else
                      return Center(child: CircularProgressIndicator());
                  }),
            ])));
  }

  ff(lis) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
              color: Colors.black12,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      done(lis[i], i),

                    ],
                  );
                },
                itemCount: lis.length,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  margin: EdgeInsets.only(left: 22, right: 22),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Center(
                              child: Text(
                                lis[currentPage]["title"],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(lis[currentPage]["myPost"]),
                          ),
                          ButtonBar(
                            children: [
                              Text(
                                lis[currentPage]["date_publication"]['day']
                                        .toString() +
                                    "/" +
                                    lis[currentPage]["date_publication"]
                                            ['month']
                                        .toString() +
                                    "/" +
                                    lis[currentPage]["date_publication"]['year']
                                        .toString(),
                              )
                            ],
                          ),
                        ],
                      ))),
            ),
          ),
          Container(
            width: 150,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ]),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              width: 10,
              //constraints:
              //BoxConstraints(maxWidth: 100.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    Provider.of<MyProvider>(context, listen: false).data =
                        lis[currentPage].data();
                  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PostUpdate();
                  }));
                },
                child: Text(
                  "تعديل",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
