import 'package:flutter/foundation.dart';
import 'package:iostudy/models/TopicDetail.dart';

class TopicDetailFormUiModel {
  String id;
  final String text;
  final String mediaUrl;
  final int type;

  bool isEdit = false;

  TopicDetailFormUiModel({
    this.id = '',
    @required this.text,
    @required this.type,
    this.mediaUrl,
  });

  factory TopicDetailFormUiModel.fromNetworkModel(TopicDetail item) {
    return TopicDetailFormUiModel(
      id: item.id,
      text: item.text,
      type: item.type,
      mediaUrl: item.mediaUrl,
    );
  }
}
