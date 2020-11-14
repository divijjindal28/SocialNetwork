import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/PostProvider.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/Tools/PostFrame.dart';
import 'package:socialmediaapp/screens/AddAndEditPost.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends StatefulWidget {

  bool _isLoading =false;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Future<void> refresh() async {
      setState(() {
        widget._isLoading = true;
      });
      try {
        await Provider.of<PostProvider>(context, listen: false)
            .getHomeScreenPosts();
      } catch (error) {
        await MessegeBox.ShowError(context: context, intent: "ERROR");
      }
      setState(() {
        widget._isLoading = false;
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: ()async{
          var _result = await Navigator.of(context).pushNamed(AddAndEditPost.route);
          _result == true ?
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Post added',style: TextStyle(color: Colors.white),),backgroundColor: Theme.of(context).primaryColor,)) :
              Scaffold.of(context).showSnackBar(SnackBar(content:  Text('Post could not be added',style: TextStyle(color: Colors.white)),backgroundColor: Theme.of(context).primaryColor,));
          },
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: widget._isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : FutureBuilder(
          future: Provider.of<PostProvider>(context, listen: false)
              .getHomeScreenPosts(),
          builder: ((ctx, resultSnap) {
            if (resultSnap.connectionState ==
                ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (resultSnap.hasError) {
              return Center(
                  child: Text('Could not load. Please try again.' ));
            } else {
              //List<Post> _loadedPosts =Provider.of<PostProvider>(context,).getMyPost;

              return Consumer<PostProvider>(
                  builder: (ctx, _posts, _) {
                    var _loadedPosts = _posts.getMyPost;
                    return Center(
                      child: Container(
                        width: width > 500 ? 500 : double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        child: ListView.builder(
                            itemCount: _loadedPosts.length ,
                            itemBuilder: (ctx, index) {

                              return _loadedPosts.length == 0
                                  ? Center(
                                  child:
                                  Text('You have no posts yet'))
                                  : ChangeNotifierProvider.value(
                                value: _loadedPosts[index],
                                child: Card(
                                    elevation: 4,
                                    child: PostFrame(
                                      timeLine: true,

                                      currentUser:
                                      false,
                                    )),
                              );
                            }),
                      ),
                    );
                  });
            }
          }),
        ),
      )
    );
  }
}
