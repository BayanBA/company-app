import 'package:b/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  var myusername, mypassword, myemail;
  bool login, signup;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signIn() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      formdata.save();
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: myemail,
          password: mypassword,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'signup',
        theme: ThemeData.light()
            .copyWith(primaryColor: Colors.indigo, accentColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: ListView(children: [
                Container(
                  child: Align(
                    // alignment: Alignment.center,
                    child: SizedBox(
                      height: 800,
                      width: 400,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            top: -150,
                            child:

                            CircleAvatar(
                              radius: 110,
                              backgroundColor: Colors.green,
                            ),
                          ),
                          Positioned(
                            top: -140,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.black87,
                            ),
                          ),


                          Positioned(
                            top: 60,
                            child: Card(
                              color: Colors.teal[50],
                              child: Container(
                                height: 70,
                                width: 380,
                                padding: EdgeInsets.only(top: 20),
                                margin: EdgeInsets.only(top: 50),
                              ),
                              elevation: 1,
                              shadowColor: Colors.green,
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            child:
                            Container(
                              width: 300,
                              // padding: EdgeInsets.all(40),
                              child: TextFormField(
                                  onSaved: (val) {
                                    myemail = val;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "الايميل* ",
                                    focusColor: Colors.blue,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return 'Please enter valid  number';
                                    else if (val.length > 100)
                                      return "username can't to be larger than 100 letter";
                                    else if (val.length < 2)
                                      return "username can't to be less than 2 letter";

                                    return null;
                                  }),
                            ),),
                          Positioned(
                            top: 230,
                            child: Card(
                              color: Colors.teal[50],
                              child: Container(
                                height: 70,
                                width: 380,
                                padding: EdgeInsets.only(top: 20),
                                margin: EdgeInsets.only(top: 50),
                              ),
                              elevation: 1,
                              shadowColor: Colors.green,
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          Positioned(
                            top: 270,
                            child: Container(
                              width: 300,
                              child:

                              TextFormField(
                                onSaved: (val) {
                                  mypassword = val;
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "كلمه المرور* ",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Please enter valid date';
                                  }
                                  return null;
                                },
                              ),),
                          ),



                          Container(
                              height:800 ,
                              margin: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Text("اذا لم يكن لديك حساب ",style: TextStyle(fontSize: 20),),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) =>  new SignUp()));
                                    },
                                    child: Text(
                                      "اضغط هنا",
                                      style: TextStyle(color: Colors.blue,fontSize: 20),
                                    ),
                                  )
                                ],
                              )),
                          //batool.faiz.2000@gmail.com
                          //  19941994Abs
                          new Container(
                            padding: const EdgeInsets.only(
                                left: 150.0, top: 450.0, right: 150),
                            child: RaisedButton(
                                child: Text("انشاء حساب",style: TextStyle(fontSize: 15,color:Colors.black45),),
                                onPressed: () async {
                                  var response = await signIn();
                                  if (response != null) {
                                    {

                                      login = true;
                                      print("yes**********");
                                      print(response);
                                    }
                                  } else {
                                    print("login uuuu Faild***********");
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ] ),
            )));
  }
}