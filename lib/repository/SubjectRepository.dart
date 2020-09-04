import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iostudy/models/Subject.dart';

abstract class SubjectRepository {
  final String path = "subject";
  Future<List<Subject>> getAllSubjectById(String deciplineId);
  Future<List<Subject>> getAllSubject();
  Future<List<Subject>> getLatestSubjects();
  Future<List<Subject>> getPaginatedSubject(
    String deciplineId,
    String lastVisible,
    int limit,
  );
  Future<Subject> findOneSubject(String id);
}

class SubjectRepositoryImpl extends SubjectRepository {
  @override
  Future<List<Subject>> getAllSubjectById(String deciplineId) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(path)
        .where("deciplineId", isEqualTo: deciplineId)
        .getDocuments();
    var list = snapshot.documents.map((DocumentSnapshot doc) {
      return Subject.fromMap(doc.data);
    }).toList();
    return list;
  }

  @override
  Future<List<Subject>> getPaginatedSubject(
    String deciplineId,
    String lastVisible,
    int limit,
  ) async {
    QuerySnapshot snapshot;
    if (lastVisible == null || lastVisible.isEmpty) {
      snapshot = await Firestore.instance
          .collection(path)
          .where("deciplineId", isEqualTo: deciplineId)
          .orderBy("time")
          .limit(limit)
          .getDocuments();
    } else {
      snapshot = await Firestore.instance
          .collection(path)
          .where("deciplineId", isEqualTo: deciplineId)
          .orderBy("time")
          .startAfter([
            {"id": lastVisible}
          ])
          .limit(limit)
          .getDocuments();
    }
    List<Subject> list = snapshot.documents.map((DocumentSnapshot doc) {
      return Subject.fromMap(doc.data);
    }).toList();
    return list;
  }

  @override
  Future<Subject> findOneSubject(String id) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.document("$path/$id").get();
    Subject item = Subject.fromMap(snapshot.data);
    return item;
  }

  @override
  Future<List<Subject>> getAllSubject() async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection(path).getDocuments();
    var list = snapshot.documents.map((DocumentSnapshot doc) {
      return Subject.fromMap(doc.data);
    }).toList();
    return list;
  }

  @override
  Future<List<Subject>> getLatestSubjects() async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection(path).getDocuments();
    var list = snapshot.documents.map((DocumentSnapshot doc) {
      return Subject.fromMap(doc.data);
    }).toList();
    return list;
  }
}
