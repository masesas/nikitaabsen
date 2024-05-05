class LoginRequest {
  String? email;
  String? password;
  String? strategy;

  LoginRequest({this.email, this.password, this.strategy});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    strategy = json['strategy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['strategy'] = this.strategy;
    return data;
  }
}
