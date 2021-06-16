import 'package:b/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class login extends StatefulWidget {
  @override
  _loginState createState() => new _loginState();
}

class _loginState extends State<login> {
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
      title: 'login',
      theme: ThemeData.light()
          .copyWith(primaryColor: Colors.cyan, accentColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage("images/4.png"), fit: BoxFit.cover)),
          child: Center(
            heightFactor: 1000,
            child: Form(
              key: formstate,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: 30, left: 15, bottom: 10, right: 15),
                    // padding: EdgeInsets.all(40),
                    child: TextFormField(
                        onSaved: (val) {
                          myemail = val;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.brown.withOpacity(0.3),
                          filled: true,
                          hintText: "email ",
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
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 30, left: 15, bottom: 10, right: 15),
                    child: TextFormField(
                      onSaved: (val) {
                        mypassword = val;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.brown.withOpacity(0.3),
                        filled: true,
                        hintText: "password ",
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
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Text("if you haven’t Account "),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) =>  new SignUp()));
                            },
                            child: Text(
                              "Click Here",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      )),
                  //batool.faiz.2000@gmail.com
                  //  19941994Abs
                  new Container(
                    padding: const EdgeInsets.only(
                        left: 150.0, top: 40.0, right: 150),
                    child: RaisedButton(
                        child: Text("login"),
                        onPressed: () async {
                          var response = await signIn();
                          if (response != null) {
                            {
                              Navigator.of(context).pushNamed("listview");
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
      ),
    );
  }
}
