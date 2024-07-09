import 'package:mephar_app/model/image_model.dart';

class PromotionProgramModel {
  int? id;
  String? title;
  String? slug;
  String? alt;
  int? imageId;
  String? link;
  String? description;
  String? sponsor;
  int? status;
  String? startTime;
  String? endTime;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ImageModel? image;

  PromotionProgramModel(
      {this.id,
      this.title,
      this.slug,
      this.alt,
      this.imageId,
      this.link,
      this.description,
      this.sponsor,
      this.status,
      this.startTime,
      this.endTime,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.image});

  PromotionProgramModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    alt = json['alt'];
    imageId = json['imageId'];
    link = json['link'];
    description = json['description'];
    sponsor = json['sponsor'];
    status = json['status'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    image =
        json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['alt'] = this.alt;
    data['imageId'] = this.imageId;
    data['link'] = this.link;
    data['description'] = this.description;
    data['sponsor'] = this.sponsor;
    data['status'] = this.status;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}
