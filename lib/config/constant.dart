class Constant {
  static final String url = 'https://jsonplaceholder.typicode.com';

  static String token;

  static String getInstanceMethod(String method, String id) {
    return "$method?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&itemId=$id";
  }

  static var isSearchbyPhoto;
  static var ratingCategory;
  static var taobaoCategory;
  static var alibabaCategory;
  static var bannerList;
  static var globalImageSearch;
  static var isTaobao = true;
  static var currentCategory;
  static var currentSearch;
  static var photo = "";
  static List<String> selectedProperties = <String>[];
  static List<Map<String, String>> selectedConfig = <Map<String, String>>[];

  static var qty = 1;
  static List<Map<String, String>> filterProperties = <Map<String, String>>[];
  static final String khUrl = 'http://178.128.110.84/htb_demo/api_v1';

  static String getToken() {
    return token;
  }
}
