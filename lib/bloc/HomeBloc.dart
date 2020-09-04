import 'package:flutter/foundation.dart';
import 'package:iostudy/models/Decipline.dart';
import 'package:iostudy/models/Subject.dart';
import 'package:iostudy/repository/DeciplineRepository.dart';
import 'package:iostudy/repository/SubjectRepository.dart';
import 'package:iostudy/ui_models/DeciplineUiModel.dart';
import 'package:iostudy/ui_models/SubjectUiModel.dart';

class HomeBloc extends ChangeNotifier {
  List<DeciplineUiModel> _deciplineList = List();
  List<DeciplineUiModel> get deciplineList => _deciplineList;

  bool _deciplineListFetching = true;
  bool get deciplineListFetching => _deciplineListFetching;

  List<SubjectUiModel> _subjectList = List();
  List<SubjectUiModel> get subjectList => _subjectList;

  bool _subjectListFetching = true;
  bool get subjectListFetching => _subjectListFetching;

  List<SubjectUiModel> _latestSubjectList = List();
  List<SubjectUiModel> get latestSubjectList => _latestSubjectList;

  bool _latestSubjectFetching = true;
  bool get latestSubjectFetching => _latestSubjectFetching;

  DeciplineRepository _deciplineRepository = DeciplineRepositoryImpl();
  SubjectRepository _subjectRepository = SubjectRepositoryImpl();

  HomeBloc() {
    loadDecipline();
    loadSubject();
    loadLatestSubject();
  }

  Future loadDecipline() async {
    List<Decipline> list = await _deciplineRepository.getAllDecipline();
    print(list.length);
    setDeciplineList(list
        .map((networkModel) => DeciplineUiModel.fromNetworkModel(networkModel))
        .toList());
  }

  void setDeciplineList(List<DeciplineUiModel> deciplines) {
    _deciplineList
      ..clear()
      ..addAll(deciplines);
    _deciplineListFetching = false;
    notifyListeners();
  }

  Future loadSubject() async {
    List<Subject> list = await _subjectRepository.getAllSubject();
    print(list.length);
    setSubjectList(list
        .map((networkModel) => SubjectUiModel.fromNetworkModel(networkModel))
        .toList());
  }

  void setSubjectList(List<SubjectUiModel> subjects) {
    _subjectList
      ..clear()
      ..addAll(subjects);
    _subjectListFetching = false;
    notifyListeners();
  }

  Future loadLatestSubject() async {
    List<Subject> list = await _subjectRepository.getLatestSubjects();
    setLatestSubjectList(list
        .map((networkModel) => SubjectUiModel.fromNetworkModel(networkModel))
        .toList());
  }

  void setLatestSubjectList(List<SubjectUiModel> subjects) {
    _latestSubjectList
      ..clear()
      ..addAll(subjects);
    _latestSubjectFetching = false;
    notifyListeners();
  }
}
