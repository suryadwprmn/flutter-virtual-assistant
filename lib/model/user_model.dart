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
  // String? accessToken;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.diabetesCategory,
    required this.phone,
    // this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        diabetesCategory: json["diabetes_category"],
        phone: json["phone"],
        // accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "gender": gender,
        "diabetes_category": diabetesCategory,
        "phone": phone,
        // if (accessToken != null) "access_token": accessToken
      };
}
