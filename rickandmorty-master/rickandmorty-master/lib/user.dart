// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String email;
  String name;
  String birthday;
  String password;
  User({
    required this.email,
    required this.name,
    required this.birthday,
    required this.password,
  });

  User copyWith({
    String? email,
    String? name,
    String? birthday,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'birthday': birthday,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      name: map['name'] as String,
      birthday: map['birthday'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(email: $email, name: $name, birthday: $birthday, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.name == name &&
      other.birthday == birthday &&
      other.password == password;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      name.hashCode ^
      birthday.hashCode ^
      password.hashCode;
  }
}
