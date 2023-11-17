import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchRandomQuote() async {
  final response = await http.get(Uri.parse('https://api.quotable.io/random'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['content'];
  } else {
    throw Exception('Failed to fetch quote');
  }
}


