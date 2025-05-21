import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../comment/modals/album.dart';

class AlbumRepository {
  final String apiUrl = "https://jsonplaceholder.typicode.com/albums";

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load albums");
    }
  }
}
