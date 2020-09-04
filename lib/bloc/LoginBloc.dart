import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/common/AuthStore.dart';

class LoginBloc extends ChangeNotifier {
  String email = "";
  String errEmail;
  String password = "";
  String errPassword;

  bool isLoading = false;

  bool _validate() {
    if (!email.contains("@")) {
      errEmail = "Email is invalid";
      return false;
    } else {
      errEmail = null;
    }
    if (password.length < 6) {
      errPassword = "Password should be 6 or more characters";
      return false;
    } else {
      errPassword = null;
    }

    return true;
  }

  Future<bool> signUp() async {
    isLoading = true;
    notifyListeners();

    if (_validate()) {
      try {
        AuthResult authResult = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        FirebaseUser user = authResult.user;

        print("Login!! ${user.toString()}");

        isLoading = false;
        notifyListeners();

        await applicationBlocInstance.setLogin(true);

        print("User Object Updated");
        return true;
      } catch (e) {
        isLoading = false;
        notifyListeners();
        print(e.toString());
        print("User Object not Updated");
        return false;
      }
    } else {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
