class APIManager{
  var url = 'http://192.168.1.123:8765/courses?page='+id;
  static final APIManager _shared = APIManager._internal();

  APIManager._internal();
  factory APIManager(){
    return _shared;
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