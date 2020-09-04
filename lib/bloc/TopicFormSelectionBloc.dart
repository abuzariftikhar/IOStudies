import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/common/AuthStore.dart';
import 'package:iostudy/models/Decipline.dart';
import 'package:iostudy/models/Subject.dart';
import 'package:iostudy/models/Topic.dart';
import 'package:iostudy/repository/DeciplineRepository.dart';
import 'package:iostudy/repository/SubjectRepository.dart';
import 'package:iostudy/repository/TopicRepository.dart';
import 'package:iostudy/ui_models/DeciplineUiModel.dart';
import 'package:iostudy/ui_models/SubjectUiModel.dart';

class TopicFormSelectionBloc extends ChangeNotifier {
  List<DeciplineUiModel> _deciplineList = List();
  List<DeciplineUiModel> get deciplineList => _deciplineList;

  DeciplineUiModel selectedDecipline;

  bool _deciplineListFetching = true;
  bool get deciplineListFetching => _deciplineListFetching;

  List<SubjectUiModel> _subjectList = List();
  List<SubjectUiModel> get subjectList => _subjectList;

  SubjectUiModel selectedSubject;

  bool _subjectListFetching = true;
  bool get subjectListFetching => _subjectListFetching;

  String _topicName = "";
  String get topicName => _topicName;

  String topicNameError;

  String _topicDescription = "";
  String get topicDescription => _topicDescription;

  String topicDescriptionError;

  bool _topicPostingComplete = false;
  bool get topicPostingComplete => _topicPostingComplete;

  bool isLoading = false;

  Topic topic;

  DeciplineRepository _deciplineRepository = DeciplineRepositoryImpl();
  SubjectRepository _subjectRepository = SubjectRepositoryImpl();
  TopicRepository _topicRepository = TopicRepositoryImpl();

  TopicFormSelectionBloc() {
    loadDecipline();
  }

  Future loadDecipline() async {
    List<Decipline> list = await _deciplineRepository.getAllDecipline();
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
    List<Subject> list =
        await _subjectRepository.getAllSubjectById(selectedDecipline.id);
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

  void setTopicName(String name) {
    _topicName = name;
    _topicPostingComplete = false;
  }

  void setTopicDescription(String description) {
    _topicDescription = description;
    _topicPostingComplete = false;
  }

  void setSelectedDecipline(String deciplineId) {
    selectedDecipline = deciplineList.firstWhere((item) {
      return item.id == deciplineId;
    });
    selectedSubject = null;
    notifyListeners();
    loadSubject();
  }

  void setSelectedSubject(String subjectId) {
    selectedSubject = subjectList.firstWhere((item) {
      return item.id == subjectId;
    });
    notifyListeners();
  }

  Future<bool> postTopic() async {
    bool isValid = _validate();
    notifyListeners();
    if (isValid) {
      isLoading = true;
      notifyListeners();

      topic = Topic(
        subjectId: selectedSubject.id,
        name: topicName,
        description: topicDescription,
        userId: applicationBlocInstance.firebaseUser.uid,
        imageUrl: null,
      );

      isLoading = false;
      notifyListeners();

      return topic != null;
    } else {
      return false;
    }
  }

  bool _validate() {
    if (selectedSubject == null) {
      return false;
    }
    if (selectedDecipline == null) {
      return false;
    }
    if (_topicName.length < 5) {
      topicNameError = "Topic name must be greater than 5 characters";
      return false;
    } else {
      topicNameError = null;
    }
    if (_topicDescription.length < 5) {
      topicDescriptionError =
          "Topic description must be greater than 5 characters";
      return false;
    } else {
      topicDescriptionError = null;
    }

    return true;
  }
}
