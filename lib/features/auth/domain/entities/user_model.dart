class User {
  final String? userid;
  final String? username;
  final String? email;
  final String? token;

  User({
    this.userid,
    this.username,
    this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['UUID']?.toString(),
      username: json['username']?.toString(),
      email: json['email']?.toString(),
      token: json['token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UUID': userid,
      'username': username,
      'email': email,
      'token': token,
    };
  }
}
