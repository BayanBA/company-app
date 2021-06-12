import 'dart:async';

import 'package:b/quizQ.dart';
import 'package:flutter/cupertino.dart';

class Stander {
  String id = "";
  String dateOfPublication = "";
  bool quiz=false;
  int quizNum=1;
  int Vacancies = 1;
  String title = "";
  String age = "";
  String salary = "";
  String workTime = "";
  int langNum = 1;
  var lang = new List();
  int skillNum = 1;
  var skill = new List();
  var quizList=new List();
  String expir = "";
  String gender = "لا يهم";
  String degree = "لا يهم";
  String level = "مبتدأ";

}

class MyProvider with ChangeNotifier{

  Map<String,dynamic> data={
    "id": "",
    "title": "",
    "quiz":false,
    "age": "",
    "salary": "",
    "workTime": "",
    "langNum": 1,
    "lang": [],
    "skillNum": 1,
    "skill": [],
    "quizList":[],
    "expir": "",
    "quizNum":5,
    "gender": "لا يهم",
    "degree": "لا يهم",
    "level": "مبتدأ",
    "Vacancies": 1,
    "dateOfPublication": "",
  };
  String company_id="";
  int page = 0;

  setPage(int num){
    page=num;
    notifyListeners();
  }

  setDAta1(String name,var val){
    data[name]=val;
    notifyListeners();
  }

  setList (var val,int i,var typ){
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    if(typ==1)
    data["quizList"].elementAt(i).Q=val;
    else if(typ==2)
      data["quizList"].elementAt(i).ans.add(val);
    else if(typ==3)
      data["quizList"].elementAt(i).trueAns=val;
    else{
      data["quizList"].elementAt(i).num=val;
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print("${data["quizList"].elementAt(i).num}");}

    notifyListeners();
  }

  setCompId(var val){
    company_id=val;
    notifyListeners();
  }

  setData(data1){
    data=data1;
    notifyListeners();
  }


}
