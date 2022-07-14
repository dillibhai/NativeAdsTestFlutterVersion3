// To parse this JSON data, do
//
//     final feedModel = feedModelFromJson(jsonString);

import 'dart:convert';

List<FeedModel> feedModelFromJson(String str) =>
    List<FeedModel>.from(json.decode(str).map((x) => FeedModel.fromJson(x)));

String feedModelToJson(List<FeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedModel {
  FeedModel({
    this.id,
    this.title,
    this.description,
    this.content,
    this.link,
    this.source,
    this.category,
    this.author,
    this.image,
    this.uuid,
    this.views,
    this.isSyndicated,
  });

  int? id;
  String? title;
  String? description;
  String? content;
  String? link;
  String? source;
  String? category;
  String? author;
  String? image;
  String? uuid;
  int? views;
  String? isSyndicated;

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        content: json["content"],
        link: json["link"],
        source: json["source"],
        category: json["category"],
        author: json["author"],
        image: json["image"],
        uuid: json["uuid"],
        views: json["views"],
        isSyndicated: json["is_syndicated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "content": content,
        "link": link,
        "source": source,
        "category": category,
        "author": author,
        "image": image,
        "uuid": uuid,
        "views": views,
        "is_syndicated": isSyndicated,
      };
}
