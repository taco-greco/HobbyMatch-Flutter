import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hobby.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000";

  static Future<List<Hobby>> fetchHobbies(int page) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/ApiHobby/getAll/$page'));

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
  static Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/loginjwt'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mail': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['token'];
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}