class Student {
  int? id;
  String name;
  String email;
  Student({this.id, required this.name, required this.email});
  factory Student.valueFromJson(Map<String, dynamic> json) {
    return Student(
        id: json["id"] as int,
        name: json["name"] as String,
        email: json["email"] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "name: $name, email: $email";
  }
}
