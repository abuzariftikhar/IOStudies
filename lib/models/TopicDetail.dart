import 'package:flutter/foundation.dart';

class TopicDetail {
  String id;
  String topicId;
  final String text;
  final String mediaUrl;
  final int align;
  final int type;
  int time;

  TopicDetail({
    this.id = '',
    @required this.topicId,
    @required this.text,
    @required this.type,
    this.align = AlignType.Left,
    this.mediaUrl,
    this.time,
  });

  factory TopicDetail.fromMap(Map<String, dynamic> item) {
    return TopicDetail(
      id: item["id"],
      topicId: item["topicId"],
      text: item["text"],
      type: item["type"],
      mediaUrl: item["imageUrl"],
      align: item["align"],
      time: item["time"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "topicId": topicId,
      "text": text,
      "type": type,
      "imageUrl": mediaUrl,
      "align": align,
      "time": DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class AlignType {
  static const int Left = 0;
  static const int Center = 1;
  static const int Right = 2;
  static const int Justify = 3;
}

class Type {
  static const int SubTopic = 0;
  static const int Heading = 1;
  static const int Text = 2;
  static const int Quote = 3;
  static const int KeyConcept = 4;
  static const int Image = 5;
}
