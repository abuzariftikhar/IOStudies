import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iostudy/models/Decipline.dart';

abstract class DeciplineRepository {
  final String path = "decipline";
  Future<List<Decipline>> getAllDecipline();
  Future<List<Decipline>> getPaginatedDecipline(String lastVisible, int limit);
  Future<Decipline> findOneDecipline(String id);
}

class DeciplineRepositoryImpl extends DeciplineRepository {
  @override
  Future<List<Decipline>> getAllDecipline() async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection(path).getDocuments();
    var list = snapshot.documents.map((DocumentSnapshot doc) {
      return Decipline.fromMap(doc.data);
    }).toList();
    return list;
  }

  @override
  Future<List<Decipline>> getPaginatedDecipline(
      String lastVisible, int limit) async {
    QuerySnapshot snapshot;
    if (lastVisible == null || lastVisible.isEmpty) {
      snapshot = await Firestore.instance
          .collection(path)
          .orderBy("time")
          .limit(limit)
          .getDocuments();
    } else {
      snapshot = await Firestore.instance
          .collection(path)
          .orderBy("time")
          .startAfter([
            {"id": lastVisible}
          ])
          .limit(limit)
          .getDocuments();
    }
    List<Decipline> list = snapshot.documents.map((DocumentSnapshot doc) {
      return Decipline.fromMap(doc.data);
    }).toList();
    return list;
  }

  @override
  Future<Decipline> findOneDecipline(String id) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.document("$path/$id").get();
    Decipline item = Decipline.fromMap(snapshot.data);
    return item;
  }
}
