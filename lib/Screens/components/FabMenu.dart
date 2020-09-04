import 'package:flutter/material.dart';
import 'package:iostudy/Screens/homeScreen.dart';
import 'package:iostudy/Screens/loginScreen.dart';
import 'package:iostudy/Screens/profileScreen.dart';
import 'package:iostudy/Screens/topicFormSelectionScreen.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';

class FabMenu extends StatefulWidget {
  @override
  _FabMenuState createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
  AnimationController _fabIconController;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _fabIconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _fabIconController.reverse();
              isMenuOpen = false;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: isMenuOpen ? double.maxFinite : 0,
            color: isMenuOpen ? Color(0xedffffff) : Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                applicationBlocInstance.authStore?.isLoggedIn() == true
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 55,
                          right: 80,
                        ),
                        child: Text(
                          "Create New Topic",
                          textAlign: TextAlign.end,
                          style: isMenuOpen
                              ? Theme.of(context).textTheme.title.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )
                              : Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(color: Colors.transparent),
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 60,
                    right: 80,
                  ),
                  child: Text(
                    applicationBlocInstance.authStore?.isLoggedIn() == true
                        ? "Profile"
                        : "Sign in",
                    textAlign: TextAlign.end,
                    style: isMenuOpen
                        ? Theme.of(context).textTheme.title.copyWith(
                              fontWeight: FontWeight.bold,
                            )
                        : Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(color: Colors.transparent),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 120,
                    right: 80,
                  ),
                  child: Text(
                    "Home",
                    textAlign: TextAlign.end,
                    style: isMenuOpen
                        ? Theme.of(context).textTheme.title.copyWith(
                              fontWeight: FontWeight.bold,
                            )
                        : Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(color: Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          alignment: Alignment(1, 1),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: isMenuOpen
              ? EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 110,
                )
              : EdgeInsets.all(20),
          child: Material(
            shape: CircleBorder(),
            color: Colors.black,
            elevation: 4,
            child: IconButton(
              onPressed: () {
                isMenuOpen = false;
                _fabIconController.reset();
                Navigator.of(context).pushNamed(
                  HomeScreen.navtag,
                );
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // AnimatedContainer(
        //   alignment: Alignment(1, 1),
        //   duration: Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        //   padding: isMenuOpen
        //       ? EdgeInsets.symmetric(
        //           horizontal: 20,
        //           vertical: 90,
        //         )
        //       : EdgeInsets.all(20),
        //   child: Text(
        //     "Home",
        //     style: isMenuOpen
        //         ? Theme.of(context).textTheme.body1
        //         : Theme.of(context)
        //             .textTheme
        //             .body1
        //             .copyWith(color: Colors.transparent),
        //   ),
        // ),
        AnimatedContainer(
          alignment: Alignment(1, 1),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: isMenuOpen
              ? EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 192,
                )
              : EdgeInsets.all(20),
          child: Material(
            shape: CircleBorder(),
            color: Colors.black,
            elevation: 4,
            child: IconButton(
              onPressed: () {
                if (applicationBlocInstance.authStore?.isLoggedIn() == true) {
                  isMenuOpen = false;
                  _fabIconController.reset();
                  Navigator.of(context).pushNamed(
                    ProfileScreen.navtag,
                  );
                } else {
                  isMenuOpen = false;
                  _fabIconController.reset();
                  Navigator.of(context).pushNamed(
                    LoginScreen.navtag,
                  );
                }
              },
              icon: Icon(
                applicationBlocInstance.authStore?.isLoggedIn() == true
                    ? Icons.person
                    : Icons.person_add,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // AnimatedContainer(
        //   alignment: Alignment(1, 1),
        //   duration: Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        //   padding: isMenuOpen
        //       ? EdgeInsets.symmetric(
        //           horizontal: 20,
        //           vertical: 170,
        //         )
        //       : EdgeInsets.all(20),
        //   child: Text(
        //     applicationBlocInstance.authStore.isLoggedIn()
        //         ? "Profile"
        //         : "Sign in",
        //     style: isMenuOpen
        //         ? Theme.of(context).textTheme.body1
        //         : Theme.of(context)
        //             .textTheme
        //             .body1
        //             .copyWith(color: Colors.transparent),
        //   ),
        // ),
        applicationBlocInstance.authStore?.isLoggedIn() == true
            ? AnimatedContainer(
                alignment: Alignment(1, 1),
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: isMenuOpen
                    ? EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 274,
                      )
                    : EdgeInsets.all(20),
                child: Material(
                  shape: CircleBorder(),
                  color: Colors.black,
                  elevation: 4,
                  child: IconButton(
                    onPressed: () {
                      isMenuOpen = false;
                      _fabIconController.reset();
                      Navigator.of(context).pushNamed(
                        TopicFormSelectionScreen.navtag,
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SizedBox(),
        // applicationBlocInstance.authStore.isLoggedIn()
        //     ? AnimatedContainer(
        //         alignment: Alignment(1, 1),
        //         duration: Duration(milliseconds: 300),
        //         curve: Curves.easeInOut,
        //         padding: isMenuOpen
        //             ? EdgeInsets.symmetric(
        //                 horizontal: 20,
        //                 vertical: 252,
        //               )
        //             : EdgeInsets.all(20),
        //         child: Text(
        //           "Add Topic",
        //           textAlign: TextAlign.center,
        //           style: isMenuOpen
        //               ? Theme.of(context).textTheme.body1
        //               : Theme.of(context)
        //                   .textTheme
        //                   .body1
        //                   .copyWith(color: Colors.transparent),
        //         ),
        //       )
        //     : SizedBox(),
        Align(
          alignment: Alignment(1, 1),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RawMaterialButton(
              shape: CircleBorder(),
              fillColor: isMenuOpen ? Colors.redAccent : Color(0xffe6b440),
              padding: EdgeInsets.all(16),
              onPressed: () {
                setState(() {
                  if (isMenuOpen) {
                    isMenuOpen = false;
                    _fabIconController.reverse();
                  } else {
                    isMenuOpen = true;
                    _fabIconController.forward();
                  }
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                color: Colors.white,
                progress: _fabIconController,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
