import 'package:flutter/material.dart';
import 'package:socialmediaapp/screens/AccountScreen.dart';
import 'package:socialmediaapp/screens/CommentScreen.dart';
import 'package:socialmediaapp/screens/HomeScreen.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/SearchScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';


class TabScreen extends StatefulWidget {


  @override
  _tabs_screenState createState() => _tabs_screenState();
}

class _tabs_screenState extends State<TabScreen> {
  List<Map<String,Object>> pages;
  int selectedPageIndex=0;

  @override
  void initState() {
    pages =[

      {'page':HomeScreen(),'title':'Home'},
      {'page':CommentScreen(),'title':'Search'},
      {'page':UserScreen(),'title':'Accout'}

    ];

    // TODO: implement initState
    super.initState();
  }

  void _selectPage(int index){
    setState(() {
      selectedPageIndex=index;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          )
        ],
      ),

    );
  }
}
