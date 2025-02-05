import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hobby.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.14:8000/index.php?url=ApiHobby/getAll";

  static Future<List<Hobby>> fetchHobbies() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Hobby.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load hobbies");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
