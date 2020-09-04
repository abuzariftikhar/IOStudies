import 'package:flutter/foundation.dart';
import 'package:iostudy/models/Subject.dart';

class SubjectUiModel {
  String id;
  final String name;
  final String imageUrl;

  SubjectUiModel({
    this.id = '',
    @required this.name,
    @required this.imageUrl,
  });

  factory SubjectUiModel.fromNetworkModel(Subject item) {
    return SubjectUiModel(
      id: item.id,
      name: item.name,
      imageUrl: item.imageUrl,
    );
  }
}
