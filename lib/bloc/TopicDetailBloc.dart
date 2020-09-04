import 'package:flutter/foundation.dart';
import 'package:iostudy/models/TopicDetail.dart';
import 'package:iostudy/repository/TopicRepository.dart';
import 'package:iostudy/ui_models/TopicDetailFormUiModel.dart';
import 'package:iostudy/ui_models/TopicUiModel.dart';

class TopicDetailBloc extends ChangeNotifier {
  TopicRepository _topicRepository = TopicRepositoryImpl();
  bool isLoading = true;

  TopicUiModel topic;

  List<TopicDetailFormUiModel> topicDetails = List<TopicDetailFormUiModel>();

  void loadTopicDetail(TopicUiModel topic) async {
    this.topic = topic;
    print("Topic: $topic");

    List<TopicDetail> details = await _topicRepository.getTopicDetail(topic.id);
    topicDetails = details
        .map((item) => TopicDetailFormUiModel.fromNetworkModel(item))
        .toList();
    isLoading = false;
    notifyListeners();
  }
}
