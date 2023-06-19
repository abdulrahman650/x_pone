class xBoneRegisterModel {
  String? data;
  int? statusCode;
  String? message;
  String? meta;

  xBoneRegisterModel({this.data, this.statusCode, this.message, this.meta});

  xBoneRegisterModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    statusCode = json['status_code'];
    message = json['message'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['meta'] = this.meta;
    return data;
  }
}