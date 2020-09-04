import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iostudy/Screens/components/FabMenu.dart';
import 'package:iostudy/Screens/components/TopicComponents.dart';
import 'package:iostudy/Screens/loginScreen.dart';
import 'package:iostudy/Screens/topicDetailFormScreen.dart';
import 'package:iostudy/Screens/topicFormSelectionScreen.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/bloc/TopicDetailBloc.dart';
import 'package:iostudy/models/Topic.dart';
import 'package:iostudy/models/TopicDetail.dart';
import 'package:iostudy/preferences.dart';
import 'package:iostudy/ui_models/TopicUiModel.dart';
import 'package:provider/provider.dart';

class TopicDetailScreen extends StatefulWidget {
  static String navtag = "topicDetailScreen";
  @override
  _TopicDetailScreenState createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  ScrollController _controller;
  AnimationController _fabIconController;
  bool openedMenu = false;
  String g;
  double expheight = 50;
  double revboxwidth = double.maxFinite;
  double elevation = 0;
  bool darkmode = false;
  double bradius = 0;
  int tbcolor = 0xffffffff;
  // double expheight = 100;
  @override
  void initState() {
    _controller = ScrollController();
    _fabIconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _controller.addListener(() {
      if (_controller.offset <= 50) {
        setState(() {
          revboxwidth = 700;
          elevation = 0;
          _visible = false;
          tbcolor = 0xffffffff;
        });
      } else {
        setState(() {
          revboxwidth = 700;
          _visible = true;
          elevation = 5;
          tbcolor = 0x00ffffff;
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    TopicUiModel topic = ModalRoute.of(context).settings.arguments ??
        TopicUiModel(
          id: "fzkLx27jCYYydn6EBQ9Q",
          name: "My Topic Title",
          description: "Description",
          imageUrl: null,
          subTopics: List(),
          subjectId: "null",
          userId: "null",
        );
    Provider.of<TopicDetailBloc>(context, listen: false).loadTopicDetail(topic);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: openedMenu ? Colors.red : Colors.white,
        //   onPressed: () {
        //     setState(() {
        //       if (!openedMenu) {
        //         openedMenu = true;
        //         _fabIconController.forward();
        //         expheight = MediaQuery.of(context).size.height / 2;
        //       } else if (expheight == MediaQuery.of(context).size.height / 2) {
        //         openedMenu = false;
        //         _fabIconController.reverse();
        //         expheight = 50;
        //       }
        //     });
        //   },
        //   child: AnimatedIcon(
        //     icon: AnimatedIcons.menu_close,
        //     progress: _fabIconController,
        //     color: openedMenu ? Colors.white : Colors.black,
        //   ),
        // ),
        body: Stack(
          children: <Widget>[
            AnimatedContainer(
              height: expheight,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
              child: getWidget(),
            ),
            Material(
              color: Colors.white,
              child: CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      AddSpace(2.5),
                      Consumer<TopicDetailBloc>(
                        builder: (context, bloc, child) {
                          return TitleText(bloc.topic.name);
                        },
                      ),
                    ]),
                  ),
                  Consumer<TopicDetailBloc>(
                    builder: (context, bloc, child) {
                      if (bloc.isLoading) {
                        return SliverList(
                          delegate: SliverChildListDelegate([
                            Center(child: CircularProgressIndicator()),
                          ]),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          bloc.topicDetails.map((item) {
                            if (item.type == Type.Text) {
                              return OnlyText(item.text);
                            }
                            if (item.type == Type.Heading) {
                              return Heading(item.text);
                            }
                            if (item.type == Type.SubTopic) {
                              return SubtopicText(item.text);
                            }
                            if (item.type == Type.Image) {
                              return NImagewithCaption(
                                item.mediaUrl,
                                item.text,
                              );
                            }
                            if (item.type == Type.KeyConcept) {
                              return KeyPoint(item.text);
                            }
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              height: expheight,
              curve: Curves.bounceInOut,
              duration: Duration(milliseconds: 300),
              child: getWidget(),
            ),
            BackButton(),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _fabIconController,
                  color: openedMenu ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    if (!openedMenu) {
                      openedMenu = true;
                      _fabIconController.forward();
                      expheight = MediaQuery.of(context).size.height / 2;
                    } else if (expheight ==
                        MediaQuery.of(context).size.height / 2) {
                      openedMenu = false;
                      _fabIconController.reverse();
                      expheight = 50;
                    }
                  });
                },
              ),
            ),
            gettitle(),
            Consumer<TopicDetailBloc>(
              builder: (context, bloc, child) {
                if (bloc.topic.userId ==
                    applicationBlocInstance.firebaseUser?.uid) {
                  return Align(
                    alignment: Alignment(-1, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Material(
                        shape: CircleBorder(),
                        color: Color(0xffe6b440),
                        elevation: 4,
                        child: IconButton(
                          onPressed: () {
                            Topic topic = Topic(
                              id: bloc.topic.id,
                              subjectId: bloc.topic.subjectId,
                              userId: bloc.topic.userId,
                              name: bloc.topic.name,
                              description: bloc.topic.description,
                              imageUrl: bloc.topic.imageUrl,
                            );
                            topic.isEdit = true;
                            Navigator.of(context).pushNamed(
                              TopicDetailFormScreen.navtag,
                              arguments: topic,
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            FabMenu(),
          ],
        ),
      ),
    );
  }

  Widget gettitle() {
    Widget _widget;
    if (expheight == 50) {
      _widget = Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            opacity: _visible ? 0 : 1,
            child: Container(
              height: 30,
              width: 30,
              child: Image.asset(
                "assets/images/logo.png",
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      );
    } else {
      _widget = Container();
    }
    return _widget;
  }

  Widget getWidget() {
    Widget widget;
    if (expheight == 50) {
      bradius = 0;
      widget = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 2, sigmaX: 8),
          child: Material(
            color: Colors.white70,
            elevation: elevation,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Consumer<TopicDetailBloc>(
                    builder: (context, bloc, child) {
                      return Text(
                        bloc.topic.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    width: revboxwidth,
                    height: double.maxFinite,
                    color: Color(tbcolor),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      bradius = 20;
      widget = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(bradius),
                    bottomRight: Radius.circular(bradius)),
                color: Color(0x200014aa)),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: 50,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Options",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Dark theme",
                              style: TextStyle(color: Colors.black),
                            ),
                            Switch(
                              value: darkmode,
                              onChanged: (darkmode) {
                                darkmode = !darkmode;
                                return darkmode;
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, top: 10),
                        child: Center(
                          child: Text(
                            "Adjust the slider to set font size.",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            accentTextTheme: TextTheme(
                              body2: TextStyle(color: Colors.black),
                            ),
                          ),
                          child: Slider(
                            value: Preferences.textScaleFactor,
                            max: 1.4,
                            min: 1,
                            divisions: 4,
                            label: g =
                                getSliderLable(Preferences.textScaleFactor),
                            onChanged: (value) {
                              setState(() {
                                Preferences.textScaleFactor = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Current font size: $g",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Contribute to application",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(width: 16),
                            RaisedButton.icon(
                              color: Color(0xffe6b440),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              onPressed: () {
                                if (applicationBlocInstance.authStore
                                    .isLoggedIn()) {
                                  Navigator.of(context).pushNamed(
                                    TopicFormSelectionScreen.navtag,
                                  );
                                } else {
                                  Navigator.of(context).pushNamed(
                                    LoginScreen.navtag,
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Add Topic",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return widget;
  }

  String getSliderLable(double value) {
    if (value < 1.1) {
      return "Default";
    }
    if (value < 1.2) {
      return "Medium";
    }
    if (value < 1.25) {
      return "Large";
    }
    if (value < 1.4) {
      return "Extra Large";
    }
    if (value < 1.5) {
      return "Huge";
    }
    return "Extra Large";
  }
}
