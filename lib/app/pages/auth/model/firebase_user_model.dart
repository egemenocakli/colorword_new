import 'package:colorword_new/core/auth_manager/model/user_model.dart';
import 'package:colorword_new/core/base/model/base_model.dart';

class FirebaseUser extends BaseModel {
  final String userId;
  final String email;
  final String name;
  final String lastname;
  final String photo;

  FirebaseUser({
    required this.userId,
    required this.email,
    this.name = "",
    this.lastname = "",
    this.photo = "",
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return FirebaseUser(
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

  User? toUser() {
    return User(
      email: email,
      lastname: lastname,
      name: name,
      photo: photo,
      userId: userId,
    );
  }
}
