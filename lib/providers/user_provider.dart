import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  String? get uid => null;

  String? get username => null;

  String? get photoUrl => null;

  Future<void> refereshUser() async {
    User user = (await _authMethods.getUserDetails()) as User;

    _user = user;

    notifyListeners();
  }
}
