import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxString _token = ''.obs;
  String get token => _token.value;
  void setToken(String token) {
    _token.value = token;
    update();
  }

  // Fungsi validasi email
  bool validateEmail(String email) {
    return email.isNotEmpty &&
        email.contains('@') &&
        email.endsWith('@gmail.com');
  }

  bool validatePassword(String password) {
    return password.length >= 6;
  }
}
