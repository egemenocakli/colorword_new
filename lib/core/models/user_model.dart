class User {
  final String userId;
  final String email;
  final String name;
  final String lastname;
  final String photo;

  User({
    required this.userId,
    required this.email,
    this.name = "",
    this.lastname = "",
    this.photo = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'lastname': lastname,
      'photoUrl': photo,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        email = map['email'],
        name = map['name'],
        lastname = map['lastname'],
        photo = map['photoUrl'];
}
