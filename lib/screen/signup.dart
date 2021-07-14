
import 'package:flutter/material.dart';

import 'job_screen.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp> {

  JobScreen jobScreen = new JobScreen();
  Widget fill_text(String b,String name, String hint, Icon, keyboardType) {
    return TextFormField(
        initialValue:jobScreen.d[b],

        keyboardType: keyboardType,
        onSaved: (val) {
          jobScreen.text.add(val);
        },
        decoration: InputDecoration(
          fillColor: Colors.brown.withOpacity(0.3),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.solid),
          ),
          hintText: hint,
          labelText: name,
          prefixIcon: Icon,
        ),
        validator: jobScreen.validateName,
        onChanged: (val){
          setState(() {
            jobScreen.d[b]=val;
          });}
    );
  }

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
            child: ListView(
              children:<Widget>
               [
                    Form(
                  key: jobScreen.formstate,
                      child: TextFormField(
                          initialValue: jobScreen.d["email"],
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
                          },
                                onChanged: (val){
                                  setState(() {
                                    jobScreen.d["email"]=val;
                                  });
                                  }

                              ),

                    ),
                    SizedBox(height: 30,),
                    Form( key: jobScreen.formstate2,
                      child:
                      TextFormField(
                          initialValue: jobScreen.d["password"],

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
                          },
                          onChanged: (val)
                         {
                              setState(() {
                                jobScreen.d["password"]=val;
                              });
                            }),
                    ),
                    SizedBox(height: 30,),
                    Form(
                        key: jobScreen.formstate3,
                        child: fill_text("company",
                            'اسم الشركه',
                            '...',
                            Icon(
                              Icons.dashboard,
                            ),
                            TextInputType.name,
                          ),),
                    SizedBox(height: 30,),
                    Form(
                  key: jobScreen.formstate4,
                  child: fill_text("region",
                            'المقر الرئيسي',
                            '...',
                            Icon(Icons.add_location),
                            TextInputType.name,
                          ),),
                    SizedBox(height: 30,),
                    Form(
              key: jobScreen.formstate5,
              child:
                      fill_text("city",
                              'المدينه', '...',
                              Icon(Icons.add_location),
                              TextInputType.name),),
                    SizedBox(height: 24.0),
                    Form(
              key: jobScreen.formstate6,
              child: fill_text("size",
                            'حجم الشركه',
                            '...',
                            Icon(Icons.nature),
                            TextInputType.name,
                          ),),
                    SizedBox(height: 30,),
                    Form(
              key: jobScreen.formstate7,
              child:fill_text("des",
                            'الوصف',
                            '...',
                            Icon(Icons.ac_unit_sharp),
                            TextInputType.name,
                          ),),
                    SizedBox(height: 30,),
                    Form(
              key: jobScreen.formstate8,
              child:fill_text("spe",
                              'التخصص', '...',
                              Icon(Icons.add_location),
                              TextInputType.name),),
                    SizedBox(height: 30,),
                    Form(
              key: jobScreen.formstate9,
              child:
                          fill_text("phone",
                            'الهاتف',
                            '...',
                            Icon(Icons.phone),
                            TextInputType.phone,
                          ),),
                    SizedBox(height: 30,),



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
                             print(jobScreen.d);
                            var response = await jobScreen.signupo(context);

                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),

    );
}}
