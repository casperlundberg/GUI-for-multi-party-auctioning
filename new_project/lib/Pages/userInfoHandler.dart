import 'dart:convert';

import 'package:crypt/crypt.dart';
import '../Entities/userList.dart';
import '../Entities/user.dart';
import 'package:crypto/crypto.dart';

class UserInfoHandler {
  final UserList userListObject;
  final User user;

  UserInfoHandler(this.userListObject, this.user);

  // Check if a String is a valid email.
  // Return true if it is valid.
  bool isEmail(String email) {
    // Null or empty string is invalid
    if (email == null || email.isEmpty) {
      print("Please enter a valid e-mail");
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      print("Please enter a valid e-mail");
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

  bool phoneCheck(String mobilePhoneNumber) {
    // check if email or username is taken, uses userList from json
    bool usermobilePhoneNumberOK = false;
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i] != user) {
        if (userListObject.users[i].mobilePhoneNumber == mobilePhoneNumber) {
          print("Mobile phonenumber is already taken");
          break;
        } else {
          usermobilePhoneNumberOK = true;
        }
      }
    }
    if (usermobilePhoneNumberOK) {
      return true;
    }
    return false;
  }

  bool profileEditCheck(String userName, String email, String mobilePhoneNumber) {
    if (userCheck(userName, email)) {
      if (isEmail(email)) {
        if (phoneCheck(mobilePhoneNumber)) {
          return true;
        }
      }
    }
    return false;
  }

  bool passwordValidator(String hash) {
    // Null or empty string is invalid
    print("Password: " + hash);

    if (hash == null || hash.isEmpty) {
      return false;
    }

    if (hash == user.password.encryption) {
      return true;
    }
    return false;
  }

  User loginValidator(String userName, String hash) {
    // Null or empty string is invalid
    print("Password: " + hash);

    if (hash == null || hash.isEmpty || userName == null || userName.isEmpty) {
      print("Please fill in your credentials");
      return null;
    }

    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].userName == userName && userListObject.users[i].password.encryption == hash) {
        return userListObject.users[i];
      }
    }
    print("Invalid credentials");
    return null;
  }
}
