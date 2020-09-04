import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iostudy/Screens/components/FabMenu.dart';
import 'package:iostudy/Screens/homeScreen.dart';
import 'package:iostudy/Screens/topicDetailScreen.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/bloc/ProfileBloc.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String navtag = "profileScreen";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollcontroller;
  Color firstcolor = Colors.pink;
  Color secondcolor = Colors.indigo;

  Animation<double> animation;
  AnimationController _controller;
  String likescount;
  String articlessub;
  AnimationController _controllerarti;
  Animation<double> animationarti;

  @override
  void initState() {
    _scrollcontroller = ScrollController();

    _scrollcontroller.addListener(() {
      if (_scrollcontroller.offset <= 20) {
        setState(() {
          firstcolor = Colors.pink;
          secondcolor = Colors.indigo;
        });
      } else if (_scrollcontroller.offset <= 300) {
        setState(() {
          firstcolor = Color(0xffFAACA8);
          secondcolor = Color(0xffDDD6F3);
        });
      } else if (_scrollcontroller.offset <= 700) {
        setState(() {
          firstcolor = Color(0xff8EC5FC);
          secondcolor = Color(0xffE0C3FC);
        });
      } else if (_scrollcontroller.offset <= 1200) {
        setState(() {
          firstcolor = Color(0xffFFFB7D);
          secondcolor = Color(0xff85FFBD);
        });
      }
    });
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation objects value
          likescount = animation.value.toStringAsFixed(0);
        });
      });
    _controller.forward();
    _controllerarti = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<ProfileBloc>(context, listen: false).loadUserTopics();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    Provider.of<ProfileBloc>(context, listen: false).dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds: 2),
            width: double.maxFinite,
            height: 300,
            decoration: BoxDecoration(
              gradient: SweepGradient(
                colors: [firstcolor, secondcolor],
              ),
            ),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 70, sigmaY: 40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                ),
                width: double.maxFinite,
                height: 300,
              ),
            ),
          ),
          Container(
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(seconds: 3),
                  decoration: BoxDecoration(
                    gradient: SweepGradient(colors: [secondcolor, firstcolor]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white60,
                        spreadRadius: 1,
                      ),
                      BoxShadow(color: Colors.white10, blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      applicationBlocInstance.firebaseUser.photoUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white60),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 2, left: 5, right: 2),
                            child: Text(
                              applicationBlocInstance.firebaseUser.displayName,
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.check_circle,
                              size: 18,
                              color: Color(0xff3AB795),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white60,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Container(
                        margin: EdgeInsets.only(top: 2, left: 5),
                        child: Text("Moderator"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment(1, -1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton.icon(
                  onPressed: () async {
                    await applicationBlocInstance.setLogin(false);
                    Navigator.of(context).popUntil(
                      ModalRoute.withName(HomeScreen.navtag),
                    );
                  },
                  icon: Icon(Icons.exit_to_app),
                  label: Text("Logout"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: AnimatedContainer(
                height: MediaQuery.of(context).size.height - 250,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 10)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                duration: Duration(milliseconds: 150),
                child: CustomScrollView(
                  controller: _scrollcontroller,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              "Stats",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Container(
                            height: 150,
                            padding: EdgeInsets.all(15),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 120,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: articlessub == null
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : Text(
                                                  "$articlessub",
                                                  style:
                                                      TextStyle(fontSize: 36),
                                                ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              "Topics submitted",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 120,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(
                                                "$likescount",
                                                style: TextStyle(fontSize: 36),
                                              ),
                                            )),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(
                                                "Likes",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              "List of submitted topics",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Consumer<ProfileBloc>(
                            builder: (context, bloc, child) {
                              if (bloc.fetching) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              animationarti = Tween<double>(
                                begin: 0,
                                end: bloc.topicList.length.toDouble(),
                              ).animate(_controllerarti)
                                ..addListener(() {
                                  setState(() {
                                    // The state that has changed here is the animation objects value
                                    articlessub =
                                        animationarti.value.toStringAsFixed(0);
                                  });
                                });
                              _controllerarti.forward();

                              return Column(
                                children: bloc.topicList.map(
                                  (item) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          TopicDetailScreen.navtag,
                                          arguments: item,
                                        );
                                      },
                                      child: TopicSubmittedItem(
                                        item.name,
                                        item.subTopics,
                                      ),
                                    );
                                  },
                                ).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          FabMenu(),
        ],
      ),
    );
  }
}

class TopicSubmittedItem extends StatefulWidget {
  final String _title;
  final List<String> _subtopic;
  TopicSubmittedItem(this._title, this._subtopic);
  @override
  _TopicSubmittedItemState createState() => _TopicSubmittedItemState();
}

class _TopicSubmittedItemState extends State<TopicSubmittedItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(right: 25),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Topic Title: ${widget._title}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Wrap(
            children: widget._subtopic.take(4).map((text) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 160),
                  child: Chip(
                    backgroundColor: Colors.grey.shade200,
                    label: Text(text),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
