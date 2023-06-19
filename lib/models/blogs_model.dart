class ArticlesModel {
  Data? data;
  int? statusCode;
  String? meta;

  ArticlesModel({this.data, this.statusCode, this.meta});

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
    statusCode = json['status_code'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = this.statusCode;
    data['meta'] = this.meta;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? content;
  int? doctorId;
  String? createdAt;
  String? updatedAt;
  int? status;
  String? description;
  String? image;
  Doctor? doctor;

  Data(
      {this.id,
        this.title,
        this.content,
        this.doctorId,
        this.updatedAt,
        this.createdAt,
        this.status,
        this.description,
        this.image,
        this.doctor});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    doctorId = json['doctor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    description = json['description'];
    image = json['image'];
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['doctor_id'] = this.doctorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['description'] = this.description;
    data['image'] = this.image;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class Doctor {
  int? id;
  String? name;
  String? phone;
  String? adress;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? emailVerifiedAt;

  Doctor(
      {this.id,
        this.name,
        this.phone,
        this.adress,
        this.createdAt,
        this.updatedAt,
        this.email,
        this.emailVerifiedAt});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    adress = json['adress'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['adress'] = this.adress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    return data;
  }
}