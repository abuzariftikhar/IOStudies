import 'package:flutter/foundation.dart';

class Decipline {
  String id;
  final String name;
  final String imageUrl;

  Decipline({
    this.id = '',
    @required this.name,
    @required this.imageUrl,
  });

  factory Decipline.fromMap(Map<String, dynamic> item) {
    return Decipline(
      id: item["id"],
      name: item["name"],
      imageUrl: item["imageUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "time": DateTime.now().millisecondsSinceEpoch,
    };
  }
}
