import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modals/photo.dart';

class PhotoRepository {
  Future<List<Photo>> fetchPhotosByAlbum(int albumId) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/photos?albumId=$albumId'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Photo.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load photos for album $albumId");
    }
  }
}
