// class DoctorsModel {
//   List<DataDoctor>? data;
//   int? statusCode;
//   Meta? meta;
//
//   DoctorsModel({this.data, this.statusCode, this.meta});
//
//   DoctorsModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <DataDoctor>[];
//       json['data'].forEach((v) {
//         data!.add(new DataDoctor.fromJson(v));
//       });
//     }
//     statusCode = json['status_code'];
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['status_code'] = this.statusCode;
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     return data;
//   }
// }
//
// class DataDoctor {
//   int? id;
//   String? name;
//   String? phone;
//   String? createdAt;
//   String? updatedAt;
//   String? email;
//   String? address;
//   String? lat;
//   String? long;
//   String? price;
//
//   dynamic education;
//   dynamic notes;
//   List<String>? services;
//   String? image;
//
//   DataDoctor(
//       {this.id,
//       this.name,
//       this.phone,
//       this.createdAt,
//       this.updatedAt,
//       this.email,
//       this.address,
//       this.lat,
//       this.price,
//       this.long,
//       this.education,
//       this.notes,
//       this.services,
//       this.image});
//
//   DataDoctor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     phone = json['phone'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     email = json['email'];
//     address = json['address'];
//     lat = json['lat'];
//     long = json['long'];
//     long = json['price'];
//     education = json['education'];
//     notes = json['notes'];
//     services = json['services'] is List ? List<String>.from(json['services'] ?? []) : [];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['email'] = this.email;
//     data['address'] = this.address;
//     data['lat'] = this.lat;
//     data['price'] = this.price;
//     data['long'] = this.long;
//     data['education'] = this.education;
//     data['notes'] = this.notes;
//     data['services'] = this.services;
//     data['image'] = this.image;
//     return data;
//   }
// }
//
// class Meta {
//   int? currentPage;
//   int? itemsCount;
//   int? pagesCount;
//
//   Meta({this.currentPage, this.itemsCount, this.pagesCount});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     itemsCount = json['items_count'];
//     pagesCount = json['pages_count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     data['items_count'] = this.itemsCount;
//     data['pages_count'] = this.pagesCount;
//     return data;
//   }
// }
class DoctorsModel {
  List<DataDoctor>? data;
  int? statusCode;
  Meta? meta;

  DoctorsModel({this.data, this.statusCode, this.meta});

  DoctorsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataDoctor>[];
      json['data'].forEach((v) {
        data!.add(new DataDoctor.fromJson(v));
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

class DataDoctor {
  int? id;
  String? name;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? address;
  String? lat;
  String? long;
  int? price;
  WorkingHours? workingHours;
  String? education;
  String? notes;
  List<String>? services;
  String? image;
  int? rating;

  DataDoctor(
      {this.id,
        this.name,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.email,
        this.address,
        this.lat,
        this.long,
        this.price,
        this.workingHours,
        this.education,
        this.notes,
        this.services,
        this.image,
        this.rating});

  DataDoctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    price = json['price'];
    workingHours = json['working_hours'] != null
        ? new WorkingHours.fromJson(json['working_hours'])
        : null;
    education = json['education'];
    notes = json['notes'];
    services = json['services'].cast<String>();
    image = json['image'];
    rating = json['rating'];
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
    data['price'] = this.price;
    if (this.workingHours != null) {
      data['working_hours'] = this.workingHours!.toJson();
    }
    data['education'] = this.education;
    data['notes'] = this.notes;
    data['services'] = this.services;
    data['image'] = this.image;
    data['rating'] = this.rating;
    return data;
  }
}

class WorkingHours {
  String? start;
  String? end;

  WorkingHours({this.start, this.end});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
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
