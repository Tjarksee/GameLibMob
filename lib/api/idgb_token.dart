import 'dart:convert';

import 'package:http/http.dart' as http;

class IGDBToken {
  final String access_token;
  final int expires_in;
  final String token_type;

  IGDBToken({
    required this.access_token,
    required this.expires_in,
    required this.token_type,
  });
  factory IGDBToken.fromJson(Map<String, dynamic> json) {
    return IGDBToken(
      access_token: json['access_token'],
      expires_in: json['expires_in'] as int,
      token_type: json['token_type'],
    );
  }
}

Future<IGDBToken> fetchIGDBToken() async {
  final response = await http.post(Uri.parse(
      'https://id.twitch.tv/oauth2/token?client_id=jatk8moav95uswe6bq3zmcy3fokdnw&client_secret=asnff9vhzacquorptuea7q91yabcio&grant_type=client_credentials'));
  print(response.body);

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