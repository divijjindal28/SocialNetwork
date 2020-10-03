import 'package:flutter/material.dart';


class SendText extends StatefulWidget {
  int type;
  String text;
  SendText(this.text,this.type);
  @override
  _SendTextState createState() => _SendTextState();
}

class _SendTextState extends State<SendText> {


  void _onMessageSend()async{
    FocusScope.of(context).unfocus();

    _controller.clear();
  }
  var messages = '';
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: widget.text),
                  onChanged: (value){
                    setState(() {
                      messages = value;
                    });
                  },
                ),
              ),

            ),
            IconButton(icon: Icon(Icons.send), onPressed: _onMessageSend)
          ],
        ),
      ),
    );
  }
}
