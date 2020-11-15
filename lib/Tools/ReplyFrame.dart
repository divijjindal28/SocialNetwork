import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:provider/provider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

class ReplyFrame extends StatefulWidget {
  String commentId;
  CommentScreenState parent;
  ReplyFrame({this.parent=null,this.commentId});
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: ()      {
                              if(UserProvider.mainUser.userId == _replyData.userId){}

                              else
                              Navigator.of(context).pushNamed(UserScreen.route,arguments: _replyData.userId);}
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
                          UserProvider.mainUser.userId == _replyData.userId  ?
                          DropdownButton(

                              icon:const Icon(Icons.more_horiz),
                              items: [
                                DropdownMenuItem(
                                  child:const  Text('Delete'),
                                  value: 'delete',
                                )
                              ],
                              onChanged: (value) async{
                                if (value == 'delete') {
                                  try{
                                    await showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Center(child: Text("Delete Post")),
                                          content: Text("Do you really want to delete this post?"),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                FlatButton(
                                                  child: Text('Yes'),
                                                  onPressed:()async{
                                                    try {
                                                      await Provider.of<Comment>(context, listen: false).deletePostReply(_replyData.reply_id);
                                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Reply deleted from your timeline',style: TextStyle(color:Colors.white),),backgroundColor: Theme.of(context).primaryColor,));

                                                      Navigator.of(ctx).pop();
                                                      widget.parent.setState(() {

                                                      });
                                                    }catch(error){
                                                      MessegeBox.ShowError(context: context,msg: error.toString(),intent: 'ERROR');
                                                    }
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text('No'),
                                                  onPressed:() => Navigator.of(ctx).pop(),
                                                )
                                              ],
                                            )

                                          ],
                                        )
                                    );

                                  }catch(err){
                                    MessegeBox.ShowError(
                                        context: context,
                                        msg: err.toString(),
                                        intent: 'ERROR');
                                    Navigator.of(context).pop(false);
                                  }

                                }
                              }):
                          Container()
                        ],
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


