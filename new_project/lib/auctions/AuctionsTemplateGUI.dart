import 'package:flutter/material.dart';

class AuctionTemplateGUI extends StatefulWidget {
  @override
  _AuctionTemplateState createState() => _AuctionTemplateState();
}

class _AuctionTemplateState extends State<AuctionTemplateGUI> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(1.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: '<amount>',
                                    prefix: Text('I hereby accept to pay '),
                                    suffix: Text(' sek for exchange of '),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(1.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: '<quantity>',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(1.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: '<object>',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Create"),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Text("Create Auction"),
        ),
      ),
    );
  }
}
