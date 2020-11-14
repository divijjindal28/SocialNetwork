import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

class FollowScreen extends StatelessWidget {
  static const route = './followScreen';


  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    String heading = data['heading'];
    List<FollowMap> followList = data['followList'];
    return Scaffold(
      appBar: AppBar(
        title: Text(heading),
      ),
      body:followList == null ? Center(child: Text('No ${heading}'),) : ListView(
        children: [
          ...followList.map((e) =>
           ListTile(
             onTap: (){
               if(e.userId == UserProvider.mainUser.userId)
                 {
                   Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please go to your account screen')));
                 }
               else{
                 Navigator.of(context).pushNamed(UserScreen.route,arguments: e.userId);
               }
             },
             leading: CircleAvatar(
               backgroundImage: NetworkImage(e.userImageUrl),
             ),
             title: Text(e.userName),
           )
          )
        ],
      ),
    );
  }
}
