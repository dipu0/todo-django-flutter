class AuthLoginReq {
  final String userName;
  final String password;

  AuthLoginReq({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = userName;
    data['password'] = password;
    return data;
  }
}
