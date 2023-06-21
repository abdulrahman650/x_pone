class xBoneLoginModel {
  Data? data;
  int? statusCode;
  String? message;
  String? meta;

  xBoneLoginModel({this.data, this.statusCode, this.message, this.meta});

  xBoneLoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    message = json['message'];
    meta = json['meta'];
  }
}

class Data {
  String? accessToken;

  Data({this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }
}