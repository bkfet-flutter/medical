class PermissionModel {
  String? name;
  String? description;
  List<Permissions>? permissions;

  PermissionModel({this.name, this.description, this.permissions});

  PermissionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  String? model;
  String? action;
  String? parentId;
  bool? select;
  int? id;

  Permissions({this.model, this.action, this.select});

  Permissions.fromJson(Map<String, dynamic> json) {
    select = false;
    model = json['model'];
    id = json['id'];
    action = json['action'];
    parentId = json['parentId'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Permissions && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['action'] = action;
    return data;
  }
}
