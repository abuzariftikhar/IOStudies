import 'package:flutter/material.dart';
import 'package:iostudy/Screens/components/FabMenu.dart';
import 'package:iostudy/Screens/components/TopicComponents.dart';
import 'package:iostudy/Screens/topicDetailScreen.dart';
import 'package:iostudy/bloc/TopicListBloc.dart';
import 'package:iostudy/ui_models/SubjectUiModel.dart';
import 'package:provider/provider.dart';

class TopicListScreen extends StatefulWidget {
  static String navtag = "topicListScreen";
  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicListScreen> {
  bool showingtitle = false;
  bool scrolled = false;
  ScrollController _controller;
  List<String> subjectlist = [];

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset <= 50) {
        setState(() {
          showingtitle = false;
        });
      } else {
        setState(() {
          showingtitle = true;
        });
      }
      _controller.addListener(() {
        if (_controller.offset > 5) {
          setState(() {
            scrolled = true;
          });
        } else {
          setState(() {
            scrolled = false;
          });
        }
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SubjectUiModel subject = ModalRoute.of(context).settings.arguments;
    Provider.of<TopicListBloc>(context, listen: false).loadTopics(subject);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _controller,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        margin: EdgeInsets.only(bottom: 10),
                        height: 110,
                        color: Colors.white,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Select a Topic from the list",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      Consumer<TopicListBloc>(
                        builder: (context, bloc, child) {
                          if (bloc.fetching) {
                            return Center(child: CircularProgressIndicator());
                          }

                          // Empty Placeholder
                          if (bloc.topicList.isEmpty) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Image.network(
                                      bloc.subject.imageUrl,
                                      alignment: Alignment(0, 0.5),
                                      width: 200,
                                      height: 400,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "No topic found in ${bloc.subject.name} Subject",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Column(
                            children: bloc.topicList.map(
                              (item) {
                                return GestureDetector(
                                  onTap: () {
                                    print("Topic CLICKED");
                                    Navigator.pushNamed(
                                      context,
                                      TopicDetailScreen.navtag,
                                      arguments: item,
                                    );
                                  },
                                  child: SubItem(
                                    item.name,
                                    item.description,
                                    item.subTopics,
                                  ),
                                );
                              },
                            ).toList(),
                          );
                        },
                      ),
                      //some space
                      AddSpace(3),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: scrolled ? Colors.black26 : Colors.transparent,
                      blurRadius: 4,
                    ),
                  ],
                ),
                height: 50,
                child: Center(
                  child: AnimatedCrossFade(
                    firstChild: Text("Select a subject"),
                    secondChild: Container(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        "assets/images/logo.png",
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    crossFadeState: showingtitle
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 100),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-1, -1),
              child: BackButton(),
            ),
            FabMenu(),
          ],
        ),
      ),
    );
  }
}

class SubItem extends StatefulWidget {
  final String title;
  final String description;
  final List<String> _subtopic;

  SubItem(this.title, this.description, this._subtopic);
  @override
  _SubItemState createState() => _SubItemState();
}

class _SubItemState extends State<SubItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
          // boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)],
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.description,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 10),
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Wrap(
              children: widget._subtopic.take(3).map(
                (subTopic) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 160),
                      child: Chip(
                        backgroundColor: Colors.white,
                        label: Text(
                          subTopic,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
