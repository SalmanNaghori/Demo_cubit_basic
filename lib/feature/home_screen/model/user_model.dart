class User {
  final int id;
  final String name;
  final String number;
  final String gender;

  User({
    required this.id,
    required this.name,
    required this.number,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      number: json['number'] as String,
      gender: json['gender'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'gender': gender,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, number: $number, gender: $gender}';
  }
}
