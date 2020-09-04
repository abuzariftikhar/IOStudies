import 'package:flutter/foundation.dart';

class Topic {
  String id;
  String subjectId;
  final String name;
  final String imageUrl;
  final String description;
  final String userId;
  List<String> subTopics = List();

  bool isEdit = false;

  Topic({
    this.id = '',
    @required this.subjectId,
    @required this.userId,
    @required this.name,
    @required this.description,
    @required this.imageUrl,
    this.subTopics,
  });

  factory Topic.fromMap(Map<String, dynamic> item) {
    return Topic(
      id: item["id"],
      subjectId: item["subjectId"],
      userId: item["userId"],
      name: item["name"],
      description: item["description"],
      subTopics: item["subTopics"].cast<String>(),
      imageUrl: item["imageUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "subjectId": subjectId,
      "name": name,
      "description": description,
      "imageUrl": imageUrl,
      "userId": userId,
      "subTopics": subTopics,
      "time": DateTime.now().millisecondsSinceEpoch,
    };
  }
}
