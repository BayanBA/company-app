import 'package:flutter/material.dart';

import 'job_screen.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
                            'اسم الشركه',
                            '...',
                            Icon(
                              Icons.dashboard,
                            ),
                            TextInputType.name,
                          ),
                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                            'المقر الرئيسي',
                            '...',
                            Icon(Icons.add_location),
                            TextInputType.name,
                          ),
                          SizedBox(height: 24.0),

                          jobScreen.fill_text(
                              'المدينه', '...',
                              Icon(Icons.add_location),
                              TextInputType.name),

                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                            'حجم الشركه',
                            '...',
                            Icon(Icons.nature),
                            TextInputType.name,
                          ),
                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                            'الوصف',
                            '...',
                            Icon(Icons.ac_unit_sharp),
                            TextInputType.name,
                          ),
                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                              'التخصص', '...',
                              Icon(Icons.add_location),
                              TextInputType.name),

                          SizedBox(height: 24.0),
                          SizedBox(height: 24.0),
                          jobScreen.fill_text(
                            'الهاتف',
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
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => new login()));
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
