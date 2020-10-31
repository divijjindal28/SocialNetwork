import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/AddAndEditPost.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';
import 'package:provider/provider.dart';

class PostFrame extends StatefulWidget {
  bool commentWork;
  bool currentUser;

  PostFrame({this.commentWork = true, this.currentUser = false});
  bool isLoading = false;
  bool isLoading2 = false;

  @override
  _PostFrameState createState() => _PostFrameState();
}

class _PostFrameState extends State<PostFrame> {
  Post mypost;


  @override
  Widget build(BuildContext context) {
    var _postProvider = Provider.of<PostProvider>(context,listen: false);
    mypost = Provider.of<Post>(context);
    void comment() {
      Navigator.of(context).pushNamed(PostScreen.route,arguments: mypost);
    }

    Future<void> like() async{
      setState(() {
        widget.isLoading = true;
      });
      try{await Provider.of<Post>(context,listen:false).addTofav(mypost.post_id);}
      catch(error){MessegeBox.ShowError(context: context,msg: error.toString(),intent: 'ERROR');}
      setState(() {
        widget.isLoading = false;
      });
    }

    Future<void> share() async{
      setState(() {
        widget.isLoading2 = true;
      });
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Center(child: Text('Share Post?')),
            content: Text("Do you want to share post?"),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    child: Text('Yes'),
                    onPressed:()async{
                      Navigator.of(ctx).pop();
                      try{await Provider.of<Post>(context,listen:false).sharePost(context,mypost.post_id,mypost.description,mypost.image_url);}
                    catch(error){MessegeBox.ShowError(context: context,msg: error.toString(),intent: 'ERROR');}

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

      setState(() {
        widget.isLoading2 = false;
      });
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(UserScreen.route);
                  },
                  child: FittedBox(
                      child: Text(
                    mypost.userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              widget.currentUser
                  ?
              DropdownButton(

                  icon:const Icon(Icons.more_horiz),
                  items: [
                    DropdownMenuItem(
                      child:const  Text('Edit'),
                      value: 'edit',
                    ),DropdownMenuItem(
                      child:const  Text('Delete'),
                      value: 'delete',
                    )
                  ],
                  onChanged: (value) async{
                    if (value == 'edit') {
                      Navigator.of(context).pushNamed(AddAndEditPost.route,arguments: {

                        'provider':mypost
                      });

                    }else
                    {
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
                                      onPressed:()async{await _postProvider.deletePost(mypost.post_id);Navigator.of(ctx).pop();},
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
                  })
                  : Container()
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 15, left: 15, right: 15),
            child: Text(
                mypost.description),
          ),
        ),
        FadeInImage(
            placeholder:const AssetImage('assets/loading3.gif'),
            image: NetworkImage(mypost.image_url),
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              widget.isLoading?Center(child: CircularProgressIndicator(),):
              feedbackRow( Icon(mypost.like == true? Icons.favorite : Icons.favorite_border, color: Colors.grey),
                  ()async{await like();}, mypost.likes_count),
              feedbackRow(const Icon(Icons.mode_comment, color: Colors.grey),
                  widget.commentWork ? comment : null, mypost.comments_count),
              widget.isLoading2?Center(child: CircularProgressIndicator(),):
              feedbackRow(const Icon(Icons.share, color: Colors.grey),()async{await share();},  mypost.shares_count)
            ],
          ),
        )
      ],
    );
  }

  Row feedbackRow(Icon icon, Function function, int count) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: icon,
          onPressed: function,
        ),
        Text(count.toString(), style: TextStyle(color: Colors.grey))
      ],
    );
  }
}
