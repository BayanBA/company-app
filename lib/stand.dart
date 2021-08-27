import 'package:flutter/cupertino.dart';

class Stander {
  String id = "";
  String dateOfPublication = "";
  int Vacancies = 1;
  String title = "";
  String salary = "";
  String workTime = "";
  String describsion="";
  String specialties="ترجمة";
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
    "salary": "",
    "workTime": "",
    "specialties":"ترجمة",
    "describsion":"",
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
  Map<String,dynamic> data1={};
  String chanceName="";
  String CompanyName="";
  String compPhoto="";
  String company_id="";
  String user_id="";
  String docUser="";
  String chanc_id="";
  int time=20;

  List<String> Q=[""];
  List<String> A=[""];
  List<String> Z=[""];
  int chat=0;
  int page = 0;
  int quiz=0;
  int qtype=0;
  int user=0;

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

  settime(int num){
    time=num;
    notifyListeners();
  }

  setUser(int num){
    user=num;
    notifyListeners();
  }

  setChat(int num){
    chat=num;
    notifyListeners();
  }

  setQtype(int num){
    qtype=num;
    notifyListeners();
  }
  setchanc_id(var num){
    chanc_id=num;
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

  setCompanyName(var val){
    CompanyName=val;
    notifyListeners();
  }

  setcompPhoto(var val){
    compPhoto=val;
    notifyListeners();
  }

  setDocUser(var val){
    docUser=val;
    notifyListeners();
  }

  setUserId(var val){
    user_id=val;
    notifyListeners();
  }

  setChanceName(var val){
    chanceName=val;
    notifyListeners();
  }

  setData(data1){
    data=data1;
    notifyListeners();
  }


}
