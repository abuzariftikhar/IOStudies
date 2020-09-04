import 'package:flutter/foundation.dart';
import 'package:iostudy/models/Topic.dart';

class TopicUiModel {
  String id;
  final String name;
  final String imageUrl;
  final String description;
  final String subjectId;
  final String userId;
  final List<String> subTopics;

  TopicUiModel({
    this.id = '',
    @required this.name,
    @required this.description,
    @required this.imageUrl,
    @required this.subTopics,
    @required this.userId,
    @required this.subjectId,
  });

  factory TopicUiModel.fromNetworkModel(Topic item) {
    return TopicUiModel(
      id: item.id,
      name: item.name,
      description: item.description,
      imageUrl: item.imageUrl,
      subTopics: item.subTopics,
      userId: item.userId,
      subjectId: item.subjectId,
    );
  }
}
