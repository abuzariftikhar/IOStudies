import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iostudy/Screens/components/TopicComponents.dart';
import 'package:iostudy/Screens/topicFormSelectionScreen.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/bloc/TopicDetailFormBloc.dart';
import 'package:iostudy/models/Topic.dart';
import 'package:iostudy/models/TopicDetail.dart';
import 'package:provider/provider.dart';

class TopicDetailFormScreen extends StatefulWidget {
  static String navtag = "topicDetailFormScreen";
  @override
  _TopicDetailFormScreenState createState() => _TopicDetailFormScreenState();
}

class _TopicDetailFormScreenState extends State<TopicDetailFormScreen> {
  TopicDetailFormBloc bloc;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController topicTextFieldController;

  FocusNode focusNode;

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    topicTextFieldController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bloc = Provider.of<TopicDetailFormBloc>(context, listen: false);
    // Set setting argument
    bloc.topic = ModalRoute.of(context).settings.arguments;
    bloc.isEdit = bloc.topic.isEdit;
    if (bloc.isEdit && bloc.isEdit != isEdit) {
      isEdit = bloc.isEdit;
      bloc.loadTopicDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SizedBox(
                                height: 64,
                              ),
                              TitleText(bloc.topic?.name ?? "Title"),
                              Consumer<TopicDetailFormBloc>(
                                builder: (context, bloc, _) {
                                  var i = 0;
                                  print(bloc.topicDetail.length);
                                  return Column(
                                    children: bloc.topicDetail.map((item) {
                                      final int index = i;
                                      i++;
                                      if (item.type == Type.Text) {
                                        if (item.isEdit) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                text: item.text,
                                              ),
                                              cursorColor: Colors.black,
                                              autofocus: true,
                                              maxLines: 1000,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.done,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: "",
                                              ),
                                              onSubmitted: (String text) {
                                                if (text.isNotEmpty) {
                                                  print(text);
                                                  bloc.text = text;
                                                  bloc.setTopicDetailItem();
                                                }
                                                topicTextFieldController.text =
                                                    "";
                                              },
                                            ),
                                          );
                                        } else {
                                          return Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment(0, 0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      bloc.openEditItem(index);
                                                    },
                                                    child: OnlyText(item.text),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment(-1, -1),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    bloc.removeTopicDetailItem(
                                                        index);
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }
                                      if (item.type == Type.Heading) {
                                        if (item.isEdit) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                text: item.text,
                                              ),
                                              cursorColor: Colors.black,
                                              autofocus: true,
                                              maxLines: 1000,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.done,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: "",
                                              ),
                                              onSubmitted: (String text) {
                                                if (text.isNotEmpty) {
                                                  print(text);
                                                  bloc.text = text;
                                                  bloc.setTopicDetailItem();
                                                }
                                                topicTextFieldController.text =
                                                    "";
                                              },
                                            ),
                                          );
                                        } else {
                                          return Stack(
                                            children: <Widget>[
                                              Align(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    bloc.openEditItem(index);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 32.0,
                                                    ),
                                                    child: Heading(item.text),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment(-1, -1),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    bloc.removeTopicDetailItem(
                                                        index);
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }
                                      if (item.type == Type.SubTopic) {
                                        if (item.isEdit) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                text: item.text,
                                              ),
                                              cursorColor: Colors.black,
                                              autofocus: true,
                                              maxLines: 1000,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.done,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: "",
                                              ),
                                              onSubmitted: (String text) {
                                                print(text);
                                                bloc.text = text;
                                                bloc.setTopicDetailItem();
                                              },
                                            ),
                                          );
                                        } else {
                                          return Stack(
                                            children: <Widget>[
                                              Align(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    bloc.openEditItem(index);
                                                  },
                                                  child:
                                                      SubtopicText(item.text),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment(-1, -1),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    bloc.removeTopicDetailItem(
                                                        index);
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }
                                      if (item.type == Type.KeyConcept) {
                                        if (item.isEdit) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: TextEditingController(
                                                text: item.text,
                                              ),
                                              cursorColor: Colors.black,
                                              autofocus: true,
                                              maxLines: 1000,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.done,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                              decoration:
                                                  InputDecoration.collapsed(
                                                hintText: "",
                                              ),
                                              onSubmitted: (String text) {
                                                print(text);
                                                bloc.text = text;
                                                bloc.setTopicDetailItem();
                                              },
                                            ),
                                          );
                                        } else {
                                          return Stack(
                                            children: <Widget>[
                                              Align(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    bloc.openEditItem(index);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 16.0,
                                                    ),
                                                    child: KeyPoint(item.text),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment(-1, -1),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    bloc.removeTopicDetailItem(
                                                        index);
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }
                                      if (item.type == Type.Image) {
                                        return Stack(
                                          children: <Widget>[
                                            Align(
                                              child: GestureDetector(
                                                onTap: () {
                                                  bloc.selectedType =
                                                      Type.Image;
                                                  bloc.imageUrl = item.mediaUrl;
                                                  bloc.text = item.text;
                                                  bloc.openEditItem(index);
                                                  openImageDialog(context);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 24.0,
                                                  ),
                                                  child: NImagewithCaption(
                                                    item.mediaUrl,
                                                    item.text,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment(-1, -1),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 16,
                                                ),
                                                onPressed: () {
                                                  bloc.removeTopicDetailItem(
                                                      index);
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    }).toList(),
                                  );
                                },
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                height: 100,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextField(
                                        controller: topicTextFieldController,
                                        cursorColor: Colors.black,
                                        autofocus: true,
                                        focusNode: focusNode,
                                        maxLines: 1000,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                        decoration: InputDecoration.collapsed(
                                          hintText: "",
                                        ),
                                        onSubmitted: (String text) {
                                          if (text.isNotEmpty) {
                                            print(text);
                                            bloc.text = text;
                                            topicTextFieldController.clear();
                                            bloc.addTopicDetailItem();
                                            FocusScope.of(context)
                                                .requestFocus(focusNode);
                                          }
                                        },
                                      ),
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
                  SizedBox(
                    height: 64,
                    child: Row(
                      children: <Widget>[
                        Tooltip(
                          message: "Set paragraph",
                          preferBelow: false,
                          child: InkWell(
                            child: Consumer<TopicDetailFormBloc>(
                              builder: (context, bloc, child) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "P",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          color: bloc.selectedType == Type.Text
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        width: bloc.selectedType == Type.Text
                                            ? 100
                                            : 0,
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          "Paragraph",
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            onTap: () {
                              bloc.setItemType(Type.Text);
                            },
                          ),
                        ),
                        Tooltip(
                          message: "Set Heading for text",
                          preferBelow: false,
                          child: Consumer<TopicDetailFormBloc>(
                            builder: (context, bloc, child) {
                              return Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.text_fields),
                                    color: bloc.selectedType == Type.Heading
                                        ? Colors.black
                                        : Colors.grey,
                                    onPressed: () {
                                      bloc.setItemType(Type.Heading);
                                    },
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: bloc.selectedType == Type.Heading
                                        ? 100
                                        : 0,
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      "Heading",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Tooltip(
                          message: "Add Sub Topic",
                          preferBelow: false,
                          child: Consumer<TopicDetailFormBloc>(
                            builder: (context, bloc, child) {
                              return Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.short_text),
                                    color: bloc.selectedType == Type.SubTopic
                                        ? Colors.black
                                        : Colors.grey,
                                    onPressed: () {
                                      bloc.setItemType(Type.SubTopic);
                                    },
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: bloc.selectedType == Type.SubTopic
                                        ? 100
                                        : 0,
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      "Sub Topic",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Tooltip(
                          message: "Add image",
                          preferBelow: false,
                          child: Consumer<TopicDetailFormBloc>(
                            builder: (context, bloc, child) {
                              return Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.image),
                                    color: bloc.selectedType == Type.Image
                                        ? Colors.black
                                        : Colors.grey,
                                    onPressed: () {
                                      bloc.setItemType(Type.Image);
                                      bloc.imageUrl = "";
                                      bloc.text = "";
                                      openImageDialog(context);
                                    },
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: bloc.selectedType == Type.Image
                                        ? 100
                                        : 0,
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      "Image",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Tooltip(
                          message: "Add key concept box",
                          preferBelow: false,
                          child: Consumer<TopicDetailFormBloc>(
                            builder: (context, bloc, child) {
                              return Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.lightbulb_outline),
                                    color: bloc.selectedType == Type.KeyConcept
                                        ? Colors.black
                                        : Colors.grey,
                                    onPressed: () {
                                      bloc.setItemType(Type.KeyConcept);
                                    },
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: bloc.selectedType == Type.KeyConcept
                                        ? 100
                                        : 0,
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      "Key Box",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 64,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 4, sigmaX: 6),
                  child: Material(
                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () async {
                            await bloc.publishArticle();
                            Navigator.of(context).pop();
                            if (!bloc.isEdit) Navigator.of(context).pop();
                          },
                          child: Text("Publish"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Consumer<TopicDetailFormBloc>(builder: (context, bloc, child) {
              return bloc.isLoading
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
                  : SizedBox();
            }),
          ],
        ),
      ),
    );
  }

  void openImageDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Image with caption"),
          content: Container(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: TextEditingController(text: bloc.imageUrl),
                        decoration: InputDecoration(
                          labelText: 'Image Url',
                          hintText: 'https://www.imageur.com/xbca1fa.jpeg',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffcaf2f3),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          bloc.imageUrl = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: TextEditingController(text: bloc.text),
                        decoration: InputDecoration(
                          labelText: 'Image Caption',
                          hintText: '1.2 etc....',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffcaf2f3),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          bloc.text = value;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                bloc.selectedType = Type.Text;
                bloc.text = "";
                bloc.imageUrl = "";
                bloc.notify();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(bloc.editIndex == -1 ? 'Post Image' : "Edit Image"),
              onPressed: () {
                if (bloc.validateImage()) {
                  if (bloc.editIndex == -1) {
                    bloc.addTopicDetailItem();
                  } else {
                    bloc.setTopicDetailItem();
                  }
                  bloc.selectedType = Type.Text;
                  bloc.text = "";
                  bloc.imageUrl = "";
                  bloc.notify();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
