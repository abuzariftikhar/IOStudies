import 'package:flutter/foundation.dart';

class Subject {
  String id;
  String deciplineId;
  final String name;
  final String imageUrl;

  Subject({
    this.id = '',
    @required this.deciplineId,
    @required this.name,
    @required this.imageUrl,
  });

  factory Subject.fromMap(Map<String, dynamic> item) {
    return Subject(
      id: item["id"],
      deciplineId: item["deciplineId"],
      name: item["name"],
      imageUrl: item["imageUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "deciplineId": deciplineId,
      "name": name,
      "imageUrl": imageUrl,
      "time": DateTime.now().millisecondsSinceEpoch,
    };
  }
}
