import 'dart:convert';

import '../Entities/userListJSON.dart';
import 'package:crypto/crypto.dart';
import '../jsonUtilities.dart';

class UserInfoHandler {
  final Function updateUser;
  UserList userListObject; //NOT STORED LOCALLY
  User user; //STORED LOCALLY

  UserInfoHandler(this.updateUser) {
    userListObject = userListFromJson(getUsers());
    user = new User();
  }

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
    this.user.offers = user.offers;
    this.user.requestInbox = user.requestInbox;
    this.user.inviteInbox = user.inviteInbox;
    updateUser();
  }

  void register(String userName, String email, String pw) {
    this.user.userId = userListObject.users.length + 1;
    this.user.userName = userName;
    this.user.email = email;
    this.user.password = new Password(encryption: pw, type: "sha256");
    this.user.address = new Address();
    this.user.currentType = "Consumer";
    this.user.participatingAuctions = [];
    this.user.offers = [];
    this.user.requestInbox = [];
    this.user.inviteInbox = [];
    userListObject.users.add(user);
    setUsers(userListToJson(userListObject));
    updateUser();
  }

  void updateProfile() {
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].userId == user.userId) {
        userListObject.users[i] = user;
      }
    }
    setUsers(userListToJson(userListObject));
    updateUser();
  }

  void requestToJoin(int auctionID, int userID) {
    DateTime now = DateTime.now();
    //Put "sent" notification in users inbox.
    user.requestInbox.add(Inbox(
      time: now,
      status: "Sent",
      auctionId: auctionID,
      userId: userID,
      offerId: null,
    ));
    //Update "database".
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].userId == userID) {
        //Put "pending" request in userIDs inbox.
        userListObject.users[i].requestInbox.add(Inbox(
          time: now,
          status: "Pending",
          auctionId: auctionID,
          userId: user.userId,
          offerId: null,
        ));
      }
      if (userListObject.users[i].userId == user.userId) {
        userListObject.users[i].requestInbox.add(Inbox(
          time: now,
          status: "Sent",
          auctionId: auctionID,
          userId: userID,
          offerId: null,
        ));
      }
    }
    setUsers(userListToJson(userListObject));
    updateUser();
  }

  void inviteToAuction(int auctionID, int offerID, int userID) {
    DateTime now = DateTime.now();
    //Put "sent" notification in users inbox.
    user.inviteInbox.add(Inbox(
      time: now,
      status: "Sent",
      auctionId: auctionID,
      userId: userID,
      offerId: offerID,
    ));
    //Update "database".
    for (int i = 0; i < userListObject.users.length; i++) {
      if (userListObject.users[i].userId == userID) {
        //Put "pending" invite in userIDs inbox.
        userListObject.users[i].inviteInbox.add(Inbox(
          time: now,
          status: "Pending",
          auctionId: auctionID,
          userId: user.userId,
          offerId: offerID,
        ));
      }
      if (userListObject.users[i].userId == user.userId) {
        userListObject.users[i].inviteInbox.add(Inbox(
          time: now,
          status: "Sent",
          auctionId: auctionID,
          userId: userID,
          offerId: offerID,
        ));
      }
    }
    setUsers(userListToJson(userListObject));
    updateUser();
  }
}
