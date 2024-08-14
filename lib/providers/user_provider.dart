import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  User? _selectedUser;
  int _currentPage = 1;

  List<User> get users => _users;
  User? get selectedUser => _selectedUser;

  Future<void> fetchUsers({int page = 1, int perPage = 6}) async {
    final url = 'https://reqres.in/api/users?page=$page&per_page=$perPage';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> userJson = data['data'];
      _users = userJson.map((json) => User.fromJson(json)).toList();
      notifyListeners();
    }
  }

  void selectUser(User user) {
    _selectedUser = user;
    notifyListeners();
  }

  void resetUsers() {
    _users = [];
    _currentPage = 1;
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    _currentPage++;
    await fetchUsers(page: _currentPage);
  }
}
