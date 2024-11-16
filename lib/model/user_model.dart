class UserModel {
  String? name;
  String? email;
  String? password;
  String? gender;
  String? diabetesCategory;
  String? phone;
  String? accessToken;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.gender,
    this.diabetesCategory,
    this.phone,
    this.accessToken,
  });

  // Factory method to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"] as String?,
        email: json["email"] as String?,
        password: json["password"] as String?,
        gender: json["gender"] as String?,
        diabetesCategory: json["diabetes_category"] as String?,
        phone: json["phone"] as String?,
        accessToken: json["access_token"] as String?,
      );

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "gender": gender,
        "diabetes_category": diabetesCategory,
        "phone": phone,
        if (accessToken != null) "access_token": accessToken,
      };
}
