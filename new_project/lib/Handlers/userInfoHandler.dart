import 'dart:convert';

import 'package:new_project/Handlers/notificationHandler.dart';

import '../Entities/userList.dart';
import 'package:crypto/crypto.dart';
import '../jsonUtilities.dart';

class UserInfoHandler {
  final Function userToAuction;
  UserList userListObject;
  User user;

  UserInfoHandler(this.userToAuction, this.userListObject, this.user);

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
      print("Please enter a valid username");
      return false;
    }
    // check if email or username is taken, uses userList from json
    bool emailOK = false;
    bool userNameOK = false;
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].userId != user.userId) {
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
    if (hash == null || hash.isEmpty || hashRepeat == null || hashRepeat.isEmpty) {
      print("Please enter valid passwords");
      return false;
    }

    print("Password: " + hash);
    print("Repeated password: " + hashRepeat);

    if (hash == hashRepeat) {
      return true;
    }
    print("Password and repat password missmatch");
    return false;
  }

  bool phoneCheck(String mobilePhoneNumber) {
    // Null or empty string is invalid
    /* if (mobilePhoneNumber == null || mobilePhoneNumber.isEmpty) {
      print("Please enter a valid mobile phonenumber");
      return false;
    } */
    bool usermobilePhoneNumberOK = false;
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].userId != user.userId) {
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
      print("Password field empty");
      return false;
    }

    if (hash == user.password.encryption) {
      return true;
    }
    print("Invalid password");
    return false;
  }

  User loginValidator(String userName, String hash) {
    if (userName == null || hash == null || userName.isEmpty || hash.isEmpty) {
      print("Please fill all credentials");
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

  void login(User user) {
    this.user.address = user.address;
    this.user.age = user.age;
    this.user.company = user.company;
    this.user.currentType = user.currentType;
    this.user.email = user.email;
    this.user.homePhoneNumber = user.homePhoneNumber;
    this.user.mobilePhoneNumber = user.mobilePhoneNumber;
    this.user.officePhoneNumber = user.officePhoneNumber;
    this.user.participatingAuctions = user.participatingAuctions;
    this.user.password = user.password;
    this.user.userId = user.userId;
    this.user.userName = user.userName;
    this.user.inviteInbox = user.inviteInbox;
    this.user.requestInbox = user.requestInbox;
    this.user.offers = user.offers;
    userToAuction();
  }

  void register(String userName, String email, String pw) {
    this.user.userId = userListObject.users.length + 1;
    this.user.userName = userName;
    this.user.email = email;
    this.user.password = new Password(encryption: pw, type: "sha256");
    this.user.address = new Address();
    this.user.currentType = "Consumer";
    this.user.participatingAuctions = [];
    userListObject.users.add(user);
    setUserListString(userListToJson(userListObject));
    userToAuction();
  }

  void updateProfile() {
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].userId == user.userId) {
        userListObject.users[i] = user;
      }
    }
    setUserListString(userListToJson(userListObject));
    userToAuction();
  }

  List<Inbox> getInbox() {
    print(this.user.requestInbox.toString());
    print(this.user.offers.toString());
    print(this.user.toJson());
    List<Inbox> list = this.user.requestInbox;
    list.addAll(this.user.inviteInbox);
    return list;
  }
}
