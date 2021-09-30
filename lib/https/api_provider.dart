import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  static final String apiUrl = 'https://api.mocklets.com/mock68182/screentime';

  Future<dynamic> getData() async {
    var response = await http.get(Uri.parse(apiUrl));
    return response.body;
  }
}
