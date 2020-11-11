import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/UserDescription.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../HtttpException.dart';

class UserScreen extends StatefulWidget {
  static const route = './userScreen';
  final bool currentUser;
  final bool homeScreen;
  bool init = false;
  bool _isLoading = false;
  Map<String, dynamic> data;
  UserScreen({this.currentUser = false, this.homeScreen = false});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Future<void> refresh() async {
      setState(() {
        widget._isLoading = true;
      });
      try {
        widget.currentUser
            ? await Provider.of<PostProvider>(context, listen: false)
                .getPost(UserProvider.mainUser.userId)
            : Provider.of<PostProvider>(context, listen: false)
                .getPost(widget.data['userId']);
      } catch (error) {
        await MessegeBox.ShowError(context: context, intent: "ERROR");
      }
      setState(() {
        widget._isLoading = false;
      });
    }

    Future<void> getUserData(String _userId)async{
      try{

        var userData = await Firestore.instance.collection('users').document(_userId).get();
        var followersData = await Firestore.instance.collection('users/$_userId/Followers').getDocuments();
        var followingData = await Firestore.instance.collection('users/$_userId/Following').getDocuments();


        if(userData == null)
        {
          throw HttpException('User Does not exist2...please sign in again or check net connection ${_userId} hi');
        }

        List<FollowMap> followers = [];
        List<FollowMap> following = [];

        if(followersData!=null){
          followersData.documents.forEach((element) =>
              followers.insert(0, FollowMap(
                  userImageUrl: element['imageUrl'],
                  userName: element['name'],
                  userId: element.documentID
              ))
          );}

        if(followingData!=null){
          followingData.documents.forEach((element) =>
              following.insert(0, FollowMap(
                  userImageUrl: element['imageUrl'],
                  userName: element['name'],
                  userId: element.documentID
              ))
          );}

        widget.data = {
          'userId': _userId,
          'userName': userData['userName'],
          'userImage': userData['userImage'],
          'following': following,
          'followers': followers
        };

      }catch(error){
        throw HttpException('User Does not exist...please sign in again or check net connection'+error.toString());
      }
    }

    String userId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: widget.homeScreen
          ? null
          : AppBar(title: const Text('Social Network')),
      body: FutureBuilder(
        future: getUserData(userId),
        builder: (ctx, futureSnap) {
          if (futureSnap.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return RefreshIndicator(
              onRefresh: refresh,
              child: widget._isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : FutureBuilder(
                      future: widget.currentUser
                          ? Provider.of<PostProvider>(context, listen: false)
                              .getPost(UserProvider.mainUser.userId)
                          : Provider.of<PostProvider>(context, listen: false)
                              .getPost(widget.data["userId"].toString()),
                      builder: ((ctx, resultSnap) {
                        if (resultSnap.connectionState ==
                            ConnectionState.waiting)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        else if (resultSnap.hasError) {
                          return Center(
                              child: Text('Could not load. Please try again.' +
                                  resultSnap.toString()));
                        } else {
                          //List<Post> _loadedPosts =Provider.of<PostProvider>(context,).getMyPost;
                          var _loadedPosts = Provider.of<PostProvider>(context, listen: false).getMyPost;

                            return Center(
                              child: Container(
                                width: width > 500 ? 500 : double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                child: ListView.builder(
                                    itemCount: _loadedPosts.length + 1,
                                    itemBuilder: (ctx, index) {
                                      if (index == 0) {
                                        return UserDescription(
                                            currentUser: widget.currentUser,
                                            data: widget.data);
                                      }
                                      index = index - 1;
                                      return _loadedPosts.length == 0
                                          ? Center(
                                              child:
                                                  Text('You have no posts yet'))
                                          : ChangeNotifierProvider.value(
                                              value: _loadedPosts[index],
                                              child: Card(
                                                  elevation: 4,
                                                  child: PostFrame(

                                                    currentUser:
                                                        widget.currentUser,
                                                  )),
                                            );
                                    }),
                              ),
                            );

                        }
                      }),
                    ),
            );
          }
        },
      ),
    );
  }
}
