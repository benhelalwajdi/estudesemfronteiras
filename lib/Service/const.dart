
import 'package:estudesemfronteiras/Entity/courses.dart';

class Const {
  static String ip_adress ='http://192.168.1.123';
  static String port = '8765';
  static String path_courses = '/courses';
  static String courses_by_pages = '?page=';
  static String url ='$ip_adress:$port';
  static List<Courses> futureCourses = [];
  static String getCoursesById = '$url$path_courses$courses_by_pages';
}
