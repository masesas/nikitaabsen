import 'package:nikitaabsen/models/request/document_sakit.dart';

class DocumentSick {
  String? requestType;
  String? userId;
  String? sickRequestDateFrom;
  String? sickRequestDateTo;
  List<UserSickDocument>? userSickDocument;

  DocumentSick(
      {this.requestType,
      this.userId,
      this.sickRequestDateFrom,
      this.sickRequestDateTo,
      this.userSickDocument});

  DocumentSick.fromJson(Map<String, dynamic> json) {
    requestType = json['request_type'];
    userId = json['user_id'];
    sickRequestDateFrom = json['sick_request_date_from'];
    sickRequestDateTo = json['sick_request_date_to'];
    if (json['user_sick_document'] != null) {
      userSickDocument = <UserSickDocument>[];
      json['user_sick_document'].forEach((v) {
        userSickDocument!.add(new UserSickDocument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_type'] = this.requestType;
    data['user_id'] = this.userId;
    data['sick_request_date_from'] = this.sickRequestDateFrom;
    data['sick_request_date_to'] = this.sickRequestDateTo;
    if (this.userSickDocument != null) {
      data['user_sick_document'] =
          this.userSickDocument!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
