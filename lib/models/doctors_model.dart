class DoctorsModel {
  List<Data>? data;
  int? statusCode;
  Meta? meta;

  DoctorsModel({this.data, this.statusCode, this.meta});

  DoctorsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? address;
  String? lat;
  String? long;
  dynamic education;
  dynamic notes;
  List<String>? services;
  String? image;

  Data(
      {this.id,
        this.name,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.email,
        this.address,
        this.lat,
        this.long,
        this.education,
        this.notes,
        this.services,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    education = json['education'];
    notes = json['notes'];
    services = json['services'].cast<String>();
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
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['education'] = this.education;
    data['notes'] = this.notes;
    data['services'] = this.services;
    data['image'] = this.image;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsCount;
  int? pagesCount;

  Meta({this.currentPage, this.itemsCount, this.pagesCount});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    itemsCount = json['items_count'];
    pagesCount = json['pages_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['items_count'] = this.itemsCount;
    data['pages_count'] = this.pagesCount;
    return data;
  }
}