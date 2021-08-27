import 'package:flutter/material.dart';

class Wait extends StatelessWidget {

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
           Center(
             child: Text("الرجاء الانتظار ريثما يتم التحقق من البيانات"),
           )
          ]),
        ));
  }
}
