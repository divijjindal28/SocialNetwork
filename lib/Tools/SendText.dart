import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';


class SendText extends StatefulWidget {
  int type;
  String text;
  String id ;
  SendText(this.id,this.text,this.type);
  @override
  _SendTextState createState() => _SendTextState();
}

class _SendTextState extends State<SendText> {

  var messages = '';
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    void _onMessageSend()async{
      try {
        if (widget.type == 0) {
          var post = Provider.of<Post>(context, listen: false);
          await post.addComment(widget.id, _controller.text);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(
            'Comment added', style: TextStyle(color: Colors.white),),
            backgroundColor: Theme
                .of(context)
                .primaryColor,));
        } else if (widget.type == 1) {
          var comment = Provider.of<Comment>(context, listen: false);
          await comment.addReply(widget.id, _controller.text);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(
            'Reply added', style: TextStyle(color: Colors.white),),
            backgroundColor: Theme
                .of(context)
                .primaryColor,));
        }
      }catch(error){
        MessegeBox.ShowError(context: context,intent: "ERROR");
      }

      _controller.clear();
    }


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
                        hintText: widget.text),

                    validator:(val){
                      if(val.isEmpty){
                        return 'Plaese enter text';
                      }
                      else return null;
                    } ,
                    onSaved: (value){
                      setState(() {
                        _controller.text = value;
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
