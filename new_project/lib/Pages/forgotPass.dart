import 'package:flutter/material.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import '../mainGUI.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:async';
import 'package:mailer/mailer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final Function navigate;
  ForgotPasswordScreen(this.navigate);
  @override
  ForgotPasswordState createState() => ForgotPasswordState(navigate);
}

class ForgotPasswordState extends State<ForgotPasswordScreen> {
  final Function navigate;
  ForgotPasswordState(this.navigate);

  TextEditingController _recipientController = new TextEditingController();

  Future<void> sendMail() async {
    String username = 'cappe5@hotmail.se';
    String password = 'VOVVE1a2s3d';

    final smtpServer = hotmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(_recipientController.text)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Forgot password? :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE

    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.

    /* final equivalentMessage = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(Address('destination@example.com'))
      ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
      ..bccRecipients.add('bccAddress@example.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    final sendReport2 = await send(equivalentMessage, smtpServer);

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    await connection.send(equivalentMessage);

    // close the connection
    await connection.close(); */
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 500,
          child: Card(
            color: themeData.primaryColor,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Forgot Password', style: Theme.of(context).textTheme.headline4),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Email'),
                      controller: _recipientController,
                    ),
                  ),
                  TextButton(
                    child: Text('Reset Password'),
                    onPressed: () {
                      sendMail();
                      //Should go to a waiting for confiramtion screen or just sit here with a message saying the same
                      //this.parent.selectedWidgetMarker = WidgetMarker.register;
                    },
                  ),
                  TextButton(
                    child: Text('Back to login page'),
                    onPressed: () {
                      navigate(WidgetMarker.login);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['to@example.com'],
      cc: ['cc1@example.com', 'cc2@example.com'],
      subject: 'mailto example subject',
      body: 'mailto example body',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }
}
