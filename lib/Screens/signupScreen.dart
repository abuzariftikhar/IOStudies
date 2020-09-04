import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iostudy/Screens/homeScreen.dart';
import 'package:iostudy/Screens/loginScreen.dart';
import 'package:iostudy/Screens/profileScreen.dart';
import 'package:iostudy/bloc/SingupBloc.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static String navtag = "signup";
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupBloc bloc;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<SignupBloc>(context);
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
                            Consumer<SignupBloc>(
                              builder: (context, bloc, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  clipBehavior: Clip.hardEdge,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      // color: Color(0xffcaf2f3),
                                    ),
                                    child: Image.asset(
                                      "assets/images/logo.png",
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                );
                              },
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
                          child: Consumer<SignupBloc>(
                            builder: (context, bloc, child) {
                              return TextField(
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: "Muhammad Saeed",
                                    labelText: "Full name",
                                    errorText: bloc.errName,
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
                          child: Consumer<SignupBloc>(
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
                          child: Consumer<SignupBloc>(
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
                          child: Consumer<SignupBloc>(
                            builder: (context, bloc, child) {
                              return TextField(
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                controller: confirmPasswordController,
                                decoration: InputDecoration(
                                    hintText: "Must be atleast 6 character",
                                    labelText: "Confirm Password",
                                    errorText: bloc.errConfirmPassword,
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
                                child: Text("Sign Up"),
                                onPressed: () async {
                                  bloc.name = nameController.text;
                                  bloc.password = passwordController.text;
                                  bloc.email = emailController.text;
                                  bloc.confirmPassword =
                                      confirmPasswordController.text;
                                  bool isSuccess = await bloc.signUp();
                                  if (isSuccess) {
                                    Navigator.popAndPushNamed(
                                      context,
                                      ProfileScreen.navtag,
                                    );
                                  } else {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Something Went Wrong!"),
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
                                child: Text(
                                    "You\'ve been there earlier? Sign in instead")),
                            OutlineButton(
                              child: Text("Sign in"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, LoginScreen.navtag);
                              },
                            ),
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
          )),
    );
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      bloc.setImageFile(image);
    });
  }
}
