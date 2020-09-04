import 'package:flutter/material.dart';
import 'package:iostudy/Screens/homeScreen.dart';
import 'package:iostudy/Screens/profileScreen.dart';
import 'package:iostudy/Screens/signupScreen.dart';
import 'package:iostudy/bloc/LoginBloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String navtag = "signin";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController passwordController;
  TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<LoginBloc>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(
                        height: 100,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black, width: 1),
                              // color: Color(0xffcaf2f3),
                            ),
                            child: Image.asset(
                              "assets/images/logo.png",
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          Text(
                            "Hello there!",
                            style: TextStyle(fontSize: 36),
                          ),
                          Text("lets get setup & make the world better")
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Consumer<LoginBloc>(
                          builder: (context, bloc, child) {
                            return TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: "example@domain.com",
                                  labelText: "Email",
                                  errorText: bloc.errEmail,
                                  fillColor: Color(0xffcaf2f3),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xffcaf2f3)))),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Consumer<LoginBloc>(
                          builder: (context, bloc, child) {
                            return TextField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: "Must be atleast 6 character",
                                  labelText: "Password",
                                  errorText: bloc.errPassword,
                                  fillColor: Color(0xffcaf2f3),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(0xffcaf2f3)))),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            OutlineButton(
                              child: Text("Sign in"),
                              onPressed: () async {
                                bloc.password = passwordController.text;
                                bloc.email = emailController.text;
                                bool isSuccess = await bloc.signUp();
                                if (isSuccess) {
                                  Navigator.popAndPushNamed(
                                    context,
                                    ProfileScreen.navtag,
                                  );
                                } else {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("Incorrect password or email!"),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child:
                                  Text("New here? Let get signed up instead")),
                          OutlineButton(
                              child: Text("Sign up"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SignupScreen.navtag);
                              })
                        ],
                      )
                    ]),
                  )
                ],
              ),
            ),
            bloc.isLoading
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
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
