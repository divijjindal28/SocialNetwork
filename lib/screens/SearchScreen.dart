import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/SearchBar.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

class SearchScreen extends StatelessWidget {
  static const route  = './searchScreen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,
          margin: const EdgeInsets.only(top:30,bottom: 4, left: 10,right: 10),
          child: Column(
            children: [
              SearchBar(),
              Expanded(child: ListView.builder(
                  itemCount: 10,
                  itemBuilder:(ctx,index){
                    return Column(
                      children: [
                        ListTile(

                          leading: Hero(
                            tag: index,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          title: Text('Username'),
                          onTap: (){
                            Navigator.of(context).pushNamed(UserScreen.route);
                          },
                        ),
                        Divider()
                      ],
                    );
                  }

              ))
            ],
          ),
        ),
      ),
    );
  }
}