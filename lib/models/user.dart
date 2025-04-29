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
    required this.fullName,
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
}
