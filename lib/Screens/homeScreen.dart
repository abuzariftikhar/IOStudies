import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iostudy/Screens/components/FabMenu.dart';
import 'package:iostudy/Screens/subjectScreen.dart';
import 'package:iostudy/Screens/topicListScreen.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/bloc/HomeBloc.dart';
import 'package:iostudy/ui_models/DeciplineUiModel.dart';
import 'package:iostudy/ui_models/SubjectUiModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String navtag = "home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "Abuzar";

  HomeBloc bloc;

  List<int> colors = [0xffFFDFE2, 0xffCFE7FB, 0xffE8EDDF, 0xffF2E2D2];
  Random random = Random();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = Provider.of<HomeBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  // stretch: true,
                  pinned: true,
                  floating: true,
                  snap: true,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.all(15),
                    background: Image.asset(
                      "assets/images/home2.png",
                      alignment: Alignment.bottomRight,
                    ),
                    title: Text(
                      "Welcome,\n${applicationBlocInstance.authStore?.isLoggedIn() == true ? applicationBlocInstance.firebaseUser?.displayName : 'Guest'}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  expandedHeight: 180,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "features");
                      },
                      child: Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          height: 200,
                          decoration: BoxDecoration(
                              color: Color(0xffeff9fa),
                              borderRadius: BorderRadius.circular(25)),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topRight,
                                child: Hero(
                                  tag: "features",
                                  child: Image.asset(
                                      "assets/images/featuresbanner.png"),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "Take a look at app's\nexciting features such as...\n\n  Quizes\n  Bookmarking\n  Tips & Tricks\n  & many more...")),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(Icons.arrow_forward),
                              )
                            ],
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(10),
                        child: Center(
                            child: Text("It\'s a good day to study..."))),
                    Container(
                        // padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(15),
                        child: Text(
                          "Pick a decipline",
                          style: TextStyle(fontSize: 22),
                        )),
                    Container(
                      height: 200,
                      child: Consumer<HomeBloc>(
                        builder: (context, bloc, child) {
                          if (bloc.deciplineListFetching) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount: bloc.deciplineList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              DeciplineUiModel item = bloc.deciplineList[i];
                              int color = colors[random.nextInt(colors.length)];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    SubjectScreen.navtag,
                                    arguments: item,
                                  );
                                },
                                child: DeciplineListItem(
                                  item.name,
                                  color,
                                  item.imageUrl,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "Or, continue where you left off",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: Consumer<HomeBloc>(
                        builder: (context, bloc, child) {
                          if (bloc.subjectListFetching) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount: bloc.subjectList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              SubjectUiModel item = bloc.subjectList[i];
                              int color = colors[random.nextInt(colors.length)];

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
                                  color,
                                  item.imageUrl,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "Newly added subjects",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: Consumer<HomeBloc>(
                        builder: (context, bloc, child) {
                          if (bloc.latestSubjectFetching) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount: bloc.subjectList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              SubjectUiModel item = bloc.subjectList[i];
                              int color = colors[random.nextInt(colors.length)];

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
                                  color,
                                  item.imageUrl,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 20,
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
        FabMenu(),
      ],
    );
  }
}

class DeciplineListItem extends StatefulWidget {
  final int color;
  final String title;
  final String imageaddr;
  DeciplineListItem(this.title, this.color, this.imageaddr);
  @override
  _DeciplineListItemState createState() => _DeciplineListItemState();
}

class _DeciplineListItemState extends State<DeciplineListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 12),
        padding: EdgeInsets.all(15),
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(widget.color)),
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
