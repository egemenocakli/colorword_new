import 'package:colorword_new/core/base/model/base_model.dart';

class AppUser extends BaseModel {
  final String userId;
  final String email;
  final String name;
  final String lastname;
  final String photo;

  AppUser({
    required this.userId,
    required this.email,
    this.name = "",
    this.lastname = "",
    this.photo = "",
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return AppUser(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
      lastname: json['lastname'],
      photo: json['photoUrl'],
    );
  }

  @override
  Map<String, dynamic>? toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'lastname': lastname,
      'photoUrl': photo,
    };
  }
}
