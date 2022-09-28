import 'package:flutter/cupertino.dart';
import '../models/user.dart' as AppUser;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _userPhone;
  String _userName;
  String _otp;
  String _token;
  bool _isNewUser;
  bool _isValidPhone = false;
  int _score;
  AppUser.User _user;

  void setScore(int score) {
    _score = score;
    notifyListeners();
  }

  int get score {
    return _score;
  }

  void setUserPhone(String phone) {
    _userPhone = phone;
    notifyListeners();
  }

  String get userPhone {
    return _userPhone;
  }

  void seToken(String token) async {
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', token);
    _token = token;
    notifyListeners();
  }

  String get token {
    return _token;
  }

  void setUserName(String userName) {
    _userName = userName;
    // user.name = userName;

    notifyListeners();
  }

  String get userName {
    return _userName;
  }

  void setOtp(String otp) {
    _otp = otp;

    notifyListeners();
  }

  String get otp {
    return _otp;
  }

  void setIsNewUser(bool isNewUser) {
    _isNewUser = isNewUser;
    notifyListeners();
  }

  bool get isNewUser {
    return _isNewUser;
  }

  void setIsValidPhone(bool isValidPhone) {
    _isValidPhone = isValidPhone;
    notifyListeners();
  }

  bool get isValidPhone {
    return _isValidPhone;
  }

  void setUser(AppUser.User user) {
    _user = user;
    notifyListeners();
  }

  AppUser.User get user {
    return _user;
  }

  void logout() {
    _userPhone = null;
    _userName = null;
    _otp = null;
    _token = null;
    _isNewUser = null;
    _score = null;
    AppUser.User _user = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
