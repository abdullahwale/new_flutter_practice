class User{
  String email;
  String pass;
  String role;
  String academyname;
  User({this.email, this.pass, this.role, this.academyname});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      pass: json['password'] as String,
      role: json['role'] as String,
      academyname: json['academy_name'] as String,
    );
  }
}