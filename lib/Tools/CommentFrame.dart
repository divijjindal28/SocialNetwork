import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/CommentProvider.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Tools/SendText.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';
import 'package:provider/provider.dart';

class CommentFrame extends StatefulWidget {

  bool replyWork;
  bool deleteWork;
  PostScreenState parent;
  bool _isLoading = false;
  CommentFrame({this.parent = null,this.deleteWork = false,this.replyWork = true});
  var _comment;
  bool _init= false;
  @override
  _CommentFrameState createState() => _CommentFrameState();
}



class _CommentFrameState extends State<CommentFrame> {
  @override
  void didChangeDependencies() {
    if(!widget._init){
      widget._comment = Provider.of<Comment>(context);
      widget._init=true;

    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {



    void reply(){
      Navigator.of(context).pushNamed(CommentScreen.route ,arguments: widget._comment);

    }
    Future<void> like() async{
      setState(() {
        widget._isLoading = true;
      });
      try{await Provider.of<Comment>(context,listen: false).addTofav(widget._comment.comment_id);}
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                if(UserProvider.mainUser.userId == widget._comment.userId){}

                                else
                                Navigator.of(context).pushNamed(UserScreen.route,arguments: widget._comment.userId);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(widget._comment.userName, style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                            UserProvider.mainUser.userId == widget._comment.userId && widget.deleteWork ?
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
                                                        await Provider.of<Post>(context, listen: false).deletePostComment(widget._comment.comment_id);
                                                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Comment deleted from your timeline',style: TextStyle(color:Colors.white),),backgroundColor: Theme.of(context).primaryColor,));

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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:const EdgeInsets.all(2),
                            child: Text(widget._comment.comment, style: TextStyle(
                                ),),
                          ),
                        ),
                        Padding(
                            padding:const EdgeInsets.all(2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                widget._isLoading ? Center(child: CircularProgressIndicator(),): feedbackRow(context,
                                    Icon(widget._comment.like?Icons.favorite: Icons.favorite_border,color: Colors.red),
                                    ()async {await like();},
                                    Text(widget._comment.likes_count.toString() +"  " +'likes', style: TextStyle(color:Colors.grey))),
                                feedbackRow(context, Icon(Icons.comment,color: Theme.of(context).accentColor),
                                    widget.replyWork ? reply :null,
                                    Text(widget._comment.reply_count.toString() +"  " +'replies', style: TextStyle(color:Colors.grey))),
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


