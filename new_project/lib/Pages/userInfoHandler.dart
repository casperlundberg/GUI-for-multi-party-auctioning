import 'dart:convert';

import 'package:crypt/crypt.dart';
import '../Entities/userList.dart';
import 'package:crypto/crypto.dart';

class UserInfoHandler {
  final UserList userListObject;

  UserInfoHandler(this.userListObject);

  // Check if a String is a valid email.
  // Return true if it is valid.
  bool isEmail(String email) {
    // Null or empty string is invalid
    if (email == null || email.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  bool userCheck(String userName, String email) {
    // Null or empty string is invalid
    if (userName == null || userName.isEmpty) {
      return false;
    }
    // check if email or username is taken, uses userList from json
    bool emailOK = false;
    bool userNameOK = false;
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].email == email) {
        //email already taken pop-up

        print("Email is already taken");
        break;
      } else {
        emailOK = true;
      }

      if (userListObject.users[i].userName == userName) {
        //username already taken pop-up
        print("Username is already taken");
        break;
      } else {
        userNameOK = true;
      }
    }
    if (emailOK && userNameOK) {
      return true;
    }
    return false;
  }

  String passHasher(String password) {
    String salt = 'lVocjgjgXg8P7zIsC93kKleU8sPbTBhsAMFLnLUPDRYFIWAk';
    String saltedPassword = salt + password;
    var bytes = utf8.encode(saltedPassword);
    var hash = sha256.convert(bytes);
    return hash.toString();
  }

  bool passwordChecker(String hash, String hashRepeat) {
    // Null or empty string is invalid
    print("Password: " + hash);
    print("Repeated password: " + hashRepeat);

    if (hash == null || hash.isEmpty || hashRepeat == null || hashRepeat.isEmpty) {
      return false;
    }

    if (hash == hashRepeat) {
      return true;
    }
    return false;
  }
}
