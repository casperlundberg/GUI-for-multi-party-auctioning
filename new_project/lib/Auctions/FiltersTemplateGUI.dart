import 'package:flutter/material.dart';

class FilterTemplateGUI extends StatefulWidget {
  @override
  _FilterTemplateState createState() => _FilterTemplateState();
}

class _FilterTemplateState extends State<FilterTemplateGUI> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingControllerOne;
  TextEditingController _textEditingControllerTwo;
  TextEditingController _textEditingControllerThree;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ignore: deprecated_member_use
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
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: IntrinsicWidth(
                                  child: Text(
                                    'I hereby accept to pay ',
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: IntrinsicWidth(
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
                              ),
                              Expanded(
                                child: Text(
                                  ' sek for exchange of ',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                child: IntrinsicWidth(
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
                              ),
                              Flexible(
                                child: IntrinsicWidth(
                                  child: TextFormField(
                                    controller: _textEditingControllerThree,
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
                              ),
                              Expanded(
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                // ignore: deprecated_member_use
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: RaisedButton(
                                    child: Text("Create"),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                      }
                                    },
                                  ),
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
          child: Text("Add filters"),
        ),
      ),
    );
  }
}
