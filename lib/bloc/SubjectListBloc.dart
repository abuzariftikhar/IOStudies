import 'package:flutter/foundation.dart';
import 'package:iostudy/models/Subject.dart';
import 'package:iostudy/repository/SubjectRepository.dart';
import 'package:iostudy/ui_models/DeciplineUiModel.dart';
import 'package:iostudy/ui_models/SubjectUiModel.dart';

class SubjectListBloc extends ChangeNotifier {
  SubjectRepository _subjectRepository = SubjectRepositoryImpl();

  List<SubjectUiModel> _subjectList = List();
  List<SubjectUiModel> get subjectList => _subjectList;

  bool _subjectListFetching = true;
  bool get subjectListFetching => _subjectListFetching;

  DeciplineUiModel deciplineUiModel;

  String deciplineId;

  Future loadSubject(DeciplineUiModel deciplineUiModel) async {
    this.deciplineUiModel = deciplineUiModel;
    List<Subject> list =
        await _subjectRepository.getAllSubjectById(deciplineUiModel.id);
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
}
