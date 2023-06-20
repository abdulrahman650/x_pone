class ArticlesModel {
  List<DataBlog>? data;
  int? statusCode;
  String? meta;

  ArticlesModel({this.data, this.statusCode, this.meta});

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataBlog>[];
      json['data'].forEach((v) {
        data!.add(new DataBlog.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    data['meta'] = this.meta;
    return data;
  }
}

class DataBlog {
  int? id;
  String? title;
  String? content;
  int? doctorId;
  String? createdAt;
  String? updatedAt;
  int? status;
  dynamic description;
  String? image;
  Doctor? doctor;

  DataBlog(
      {this.id,
      this.title,
      this.content,
      this.doctorId,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.description,
      this.image,
      this.doctor});

  DataBlog.fromJson(Map<String, dynamic> json) {
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
  dynamic phone;
  String? createdAt;
  String? updatedAt;
  String? email;
  dynamic emailVerifiedAt;
  String? lat;
  String? long;
  String? address;
  dynamic education;
  dynamic notes;
  String? services;
  String? image;

  Doctor(
      {this.id,
      this.name,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.email,
      this.emailVerifiedAt,
      this.lat,
      this.long,
      this.address,
      this.education,
      this.notes,
      this.services,
      this.image});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
    education = json['education'];
    notes = json['notes'];
    services = json['services'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['address'] = this.address;
    data['education'] = this.education;
    data['notes'] = this.notes;
    data['services'] = this.services;
    data['image'] = this.image;
    return data;
  }
}
