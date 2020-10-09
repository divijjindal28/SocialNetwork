import 'package:flutter/material.dart';
import 'package:socialmediaapp/screens/ChatScreen.dart';
import 'package:socialmediaapp/screens/HomeScreen.dart';
import 'package:socialmediaapp/screens/NotificationScreen.dart';
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
    pages =  [

      {'page':HomeScreen(),'title':'Home'},
      {'page':SearchScreen(),'title':'Search'},
      {'page':NotificationScreen(),'title':'Notification'},
      {'page':UserScreen(homeScreen: true,currentUser: true,),'title':'Account'},
      {'page':ChatScreen(),'title':'Chat'},

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
            icon:const Icon(Icons.home),
            label:'Home',
          ),
          const BottomNavigationBarItem(
            icon:const Icon(Icons.search),
            label:'Search',
          ),
          const BottomNavigationBarItem(
            icon:const Icon(Icons.notifications_none),
            label:'Notify',
          ),
          const BottomNavigationBarItem(
            icon:const Icon(Icons.account_circle),
            label:'Account',
          ),
          const BottomNavigationBarItem(
            icon:const Icon(Icons.chat_bubble_outline),
            label:'Chat',
          ),
        ],
      ),

    );
  }
}
