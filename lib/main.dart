import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iostudy/Screens/SplashScreen.dart';
import 'package:iostudy/Screens/loginScreen.dart';
import 'package:iostudy/Screens/profileScreen.dart';
import 'package:iostudy/Screens/signupScreen.dart';
import 'package:iostudy/Screens/topicDetailFormScreen.dart';
import 'package:iostudy/Screens/topicDetailScreen.dart';
import 'package:iostudy/Screens/topicFormSelectionScreen.dart';
import 'package:iostudy/Screens/topicListScreen.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/bloc/HomeBloc.dart';
import 'package:iostudy/bloc/LoginBloc.dart';
import 'package:iostudy/bloc/ProfileBloc.dart';
import 'package:iostudy/bloc/SingupBloc.dart';
import 'package:iostudy/bloc/SubjectListBloc.dart';
import 'package:iostudy/bloc/TopicDetailBloc.dart';
import 'package:iostudy/bloc/TopicDetailFormBloc.dart';
import 'package:iostudy/bloc/TopicFormSelectionBloc.dart';
import 'package:iostudy/bloc/TopicListBloc.dart';
import 'package:iostudy/common/AuthStore.dart';
import 'package:provider/provider.dart';
import './Screens/homeScreen.dart';
import 'package:flutter/services.dart';
import './Screens/featuresScreen.dart';
import './Screens/subjectScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthStore authStore = await AuthStore.getInstance();
  applicationBlocInstance.authStore = authStore;
  applicationBlocInstance.firebaseUser = await authStore.getUser();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      theme: ThemeData(accentColor: Colors.black, fontFamily: 'googlesans'),
      initialRoute: SplashScreen.navtag,
      routes: {
        SplashScreen.navtag: (context) => SplashScreen(),
        HomeScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => HomeBloc(),
              child: HomeScreen(),
            ),
        LoginScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => LoginBloc(),
              child: LoginScreen(),
            ),
        SignupScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => SignupBloc(),
              child: SignupScreen(),
            ),
        ProfileScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => ProfileBloc(),
              child: ProfileScreen(),
            ),
        FeaturesScreen.navtag: (context) => FeaturesScreen(),
        SubjectScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => SubjectListBloc(),
              child: SubjectScreen(),
            ),
        TopicListScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => TopicListBloc(),
              child: TopicListScreen(),
            ),
        TopicDetailScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => TopicDetailBloc(),
              child: TopicDetailScreen(),
            ),
        TopicFormSelectionScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => TopicFormSelectionBloc(),
              child: TopicFormSelectionScreen(),
            ),
        TopicDetailFormScreen.navtag: (context) => ChangeNotifierProvider(
              create: (_) => TopicDetailFormBloc(),
              child: TopicDetailFormScreen(),
            ),
      },
      debugShowCheckedModeBanner: false,
      title: 'Prodigy Study',
    ));
  });
}

// TopicDetailScreen.navtag: (context) => ChangeNotifierProvider(
//       create: (_) => TopicDetailBloc(),
//       child: TopicDetailScreen(),
//     ),
