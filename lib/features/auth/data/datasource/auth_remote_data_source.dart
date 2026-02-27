import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  Future<String> login({
    required String username,
    required String password,
  }) async {

    final response = await http.post(
      Uri.parse("https://fakestoreapi.com/auth/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username.trim(),
        "password": password.trim(),
      }),
    );
    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data["token"];
    } else {
      throw Exception("Login failed");
    }
  }
}