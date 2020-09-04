import 'package:flutter/foundation.dart';
import 'package:iostudy/models/TopicDetail.dart';

class TopicDetailUiModel {
  String id;
  final String text;
  final String mediaUrl;
  final int align;
  final int type;

  TopicDetailUiModel({
    this.id = '',
    @required this.text,
    @required this.type,
    this.align = AlignType.Left,
    this.mediaUrl,
  });

  factory TopicDetailUiModel.fromNetworkModel(TopicDetail item) {
    return TopicDetailUiModel(
      id: item.id,
      text: item.text,
      type: item.type,
      mediaUrl: item.mediaUrl,
      align: item.align,
    );
  }
}
