import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Tools/SendText.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';
import 'package:provider/provider.dart';

class CommentFrame extends StatefulWidget {

  bool replyWork;
  bool _isLoading = false;
  CommentFrame({this.replyWork = true});

  @override
  _CommentFrameState createState() => _CommentFrameState();
}

class _CommentFrameState extends State<CommentFrame> {
  @override
  Widget build(BuildContext context) {
    var _comment = Provider.of<Comment>(context);
    void reply(){
      Navigator.of(context).pushNamed(CommentScreen.route ,arguments: _comment);

    }
    Future<void> like() async{
      setState(() {
        widget._isLoading = true;
      });
      try{await Provider.of<Comment>(context,listen: false).addTofav(_comment.comment_id);}
      catch(error){MessegeBox.ShowError(context: context,msg: error.toString(),intent: 'ERROR');}
      setState(() {
        widget._isLoading = false;
      });
    }

    return
        Column(
          children: <Widget>[
            Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            if(UserProvider.mainUser.userId == _comment.userId){}

                            else
                            Navigator.of(context).pushNamed(UserScreen.route,arguments: _comment.userId);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(_comment.userName, style: TextStyle(
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:const EdgeInsets.all(2),
                            child: Text(_comment.comment, style: TextStyle(
                                ),),
                          ),
                        ),
                        Padding(
                            padding:const EdgeInsets.all(2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                widget._isLoading ? Center(child: CircularProgressIndicator(),): feedbackRow(context,
                                    Icon(_comment.like?Icons.favorite: Icons.favorite_border,color: Colors.red),
                                    ()async {await like();},
                                    Text(_comment.likes_count.toString() +"  " +'likes', style: TextStyle(color:Colors.grey))),
                                feedbackRow(context, Icon(Icons.comment,color: Theme.of(context).accentColor),
                                    widget.replyWork ? reply :null,
                                    Text(_comment.reply_count.toString() +"  " +'replies', style: TextStyle(color:Colors.grey))),
                              ],
                            )
                        ),
                      ],
                    )
                ),
            Divider()
          ],
        );


  }

  Row feedbackRow(BuildContext context,Icon icon, Function function,Text label) {
    return Row(
      children: <Widget>[
        FlatButton.icon(
          icon: icon,
          onPressed: function,
          label: label ,
        ),
        //Text(count.toString(), style: TextStyle(color: Colors.grey))
      ],
    );
  }
}


