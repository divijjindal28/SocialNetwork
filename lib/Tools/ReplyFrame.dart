import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

class ReplyFrame extends StatefulWidget {
  String commentId;
  ReplyFrame(this.commentId);
  bool _isLoading = false;

  @override
  _ReplyFrameState createState() => _ReplyFrameState();
}

class _ReplyFrameState extends State<ReplyFrame> {
  @override
  Widget build(BuildContext context) {
    Reply _replyData=  Provider.of<Reply>(context);

    Future<void> like() async{
      setState(() {
        widget._isLoading = true;
      });
      try{await Provider.of<Reply>(context,listen:false).addTofav(widget.commentId,_replyData.reply_id);}
      catch(error){MessegeBox.ShowError(context: context,msg: error.toString(),intent: 'ERROR');}
      setState(() {
        widget._isLoading = false;
      });
    }
    return
      Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: ()      {Navigator.of(context).pushNamed(UserScreen.route,arguments: _replyData.userId);}
              ,
                        child: Padding(
                          padding:const EdgeInsets.all(2),

                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(_replyData.userName, style: TextStyle(
                                  fontWeight: FontWeight.bold),),
                            ),

                        ),
                      ),

                       Padding(
                          padding:const EdgeInsets.all(2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(_replyData.reply, style: TextStyle(
                            ),),
                          ),
                        ),

                      widget._isLoading?
                      Center(child: CircularProgressIndicator(),):
                      feedbackRow(
                      Icon(_replyData.like?Icons.favorite: Icons.favorite_border,color: Colors.red,),
                              ()async{await like();},
                          'likes',
                          _replyData.likes_count),
                    ],
                  ),
                )
            ),
          Divider()
        ],
      );


  }

  Row feedbackRow(Icon icon, Function function,String label, int count) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: icon,
          onPressed: function,

        ),
        Text(count.toString() +"  " +label, style: TextStyle(color: Colors.grey)),
        //Text(count.toString(), style: TextStyle(color: Colors.grey))
      ],
    );
  }
}


