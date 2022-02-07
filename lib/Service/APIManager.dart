import 'dart:convert';
import 'package:estudesemfronteiras/Entity/courses.dart';
import 'package:estudesemfronteiras/Service/const.dart';
import 'package:http/http.dart' as http;

class APIManager{

  var url = 'http://192.168.1.123:8765/courses?page=';
  static final APIManager _shared = APIManager._internal();

  APIManager._internal();

  factory APIManager(){
    return _shared;
  }

  static Future<List<Courses>> fetchCourses(id) async {
    var url = Const.getCoursesById+id;
    var body;
    var json;
    var parsed;
    final response = await http.get(Uri.parse(url));
    body = response.body;
    json = jsonDecode(body);
    //print(json["courses"].toString());
    parsed = json["courses"].cast<Map<String, dynamic>>();
    //print(parsed.toString());
    return parsed.map<Courses>((json) => Courses.fromMap(json)).toList();
  }

  Future fetchData(int currentPage) async{
    List<String> _list = [];
    int startIndex = currentPage * 10;
    for(int i =startIndex; i< startIndex + 10; i++){
      _list.add("Item #$i");
    }
    return _list;
  }

}