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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(

        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).accentColor,
            width: 2
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(25.0) //
          ),
        ),

          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(

                    controller: _controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Type Comment'),

                    onChanged: (value){
                      setState(() {
                        messages = value;
                      });
                    },
                  ),
                ),

              ),
              IconButton(icon:const Icon(Icons.send,size: 25,), onPressed: _onMessageSend)
            ],
          ),

      ),
    );
  }
}
