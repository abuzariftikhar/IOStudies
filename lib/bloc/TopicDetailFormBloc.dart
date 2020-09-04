import 'package:flutter/foundation.dart';
import 'package:iostudy/models/Topic.dart';
import 'package:iostudy/models/TopicDetail.dart';
import 'package:iostudy/repository/TopicRepository.dart';
import 'package:iostudy/ui_models/TopicDetailFormUiModel.dart';

class TopicDetailFormBloc extends ChangeNotifier {
  TopicRepository _topicRepository = TopicRepositoryImpl();
  bool isLoading = false;

  Topic topic;

  int selectedType = Type.Text;
  String text = "";
  String imageUrl;

  bool isEdit = false;

  bool isEditItemOpen = false;

  int editIndex = -1;

  List<TopicDetailFormUiModel> topicDetail = List<TopicDetailFormUiModel>();

  void setItemType(int type) {
    selectedType = type;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void addTopicDetailItem() {
    TopicDetailFormUiModel model = TopicDetailFormUiModel(
      text: text,
      type: selectedType,
      mediaUrl: imageUrl,
    );

    topicDetail.add(model);

    reset();
    notifyListeners();
  }

  void removeTopicDetailItem(int index) {
    topicDetail.removeAt(index);
    notifyListeners();
  }

  void setTopicDetailItem() {
    isEditItemOpen = false;
    TopicDetailFormUiModel model = TopicDetailFormUiModel(
      text: text,
      type: selectedType,
      mediaUrl: imageUrl,
    );

    topicDetail[editIndex] = model;

    reset();
    notifyListeners();
  }

  // for edit case
  void loadTopicDetail() async {
    isLoading = true;

    List<TopicDetail> networkList =
        await _topicRepository.getTopicDetail(topic.id);
    topicDetail = networkList.map((item) {
      return TopicDetailFormUiModel(
        id: item.id,
        text: item.text,
        type: item.type,
        mediaUrl: item.mediaUrl,
      );
    }).toList();

    await Future.delayed(Duration(milliseconds: 1000), () {
      isLoading = false;
      notifyListeners();
    });
  }

  Future publishArticle() async {
    isLoading = true;
    notifyListeners();

    List<String> subTopics = topicDetail.where((item) {
      return item.type == Type.SubTopic;
    }).map((item) {
      return item.text;
    }).toList();
    topic.subTopics = subTopics;

    if (isEdit) {
      await _topicRepository.updateTopic(topic);
    } else {
      topic = await _topicRepository.createTopic(topic);
    }

    for (TopicDetailFormUiModel item in topicDetail) {
      if (isEdit) {
        var topicDetail = TopicDetail(
          id: item.id,
          topicId: topic.id,
          text: item.text,
          type: item.type,
          mediaUrl: item.mediaUrl,
        );
        await _topicRepository.updateTopicDetail(topic, topicDetail);
      } else {
        var topicDetail = TopicDetail(
          topicId: topic.id,
          text: item.text,
          type: item.type,
          mediaUrl: item.mediaUrl,
        );
        await _topicRepository.createTopicDetail(topic, topicDetail);
      }
    }

    isLoading = false;
    notifyListeners();
  }

  void openEditItem(int index) {
    this.editIndex = index;
    isEditItemOpen = true;

    TopicDetailFormUiModel item = topicDetail[index];
    item.isEdit = true;

    topicDetail[index] = item;
    notifyListeners();
  }

  bool validateImage() {
    if (imageUrl.isEmpty) {
      return false;
    }
    return true;
  }

  void reset() {
    text = "";
    imageUrl = "";
    editIndex = -1;
  }
}
