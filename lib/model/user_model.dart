import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String email;
  String password;
  String gender;
  String diabetesCategory;
  String phone;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.diabetesCategory,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        diabetesCategory: json["diabetes_category"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "gender": gender,
        "diabetes_category": diabetesCategory,
        "phone": phone,
      };
}
