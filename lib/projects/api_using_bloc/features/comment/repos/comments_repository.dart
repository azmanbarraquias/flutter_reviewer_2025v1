import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../albums/modals/comment.dart';

class CommentRepository {
  final String apiUrl = "https://jsonplaceholder.typicode.com/comments";

  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Comment.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load comments");
    }
  }
}