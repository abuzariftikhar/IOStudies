import 'package:flutter/foundation.dart';
import 'package:iostudy/models/Decipline.dart';

class DeciplineUiModel {
  String id;
  final String name;
  final String imageUrl;

  DeciplineUiModel({
    this.id = '',
    @required this.name,
    @required this.imageUrl,
  });

  factory DeciplineUiModel.fromNetworkModel(Decipline item) {
    return DeciplineUiModel(
      id: item.id,
      name: item.name,
      imageUrl: item.imageUrl,
    );
  }
}
