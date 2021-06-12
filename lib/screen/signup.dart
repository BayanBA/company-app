
import 'package:b/screen/job_screen.dart';
import 'package:flutter/material.dart';
import 'My_profile.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => new _signupState();
}

class _signupState extends State<signup> {

  JobScreen jobScreen = new JobScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'signup',
      theme: ThemeData.light()
          .copyWith(primaryColor: Colors.cyan, accentColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: Container(
              //constraints: BoxConstraints.expand(),
              child: Form(
                key: jobScreen.formstate,
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 30, left: 15, bottom: 10, right: 15),
                      child: TextFormField(
                          onSaved: (val) {
                            jobScreen.myemail = val;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.brown.withOpacity(0.3),
                            filled: true,
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(style: BorderStyle.solid),
                            ),
                            hintText: 'الايميل',
                          ),
                          validator: (val) {
                            if (val.isEmpty)
                              return 'ادخل ايميلا صحيحا';
                            else if (val.length > 100)
                              return "لا يمكن ان يكون بهذا الحجم";
                            else if (val.length < 2)
                              return "لا يمكن ان يكون اقل من حرفين";

                            return null;
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 30, left: 15, bottom: 10, right: 15),
                      child: TextFormField(
                          onSaved: (val) {
                            jobScreen.mypassword = val;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.brown.withOpacity(0.3),
                            filled: true,
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(style: BorderStyle.solid),
                            ),
                            hintText: 'كلمه المرور',
                          ),
                          validator: (val) {
                            if (val.isEmpty)
                              return 'ادخل كلمة مرور صحيحا';
                            else if (val.length > 100)
                              return "لا يمكن ان يكون بهذا الحجم";
                            else if (val.length < 2)
                              return "لا يمكن ان تكون اقل من حرفين";

                            return null;
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 30, left: 15, bottom: 10, right: 15),
                      child: Column(
                        children: [
                          jobScreen.fill_text(
                            'name_job',
                            '...',
                            Icon(
                              Icons.dashboard,
                            ),
                            TextInputType.name,
                          ),
                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                            'region',
                            '...',
                            Icon(Icons.add_location),
                            TextInputType.name,
                          ),
                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                            'name_advance',
                            '...',
                            Icon(Icons.nature),
                            TextInputType.name,
                          ),
                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                            'description',
                            '...',
                            Icon(Icons.ac_unit_sharp),
                            TextInputType.name,
                          ),
                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                            'phone',
                            '...',
                            Icon(Icons.phone),
                            TextInputType.phone,
                          ),
                          SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              "اذا كان لديك حساب ",
                              style: TextStyle(fontSize: 20),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("login");
                              },
                              child: Text(
                                "اضغط هنا",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20),
                              ),
                            )
                          ],
                        )),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 150.0, top: 40.0, right: 150),
                      child: RaisedButton(
                          child: Text("تسجيل الدخول",
                              style: TextStyle(fontSize: 18)),
                          onPressed: () async {

                            var response = await jobScreen.signupo(context);

                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
