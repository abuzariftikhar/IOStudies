import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:iostudy/bloc/ApplicationBloc.dart';
import 'package:iostudy/common/AuthStore.dart';
import 'package:path/path.dart' as Path;

class SignupBloc extends ChangeNotifier {
  String email = "";
  String errEmail;
  String name = "";
  String errName;
  String password = "";
  String errPassword;
  String confirmPassword = "";
  String errConfirmPassword;

  String imageUrl;
  File imageFile;

  bool isLoading = false;

  bool _validate() {
    if (name.length < 3) {
      errName = "Name should be greater than 2 characters";
      return false;
    } else {
      errName = null;
    }
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
    if (password != confirmPassword) {
      errConfirmPassword = "Confirm password not matched";
      return false;
    } else {
      errConfirmPassword = null;
    }

    return true;
  }

  Future<bool> signUp() async {
    isLoading = true;
    notifyListeners();

    if (_validate()) {
      AuthResult authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = authResult.user;

      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = name;

      if (imageFile != null) {
        await uploadFile();
      }

      updateInfo.photoUrl = imageUrl;

      try {
        await user.updateProfile(updateInfo);
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

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('user/${Path.basename(imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    imageUrl = await storageReference.getDownloadURL();
  }

  void setImageFile(File file) {
    imageFile = file;
    notifyListeners();
  }
}
