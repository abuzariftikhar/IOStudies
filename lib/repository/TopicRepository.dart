import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:iostudy/models/Topic.dart';
import 'package:iostudy/models/TopicDetail.dart';

abstract class TopicRepository {
  final String topicPath = "topic";
  final String topicDetailPath = "topicDetail";
  Future<List<Topic>> getAllTopic(String subjectId);
  Future<List<Topic>> getAllUserTopic(String userId);
  Future<List<Topic>> getPaginatedTopic(
    String subjectId,
    String lastVisible,
    int limit,
  );
  Future<Topic> findOneTopic(String id);
  Future<List<TopicDetail>> getTopicDetail(String topicId);
  Future<Topic> createTopic(Topic topic);
  Future<bool> createTopicDetail(Topic topic, TopicDetail detail);
  Future<bool> updateTopic(Topic topic);
  Future<bool> updateTopicDetail(Topic topic, TopicDetail detail);
}

class TopicRepositoryImpl extends TopicRepository {
  @override
  Future<List<Topic>> getAllTopic(String subjectId) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(topicPath)
        .where("subjectId", isEqualTo: subjectId)
        .getDocuments();
    var list = snapshot.documents.map((DocumentSnapshot doc) {
      return Topic.fromMap(doc.data);
    }).toList();
    return list;
  }

  @override
  Future<List<Topic>> getAllUserTopic(String userId) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(topicPath)
        .where("userId", isEqualTo: userId)
        .getDocuments();
    var list = snapshot.documents.map((DocumentSnapshot doc) {
      return Topic.fromMap(doc.data);
    }).toList();
    return list;
  }

  @override
  Future<List<Topic>> getPaginatedTopic(
    String subjectId,
    String lastVisible,
    int limit,
  ) async {
    QuerySnapshot snapshot;
    if (lastVisible == null || lastVisible.isEmpty) {
      snapshot = await Firestore.instance
          .collection(topicPath)
          .where("subjectId", isEqualTo: subjectId)
          .orderBy("time")
          .limit(limit)
          .getDocuments();
    } else {
      snapshot = await Firestore.instance
          .collection(topicPath)
          .where("subjectId", isEqualTo: subjectId)
          .orderBy("time")
          .startAfter([
            {"id": lastVisible}
          ])
          .limit(limit)
          .getDocuments();
    }
    List<Topic> list = snapshot.documents.map((DocumentSnapshot doc) {
      return Topic.fromMap(doc.data);
    }).toList();
    return list;
  }

  @override
  Future<Topic> findOneTopic(String id) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.document("$topicPath/$id").get();
    Topic item = Topic.fromMap(snapshot.data);
    return item;
  }

  @override
  Future<List<TopicDetail>> getTopicDetail(String topicId) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(topicDetailPath)
        .where("topicId", isEqualTo: topicId)
        .getDocuments();
    var list = snapshot.documents.map((DocumentSnapshot doc) {
      return TopicDetail.fromMap(doc.data);
    }).toList();
    list.sort((a, b) => a.time.compareTo(b.time));
    return list;
  }

  @override
  Future<Topic> createTopic(Topic topic) async {
    try {
      DocumentReference ref =
          Firestore.instance.collection(topicPath).document();
      topic.id = ref.documentID;
      await ref.setData(topic.toMap());

      return topic;
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  @override
  Future<bool> updateTopic(Topic topic) async {
    try {
      DocumentReference ref =
          Firestore.instance.document("$topicPath/${topic.id}");
      await ref.setData(topic.toMap());

      return true;
    } catch (e) {
      debugPrint(e);
      return false;
    }
  }

  @override
  Future<bool> createTopicDetail(Topic topic, TopicDetail detail) async {
    try {
      DocumentReference ref =
          Firestore.instance.document("$topicPath/${topic.id}");
      await ref.setData(topic.toMap());

      ref = Firestore.instance.collection(topicDetailPath).document();
      detail.id = ref.documentID;
      detail.topicId = topic.id;
      await ref.setData(detail.toMap());

      return true;
    } catch (e) {
      debugPrint(e);
      return false;
    }
  }

  @override
  Future<bool> updateTopicDetail(Topic topic, TopicDetail detail) async {
    try {
      DocumentReference ref =
          Firestore.instance.document("$topicPath/${topic.id}");
      await ref.setData(topic.toMap());

      // if item id exist then delete
      if (detail.id.isNotEmpty) {
        ref = Firestore.instance.document("$topicDetailPath/${detail.id}");
        detail.topicId = topic.id;
        await ref.delete();
      }

      ref = Firestore.instance.collection(topicDetailPath).document();
      detail.id = ref.documentID;
      detail.topicId = topic.id;
      detail.time = DateTime.now().millisecondsSinceEpoch;
      await ref.setData(detail.toMap());

      return true;
    } catch (e) {
      debugPrint(e);
      return false;
    }
  }
}
