import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthProvider with ChangeNotifier {

 bool _isLoading = false;

 bool get isLoading => _isLoading;

 void setLoading(bool value) {
  _isLoading = value;
  notifyListeners();
 }
 String? _email;

 String? get email => _email;

 String? _fullName;

 String? get fullName => _fullName;

 String? _phone;

 String? get phone => _phone;

 void setPhone(String phone) {
  _phone = phone;
  notifyListeners();
 }


 void setFullname(String fullName) {
  _fullName = fullName;
  notifyListeners();
 }

 void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

 Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _email = null;
    notifyListeners();
  }

}