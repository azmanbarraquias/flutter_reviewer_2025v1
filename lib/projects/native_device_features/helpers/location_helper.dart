import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyDPD56ZQLCFiFJZhXY04XTB5FoGqw0WiGk';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double lat,
    required double long,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$lat,$long'
        '&zoom=16'
        '&size=600x300'
        '&maptype=roadmap'
        '&markers=color:red%7Clabel:A%7C$lat,$long'
        '&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
