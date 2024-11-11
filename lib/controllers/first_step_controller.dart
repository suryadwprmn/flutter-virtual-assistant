import 'package:get/get.dart';

class FirstStepController extends GetxController {
  final RxString _userName = 'User'.obs;

  String get userName => _userName.value;

  void setUserName(String name) {
    _userName.value = name;
  }
}
