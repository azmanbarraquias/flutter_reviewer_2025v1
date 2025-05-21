import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modals/post.dart';

class PostRepository {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
