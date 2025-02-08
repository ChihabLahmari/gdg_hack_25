import 'dart:convert';

import 'package:my_template/features/auth/ui/select_skills_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/user.dart';

class LocalStorageService {
  static const String _userKey = 'user_key';
  static const String _questionsKey = 'questions_key';
  static const String _userPrefersKey = 'user_prefers_key';
  static const String _tokenKey = 'token_key';

  // Instance method to save user to local storage
  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  // Instance method to get user from local storage
  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      Map<String, dynamic> userMap = json.decode(userJson);
      return User.fromJson(userMap);
    }
    return null; // If no user is found, return null
  }

  // Instance method to remove user from local storage
  Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  /// Save list of questions to local storage
  Future<void> saveQuestions(List<Question> questions) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> questionsJson = questions.map((q) => json.encode(q.toJson())).toList();
    await prefs.setStringList(_questionsKey, questionsJson);
  }

  /// Get list of questions from local storage
  Future<List<Question>> getQuestions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? questionsJson = prefs.getStringList(_questionsKey);
    if (questionsJson != null) {
      return questionsJson.map((q) => Question.fromJson(json.decode(q))).toList();
    }
    return []; // Return empty list if no questions are found
  }

  /// Remove questions from local storage
  Future<void> removeQuestions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_questionsKey);
  }

  /// Save user preference (userPrefers)
  Future<void> saveUserPrefers(String userPrefers) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userPrefersKey, userPrefers);
  }

  /// Get user preference (userPrefers)
  Future<String?> getUserPrefers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPrefersKey);
  }

  /// Remove user preference (userPrefers)
  Future<void> removeUserPrefers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userPrefersKey);
  }

  /// Save user preference (userPrefers)
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Get user preference (Token)
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Remove user preference (Token)
  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userPrefersKey);
  }
}
