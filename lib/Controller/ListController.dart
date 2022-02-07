import 'dart:core';
import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:estudesemfronteiras/Service/APIManager.dart';
import 'package:flutter/cupertino.dart';

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



  int _currentPageNumber = 0;
  int _totalPage = 30 ;
  DataState _dataState = DataState.Uninitialized ;
  bool get _didLastLoad => _currentPageNumber >= _totalPage;
  DataState get dataState => _dataState ;
  List<Courses> _dataList = [];
  List<Courses> get dataList => _dataList;

  fetchData({bool isRefresh = false}) async{

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

        List<Courses> futureCourses = await APIManager.fetchCourses(1);

        //List<String> list = await APIManager().fetchData(_currentPageNumber);
        if(_dataState == DataState.Refreshing){
          _dataList.clear();
        }
        _dataList += futureCourses;
        _dataState = DataState.Fetched;
        _currentPageNumber += 1 ;
      }
    }catch(e){
      _dataState = DataState.Error;
      notifyListeners();
    }
  }
}