class xBoneLoginModel {
  Data? data;
  int? statusCode;
  String? message;
  String? meta;

  xBoneLoginModel({this.data, this.statusCode, this.message, this.meta});

  xBoneLoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    message = json['message'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['meta'] = this.meta;
    return data;
  }
}

class Data {
  String? accessToken;

  Data({this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    return data;
  }
}




