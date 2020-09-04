import 'package:flutter/foundation.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/models/Topic.dart';
import 'package:iostudy/repository/TopicRepository.dart';
import 'package:iostudy/ui_models/TopicUiModel.dart';

class ProfileBloc extends ChangeNotifier {
  TopicRepository _topicRepository = TopicRepositoryImpl();

  List<TopicUiModel> _topicList = List();
  List<TopicUiModel> get topicList => _topicList;

  bool _fetching = true;
  bool get fetching => _fetching;

  Future loadUserTopics() async {
    List<Topic> list = await _topicRepository
        .getAllUserTopic(applicationBlocInstance.firebaseUser.uid);
    print(list.length);
    setTopicList(list
        .map((networkModel) => TopicUiModel.fromNetworkModel(networkModel))
        .toList());
  }

  Future loadTopics(String subjectId) async {
    List<Topic> list = await _topicRepository.getAllTopic(subjectId);
    print(list.length);
    setTopicList(list
        .map((networkModel) => TopicUiModel.fromNetworkModel(networkModel))
        .toList());
  }

  void setTopicList(List<TopicUiModel> subjects) {
    _topicList
      ..clear()
      ..addAll(subjects);
    _fetching = false;
    notifyListeners();
  }
}
