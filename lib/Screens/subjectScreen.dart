import 'package:flutter/material.dart';
import 'package:iostudy/Screens/components/FabMenu.dart';
import 'package:iostudy/Screens/topicListScreen.dart';
import 'package:iostudy/bloc/SubjectListBloc.dart';
import 'package:iostudy/ui_models/DeciplineUiModel.dart';
import 'package:provider/provider.dart';

class SubjectScreen extends StatefulWidget {
  static String navtag = "subjectsScreen";
  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
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
    DeciplineUiModel deciplineUiModel =
        ModalRoute.of(context).settings.arguments;
    Provider.of<SubjectListBloc>(context, listen: false)
        .loadSubject(deciplineUiModel);
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
                            "Select a Subject from the list",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<SubjectListBloc>(
                  builder: (context, bloc, child) {
                    if (bloc.subjectListFetching) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          Center(child: CircularProgressIndicator()),
                        ]),
                      );
                    }
                    // Empty Placeholder
                    if (bloc.subjectList.isEmpty) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          Column(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Image.network(
                                    bloc.deciplineUiModel.imageUrl,
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
                                    "No subject found in ${bloc.deciplineUiModel.name} decipline",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      );
                    }
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var item = bloc.subjectList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                TopicListScreen.navtag,
                                arguments: item,
                              );
                            },
                            child: DeciplineListItem(
                              item.name,
                              item.imageUrl,
                            ),
                          );
                        },
                        childCount: bloc.subjectList.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    );
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                margin: EdgeInsets.symmetric(horizontal: 50),
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

class DeciplineListItem extends StatefulWidget {
  final String title;
  final String imageaddr;
  DeciplineListItem(this.title, this.imageaddr);
  @override
  _DeciplineListItemState createState() => _DeciplineListItemState();
}

class _DeciplineListItemState extends State<DeciplineListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          left: 8,
          top: 16,
          right: 8,
        ),
        padding: EdgeInsets.all(15),
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.network(widget.imageaddr),
            )
          ],
        ));
  }
}
