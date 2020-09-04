import 'package:flutter/material.dart';

class FeaturesScreen extends StatefulWidget {
  static String navtag = "features";
  @override
  _FeaturesScreenState createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: true,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Color(0xffeff9fa),
              // stretch: true,
              pinned: true,
              floating: true,
              snap: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(15),
                background: Hero(
                  tag: "features",
                  child: Image.asset(
                    "assets/images/featuresbanner.png",
                    alignment: Alignment.bottomRight,
                  ),
                ),
                title: Text(
                  "Features",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              expandedHeight: 180,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome to E-learning app. Throught this app you can learn many of the high college subject with carefully written notes plus there are bunch of different features packed inside the app for testing your current knowledge on hundreds of subject.",
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
