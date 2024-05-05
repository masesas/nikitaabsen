class DataRegister {
  String? fullname;
  String? email;
  String? password;
  String? companyCode;
  bool? isMobile;
  String? photo;

  DataRegister(
      {this.fullname,
      this.email,
      this.password,
      this.companyCode,
      this.isMobile,
      this.photo});

  DataRegister.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    companyCode = json['company_code'];
    isMobile = json['is_mobile'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['company_code'] = this.companyCode;
    data['is_mobile'] = this.isMobile;
    data['photo'] = this.photo;
    return data;
  }
}
