// import 'login_model.dart';
//
// class xBoneProfileModel {
//   Data? data;
//   int? statusCode;
//   String? meta;
//
//   xBoneProfileModel({this.data, this.statusCode, this.meta});
//
//   xBoneProfileModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     statusCode = json['status_code'];
//     meta = json['meta'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['status_code'] = this.statusCode;
//     data['meta'] = this.meta;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? image;
//   String? lat;
//   String? long;
//   String? emailVerifiedAt;
//   String? createdAt;
//   String? updatedAt;
//
//   Data(
//       {this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.image,
//         this.lat,
//         this.long,
//         this.emailVerifiedAt,
//         this.createdAt,
//         this.updatedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     lat = json['lat'];
//     long = json['long'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['image'] = this.image;
//     data['lat'] = this.lat;
//     data['long'] = this.long;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
