import 'package:flutter/material.dart';
import '../models/linker.dart';

class SubjectTile extends StatefulWidget {
  final int id;
  final String title;
  final int color;
  SubjectTile(this.id, this.title, this.color);
  @override
  _SubjectTileState createState() => _SubjectTileState();
}

class _SubjectTileState extends State<SubjectTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Linker.color = widget.color;
        Linker.title = widget.title;
        Linker.id = widget.id;
        Navigator.pushNamed(context, Linker.navtag);
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Color(widget.color)),
              width: 100,
              height: 100,
            ),
            Text(widget.title)
          ],
        ),
      ),
    );
  }
}
