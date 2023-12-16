import 'dart:convert';

import 'package:http/http.dart' as http;
class AuthToken {
  final String token;

  AuthToken(this.token);
}


class IGDBToken {
  final String accessToken;
  final int expiresIn;
  final String tokenType;

  IGDBToken({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
  });
  factory IGDBToken.fromJson(Map<String, dynamic> json) {
    return IGDBToken(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'] as int,
      tokenType: json['token_type'],
    );
  }
}

Future<IGDBToken> fetchIGDBToken() async {
  final response = await http.post(Uri.parse(
      'https://id.twitch.tv/oauth2/token?client_id=jatk8moav95uswe6bq3zmcy3fokdnw&client_secret=asnff9vhzacquorptuea7q91yabcio&grant_type=client_credentials'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
//ded

    return IGDBToken.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
