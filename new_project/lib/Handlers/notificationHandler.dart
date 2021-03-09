import 'package:flutter/material.dart';
import 'package:new_project/Entities/userList.dart';
import 'package:new_project/Handlers/auctionHandler.dart';
import 'package:new_project/Handlers/userInfoHandler.dart';

class NotificationsHandler {
  final UserInfoHandler _userInfoHandler;
  final myController = TextEditingController();
  List<Inbox> inbox;

  NotificationsHandler(this._userInfoHandler);

  Container getListTile(Inbox item) {
    if (item.offerId == null && item.status == "Pending") {
      // Accept/Decline someone to join your auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text("User " + item.userId.toString() + " have requested to join your auction " + item.auctionId.toString()),
                ElevatedButton(
                  child: Text("Approve"),
                  onPressed: () {
                    for (int i = 0; i < _userInfoHandler.userListObject.users.length; i++) {
                      if (_userInfoHandler.userListObject.users[i].userId == item.userId) {
                        _userInfoHandler.userListObject.users[i].requestInbox.add(new Inbox(
                          time: new DateTime.now(),
                          status: "Accepted",
                          auctionId: item.auctionId,
                          userId: _userInfoHandler.user.userId,
                          offerId: null,
                        ));
                        _userInfoHandler.userListObject.users[i].participatingAuctions.add(new ParticipatingAuction(
                          auctionId: item.auctionId,
                        ));
                        _userInfoHandler.user.requestInbox.remove(item);
                      }
                    }
                  },
                ),
                ElevatedButton(
                  child: Text("Decline"),
                  onPressed: () {
                    for (int i = 0; i < _userInfoHandler.userListObject.users.length; i++) {
                      if (_userInfoHandler.userListObject.users[i].userId == item.userId) {
                        _userInfoHandler.userListObject.users[i].requestInbox.add(new Inbox(
                          time: new DateTime.now(),
                          status: "Declined",
                          auctionId: item.auctionId,
                          userId: _userInfoHandler.user.userId,
                          offerId: null,
                        ));
                        _userInfoHandler.user.requestInbox.remove(item);
                      }
                    }
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId == null && item.status == "Declined") {
      // Remove notis when "Declined" to join auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text("You have been declined to join auction " + item.auctionId.toString() + " created by user " + item.userId.toString()),
                ElevatedButton(
                  child: Text("Dissmiss"),
                  onPressed: () {
                    _userInfoHandler.user.requestInbox.remove(item);
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId == null && item.status == "Accepted") {
      // Remove notis when "Accepted" to join auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text("You have been accepted to join auction " + item.auctionId.toString() + " created by user " + item.userId.toString()),
                ElevatedButton(
                  child: Text("Dissmiss"),
                  onPressed: () {
                    _userInfoHandler.user.requestInbox.remove(item);
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId != null && item.status == "Pending") {
      // Accept/Decline invite to join someones auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text("You have been invited to auction " +
                    item.auctionId.toString() +
                    " created by user " +
                    item.userId.toString() +
                    " via offer " +
                    item.offerId.toString()),
                ElevatedButton(
                  child: Text("Join auction"),
                  onPressed: () {
                    for (int i = 0; i < _userInfoHandler.userListObject.users.length; i++) {
                      if (_userInfoHandler.userListObject.users[i].userId == item.userId) {
                        _userInfoHandler.userListObject.users[i].inviteInbox.add(new Inbox(
                          time: new DateTime.now(),
                          status: "Accepted",
                          auctionId: item.auctionId,
                          userId: _userInfoHandler.user.userId,
                          offerId: null, // TODO: icrement offerId
                        ));
                        _userInfoHandler.user.participatingAuctions.add(new ParticipatingAuction(
                          auctionId: item.auctionId,
                        ));
                        _userInfoHandler.user.inviteInbox.remove(item);
                      }
                    }
                  },
                ),
                ElevatedButton(
                  child: Text("Decline offer"),
                  onPressed: () {
                    for (int i = 0; i < _userInfoHandler.userListObject.users.length; i++) {
                      if (_userInfoHandler.userListObject.users[i].userId == item.userId) {
                        _userInfoHandler.userListObject.users[i].inviteInbox.add(new Inbox(
                          time: new DateTime.now(),
                          status: "Declined",
                          auctionId: item.auctionId,
                          userId: _userInfoHandler.user.userId,
                          offerId: null, // TODO: icrement offerId
                        ));
                        _userInfoHandler.user.inviteInbox.remove(item);
                      }
                    }
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId != null && item.status == "Declined") {
      // Remove notis when invited user "Declined" to join your auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text("User " + item.userId.toString() + " have declined to join your auction " + item.auctionId.toString()),
                ElevatedButton(
                  child: Text("Dissmiss"),
                  onPressed: () {
                    _userInfoHandler.user.inviteInbox.remove(item);
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    } else if (item.offerId != null && item.status == "Accepted") {
      // Remove notis when invited user "Accepted" to join auction
      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                Text("User " +
                    item.userId.toString() +
                    " have accepted to join your auction " +
                    item.auctionId.toString() +
                    " via offer " +
                    item.offerId.toString()),
                ElevatedButton(
                  child: Text("Dissmiss"),
                  onPressed: () {
                    _userInfoHandler.user.inviteInbox.remove(item);
                  },
                ),
              ],
            ),
            Container(
              height: 8,
            ),
          ],
        ),
      );
    }
    return Container(
      child: Text("Something went wrong when checking inbox. Maybe Pending, Declined or Accepted is spelled incorrectly?"),
    );
  }

  void showNotifications(BuildContext context) {
    inbox = new List.from(_userInfoHandler.user.requestInbox)..addAll(_userInfoHandler.user.inviteInbox);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ThemeData themeData = Theme.of(context);

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            color: themeData.primaryColor,
            width: MediaQuery.of(context).size.width * 0.2,
            margin: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 6.0,
                  ),
                  margin: EdgeInsets.only(top: 13.0, right: 8.0),
                  decoration: BoxDecoration(
                    color: themeData.primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          /*
                          ====================
                          Notifications are listed below
                          ====================
                          */
                          child: Column(
                            children: [
                              Text('Notifications', style: themeData.textTheme.headline4),
                              Container(height: 16),
                              Container(
                                width: 400,
                                height: 200,
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Scrollbar(
                                      child: ListView.builder(
                                        itemCount: inbox.length,
                                        itemBuilder: (context, index) {
                                          return getListTile(inbox[index]);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                ====================
                Exitbutton
                ====================
                */
                Positioned(
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      myController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14.0,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
