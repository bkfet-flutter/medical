import 'package:mephar_app/model/config/role_model.dart';
import 'package:mephar_app/model/config/store_model.dart';
import 'package:mephar_app/model/image_model.dart';

import 'branch_model.dart';

class UserModel {
  int? id;
  String? username;
  String? email;
  String? fullName;
  int? avatarId;
  String? birthday;
  String? gender;
  String? phone;
  int? roleId;
  String? position;
  String? lastLoginAt;
  String? createdAt;
  String? status;
  ImageModel? avatar;
  StoreModel? store;
  BranchModel? branch;
  RoleModel? role;

  UserModel(
      {this.id,
      this.username,
      this.email,
      this.fullName,
      this.avatarId,
      this.birthday,
      this.gender,
      this.phone,
      this.roleId,
      this.position,
      this.lastLoginAt,
      this.createdAt,
      this.status,
      this.avatar,
      this.store,
      this.branch,
      this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullName = json['fullName'];
    avatarId = json['avatarId'];
    birthday = json['birthday'];
    gender = json['gender'];
    phone = json['phone'];
    roleId = json['roleId'];
    position = json['position'];
    lastLoginAt = json['lastLoginAt'];
    createdAt = json['createdAt'];
    status = json['status'];
    avatar = json['avatar'] != null ? ImageModel.fromJson(json['avatar']) : null;
    store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
    branch = json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
    role = json['role'] != null ? RoleModel.fromJson(json['role']) : null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['fullName'] = fullName;
    data['avatarId'] = avatarId;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['phone'] = phone;
    data['roleId'] = roleId;
    data['position'] = position;
    data['lastLoginAt'] = lastLoginAt;
    data['createdAt'] = createdAt;
    data['status'] = status;
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}
