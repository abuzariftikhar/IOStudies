import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:iostudy/common/AuthStore.dart';

class ApplicationBloc extends ChangeNotifier {
  AuthStore authStore;
  FirebaseUser firebaseUser;

  Future setLogin(bool login) async {
    await authStore.setLogin(login);
    if (login) {
      firebaseUser = await FirebaseAuth.instance.currentUser();
    } else {
      firebaseUser = null;
      FirebaseAuth.instance.signOut();
    }
  }
}

ApplicationBloc applicationBlocInstance = ApplicationBloc();
