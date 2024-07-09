class ImageModel {
  int? id;
  String? path;
  String? filePath;

  ImageModel({this.id, this.path, this.filePath});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['filePath'] = this.filePath;
    return data;
  }
}
