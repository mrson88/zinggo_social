import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  String? accessToken =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOltdLCJlbWFpbCI6InBodW9uZ2hvYW5nMTcxOUBnbWFpbC5jb20iLCJleHAiOjE2NjMzNDQ0OTksImlhdCI6MTY2MDc1MjQ5OSwiaXNzIjoiIiwianRpIjoiNjQ0MWUyZDItODhmMi00ZTQwLTg4OTktNmZjNDZiNTcyZDIyIiwibmJmIjoxNjYwNzUyNDk5LCJzY3AiOlsib2ZmbGluZSJdLCJzdWIiOiI3MjA2IiwidXNlcl9pZCI6IjcyMDYifQ.b92HDlphkoFxJRqJngmg_femMp2Ouj9O1-Tf82eUVrfZ4NQe5Nt47Iz1ky6hJzN1GG0Bgt5h0VYjV2Ch5B7zVQLo10Rm8pCE9Ct8Ap377IlhFlgAQ2f16Sr7Pg7IhCnreTWLvjts2SFD7CHJ096voDosR88YJwBbPSj6Jd8L-5I';

  factory TokenManager() => _instance;

  TokenManager._internal();

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken!);
  }

  load(SharedPreferences pref) async {
    accessToken = pref.getString('access_token') ?? '';
    debugPrint('accessToken $accessToken');
  }
}
