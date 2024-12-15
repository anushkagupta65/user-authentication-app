import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final Uri issuerUri = Uri.parse('http://localhost:8080/realms/myrealm');
  final String clientId = 'flutter-auth-app';
  final String clientSecret = '2yaKprsXLuuikxxINatLEwhKStGzHaOk';
  final String redirectUri =
      'http://localhost:8080/realms/myrealm/broker/oidc/endpoint';

  Uri get tokenEndpoint => issuerUri.replace(
      path: '${issuerUri.path}/protocol/openid-connect/token');

  Future<Map<String, dynamic>?> loginWithCredentials(
      String username, String password) async {
    try {
      var response = await http.post(
        tokenEndpoint,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'password',
          'client_id': clientId,
          'username': username,
          'password': password,
          if (clientSecret.isNotEmpty) 'client_secret': clientSecret,
        },
      );

      if (response.statusCode == 200) {
        var tokenData = jsonDecode(response.body);
        // final accessToken = tokenData['access_token'];
        return tokenData;
      } else {
        print('Login failed: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Login error: $error');
      return null;
    }
  }
}
