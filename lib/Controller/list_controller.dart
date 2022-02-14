import 'dart:convert';
import 'dart:core';
import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:estudesemfronteiras/Service/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


enum DataState{
  Uninitialized,
  Refreshing,
  Initial_Fetching,
  More_Fetching,
  Fetched,
  No_More_Data,
  Error
}

class ListController extends ChangeNotifier{

  List<Courses> _courses =[];
  List<Courses> get courses => _courses;

  int _currentPageNumber = 0;
  int _totalPage = 30 ;
  DataState _dataState = DataState.Uninitialized ;
  bool get _didLastLoad => _currentPageNumber >= _totalPage;
  DataState get dataState => _dataState ;
  //List<Courses> _dataList = [];
  //List<Courses> get dataList => _dataList;
  Future<List<Courses>> fetchCourses(id) async {
    var url = 'http://192.168.1.123:8765/courses?page='+id.toString();
    var body;
    var json;
    var parsed;
    final response = await http.get(Uri.parse(url));
    body = response.body;

    json = jsonDecode(body);
    print(json["courses"].toString());
    parsed = json["courses"].cast<Map<String, dynamic>>();
    print(parsed.toString());
    return parsed.map<Courses>((json) => Courses.fromMap(json)).toList();
  }


  fetchData({bool isRefresh = false}) async{


   List<Courses> futureCourses =await fetchCourses(_currentPageNumber);
    print("fetsh data "+futureCourses[0].id.toString());


   if(_dataState == DataState.Uninitialized){
    }

    if(!isRefresh){
      _dataState = (_dataState == DataState.Uninitialized)
          ? DataState.Initial_Fetching
          : DataState.More_Fetching;
    }else {
      _currentPageNumber = 0;
      _dataState = DataState.Refreshing;
    }
    notifyListeners();

    try{
      if(_didLastLoad){
        _dataState = DataState.No_More_Data;
      }else{
        List<Courses> futureCourses =await APIManager().fetchCourses(_currentPageNumber);
        //print(futureCourses.toString());

       if(_dataState == DataState.Refreshing){
          _courses.clear();
        }
        _courses += futureCourses;
        _dataState = DataState.Fetched;
        _currentPageNumber += 1 ;
      }
    }catch(e){
      _dataState = DataState.Error;
      notifyListeners();
    }

   _currentPageNumber++;
  }
}