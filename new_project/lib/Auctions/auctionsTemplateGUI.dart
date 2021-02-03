import 'package:flutter/material.dart';

class AuctionTemplateGUI extends StatefulWidget {
  @override
  _AuctionTemplateState createState() => _AuctionTemplateState();
}

class _AuctionTemplateState extends State<AuctionTemplateGUI> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingControllerOne;
  TextEditingController _textEditingControllerTwo;
  TextEditingController _textEditingControllerThree;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 400,
                    margin: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: 18.0,
                          ),
                          margin: EdgeInsets.only(top: 13.0, right: 8.0),
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            color: Colors.grey[
                                900], //Couldn't import from theme as "Dialog" is transparent
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20.0,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: <Widget>[
                                      IntrinsicWidth(
                                        child: Text(
                                          'I hereby accept to pay ',
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                        ),
                                      ),
                                      IntrinsicWidth(
                                        child: TextFormField(
                                          controller: _textEditingControllerOne,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: '<amount>',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' sek for exchange of ',
                                        textAlign: TextAlign.center,
                                      ),
                                      IntrinsicWidth(
                                        child: TextFormField(
                                          controller: _textEditingControllerTwo,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: '<quantity>',
                                          ),
                                        ),
                                      ),
                                      IntrinsicWidth(
                                        child: TextFormField(
                                          controller:
                                              _textEditingControllerThree,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: '<object>\n',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                        textAlign: TextAlign.center,
                                      ),
                                      /*
                                ====================
                                Bottombutton
                                ====================
                                */
                                      SizedBox(height: 24.0),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton(
                                          child: Text("Create"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
          },
          child: Text("Create Auction"),
        ),
      ),
    );
  }
}
