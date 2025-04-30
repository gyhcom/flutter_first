import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;

  User({
    required this.id,
    this.fullName = '',
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
  });
  // 직렬화(Serialization): User 객체를 Map으로 변환
  // Map: 키-값 쌍의 집합
  // 목적: 객체를 저장하거나 전송할 수 있도록 JSON과 같은 형식으로 변환하기 위한 중간 단계
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
  // JSON: JavaScript Object Notation, 데이터 교환 형식
  // JSON을 Map으로 변환하는 과정

  // 역직렬화(Deserialization): Map을 User 객체로 변환
  // Map: JSON과 같은 형식으로 변환된 데이터를 다시 객체로 변환하기 위한 중간 단계
  // 목적: 저장된 데이터나 전송된 데이터를 다시 객체로 변환하여 사용하기 위한 과정

  //fromMap: Map을 User 객체로 변환하는 메서드
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      locality: map['locality'] as String? ?? '',
      password: map['password'] as String? ?? '',
    );
  }

  // fromJson: JSON 문자열을 User 객체로 변환하는 메서드
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
