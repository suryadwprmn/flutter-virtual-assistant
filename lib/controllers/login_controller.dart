import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxString _token = ''.obs;
  String get token => _token.value;
  void setToken(String token) {
    _token.value = token;
    update();
  }
}
