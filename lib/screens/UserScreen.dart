import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/Tools/UserDescription.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  static const route = './userScreen';
  final bool currentUser;
  final bool homeScreen;

  UserScreen({this.currentUser = false, this.homeScreen = false});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Map<String,dynamic> data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: homeScreen ? null : AppBar(title: const Text('Social Network')),
      body: FutureBuilder(
        future:currentUser? Provider.of<PostProvider>(context, listen: false).getPost(UserProvider.mainUser.userId):
        Provider.of<PostProvider>(context, listen: false).getPost(data["userId"].toString()),
        builder: ((ctx, resultSnap) {
          if (resultSnap.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (resultSnap.hasError) {
            return Center(
                child: Text('Could not load. Please try again.' +
                    resultSnap.toString()));
          } else {
            //List<Post> _loadedPosts =Provider.of<PostProvider>(context,).getMyPost;

            
            return Consumer<PostProvider>(
              builder: (ctx,_posts,_) {
                var _loadedPosts = _posts.getMyPost;
              return  Center(
                      child: Container(
                        width: width > 500 ? 500 : double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        child: ListView.builder(
                            itemCount: _loadedPosts.length + 1,
                            itemBuilder: (ctx, index) {
                              if (index == 0) {
                                return UserDescription(
                                  currentUser: currentUser,
                                  data:data
                                );
                              }
                              index = index - 1;
                              return _loadedPosts.length == 0
                                  ? Center(child: Text('You have no posts yet'))
                                  : ChangeNotifierProvider.value(
                                value: _loadedPosts[index],
                                child: Card(
                                    elevation: 4,
                                    child: PostFrame(
                                      currentUser: currentUser,
                                    )),
                              );
                            }),
                      ),
                    );
    }
            );
          }
        }),
      ),
    );
  }
}
