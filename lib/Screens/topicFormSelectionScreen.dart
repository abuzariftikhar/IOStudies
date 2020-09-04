import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iostudy/Screens/topicDetailFormScreen.dart';
import 'package:iostudy/bloc/TopicFormSelectionBloc.dart';
import 'package:provider/provider.dart';

class TopicFormSelectionScreen extends StatefulWidget {
  static String navtag = "topicFormSelection";
  @override
  _TopicFormSelectionScreenState createState() =>
      _TopicFormSelectionScreenState();
}

class _TopicFormSelectionScreenState extends State<TopicFormSelectionScreen> {
  TopicFormSelectionBloc bloc;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController topicNameController;
  TextEditingController topicDescriptionController;

  @override
  void initState() {
    super.initState();

    topicNameController = TextEditingController();
    topicDescriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<TopicFormSelectionBloc>(context);
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              Container(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(
                            height: 100,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffcaf2f3)),
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                              Text(
                                "Topic",
                                style: TextStyle(fontSize: 36),
                              ),
                              Text("lets make the world better")
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Consumer<TopicFormSelectionBloc>(
                              builder: (context, bloc, child) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xffaaaaaa),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    value: bloc.selectedDecipline == null
                                        ? null
                                        : bloc.selectedDecipline.id,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    hint: Text("Select Decipline"),
                                    items: bloc.deciplineList.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item.name),
                                        value: item.id,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      bloc.setSelectedDecipline(newValue);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Consumer<TopicFormSelectionBloc>(
                              builder: (context, bloc, child) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xffaaaaaa),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    value: bloc.selectedSubject == null
                                        ? null
                                        : bloc.selectedSubject.id,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    hint: Text("Select Subject"),
                                    items: bloc.subjectList.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item.name),
                                        value: item.id,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      bloc.setSelectedSubject(newValue);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Consumer<TopicFormSelectionBloc>(
                              builder: (context, bloc, child) {
                                return TextField(
                                  keyboardType: TextInputType.text,
                                  controller: topicNameController,
                                  decoration: InputDecoration(
                                      hintText: "Your topic name",
                                      labelText: "Topic Name",
                                      errorText: bloc.topicNameError,
                                      fillColor: Color(0xffcaf2f3),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xffcaf2f3)))),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Consumer<TopicFormSelectionBloc>(
                              builder: (context, bloc, child) {
                                return TextField(
                                  keyboardType: TextInputType.text,
                                  controller: topicDescriptionController,
                                  decoration: InputDecoration(
                                    hintText: "Add topic breif description",
                                    labelText: "Topic description",
                                    errorText: bloc.topicDescriptionError,
                                    fillColor: Color(0xffcaf2f3),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xffcaf2f3),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OutlineButton(
                                  child: Text("Next"),
                                  onPressed: () async {
                                    bloc.setTopicName(topicNameController.text);
                                    bloc.setTopicDescription(
                                        topicDescriptionController.text);

                                    bool isSuccess = await bloc.postTopic();
                                    if (isSuccess) {
                                      Navigator.pushNamed(
                                        context,
                                        TopicDetailFormScreen.navtag,
                                        arguments: bloc.topic,
                                      );
                                    } else {
                                      _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Make sure you are selecting decipline and subject"),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bloc.isLoading
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Color(0x7fffffff),
                      child: AbsorbPointer(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          )),
    );
  }
}
