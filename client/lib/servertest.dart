import 'package:http/http.dart' as http;

void main() async {
  const url = 'http://localhost:8080/persons';

  try {
    final response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  } catch (e) {
    print('Failed to connect to server: $e');
  }
}
