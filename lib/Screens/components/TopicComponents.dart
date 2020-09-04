import 'package:flutter/material.dart';
import 'package:iostudy/preferences.dart';

class TitleText extends StatelessWidget {
  final String _content;
  TitleText(this._content);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        _content,
        style: TextStyle(fontSize: 36, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class SubtopicText extends StatelessWidget {
  final String _content;
  SubtopicText(this._content);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Chip(
      label: Text(
        _content,
        style: TextStyle(color: Color(0xff715F5E)),
      ),
      backgroundColor: Color(0xffF7D1CD),
    ));
  }
}

class Heading extends StatelessWidget {
  final String _content;
  Heading(this._content);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 6,
        bottom: 6,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          _content,
          style: TextStyle(
              color: Colors.blue, fontSize: 24 * Preferences.textScaleFactor),
        ),
      ),
    );
  }
}

class OnlyText extends StatelessWidget {
  final String _content;
  OnlyText(this._content);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Text(
        "        $_content",
        style: TextStyle(
            color: Colors.black54, fontSize: 14 * Preferences.textScaleFactor),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class NImagewithCaption extends StatefulWidget {
  final String url;
  final String caption;
  NImagewithCaption(this.url, this.caption);

  @override
  _NImagewithCaptionState createState() => _NImagewithCaptionState();
}

class _NImagewithCaptionState extends State<NImagewithCaption> {
  double _height = 250;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xfff5f8fa),
        borderRadius: BorderRadius.circular(20),
      ),
      height: _height,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isExpanded) {
                      _isExpanded = false;
                      _height = 250;
                    } else {
                      _isExpanded = true;
                      _height = MediaQuery.of(context).size.width;
                    }
                  });
                },
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.url,
                    alignment: Alignment(0, 1),
                    loadingBuilder: (context, widget, loading) {
                      if (loading == null) return widget;

                      return Center(
                          child: Image.asset("assets/images/load.gif"));
                    },
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "fig: ${widget.caption}",
                  style: TextStyle(color: Colors.grey),
                ),
              ))
        ],
      ),
    );
  }
}

class AddSpace extends StatelessWidget {
  final double multiplier;
  AddSpace(this.multiplier);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20 * multiplier,
    );
  }
}

class KeyPoint extends StatelessWidget {
  final String _content;
  KeyPoint(this._content);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffEAC4D5),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xffDB5375),
                  child: Icon(Icons.school),
                ),
              ),
              Text(
                "Key Concept",
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "$_content",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14 * Preferences.textScaleFactor,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
