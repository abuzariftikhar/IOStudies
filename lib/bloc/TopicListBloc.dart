import 'package:flutter/foundation.dart';
import 'package:iostudy/models/Topic.dart';
import 'package:iostudy/repository/TopicRepository.dart';
import 'package:iostudy/ui_models/SubjectUiModel.dart';
import 'package:iostudy/ui_models/TopicUiModel.dart';

class TopicListBloc extends ChangeNotifier {
  TopicRepository _topicRepository = TopicRepositoryImpl();

  List<TopicUiModel> _topicList = List();
  List<TopicUiModel> get topicList => _topicList;

  bool _fetching = true;
  bool get fetching => _fetching;
  SubjectUiModel subject;

  String subjectId;

  Future loadTopics(SubjectUiModel subject) async {
    this.subject = subject;
    List<Topic> list = await _topicRepository.getAllTopic(subject.id);
    print("Topic length ${list.length}");
    setSubjectList(list
        .map((networkModel) => TopicUiModel.fromNetworkModel(networkModel))
        .toList());
  }

  void setSubjectList(List<TopicUiModel> subjects) {
    _topicList
      ..clear()
      ..addAll(subjects);

    _fetching = false;
    notifyListeners();
  }
}
