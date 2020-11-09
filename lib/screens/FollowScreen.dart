import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';

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
