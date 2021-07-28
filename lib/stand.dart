import 'package:flutter/cupertino.dart';

class Stander {
  String id = "";
  String dateOfPublication = "";
  int Vacancies = 1;
  String title = "";
  String age = "";
  String salary = "";
  String workTime = "";
  var langNum = new List();
  String skillNum = "";
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
    "age": "",
    "salary": "",
    "workTime": "",
    "langNum": [],
    "skillNum": "",
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
  List<String> Q=[""];
  List<String> A=[""];
  List<String> Z=[""];
  int page = 0;
  int quiz=0;

  setListQA(var qu,var ans,var ans11){
    Q=qu;
    A=ans;
    Z=ans11;
    quiz=1;
    notifyListeners();
  }

  setListTF(var qu,var ans){
    Q=qu;
    A=ans;
    quiz=2;
    notifyListeners();
  }

  setPage(int num){
    page=num;
    notifyListeners();
  }

  setDAta1(String name,var val){
    data[name]=val;
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
