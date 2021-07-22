import 'dart:convert';
import 'package:htb_mobile/data/models/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  final _url = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> getPosts() async {
    try {
      final uri = Uri.https(_url, '/posts');
      final res = await http.get(uri);
      final list = json.decode(res.body) as List;
      final posts = list.map((post) => Post.fromJson(post)).toList();
      print(posts.toString());
      return posts;
    } catch (e) {
      // throw e;
      print(e);
    }
  }
}
