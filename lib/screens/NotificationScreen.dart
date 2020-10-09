import 'package:flutter/material.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';


class NotificationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),

        child:  ListView.builder(
                  itemCount: 10 +1,
                  itemBuilder: (ctx,index){
                    if(index == 0)
                      {
                        return Center(child: Text('Slide to delete Notification'));
                      }
                    index = index - 1;
                    return Column(
                      children: [
                        Dismissible(


                            key: ValueKey(index.toString()),
                            background: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                              alignment: Alignment.centerRight,
                              child:  const Icon(
                                Icons.clear,
                                size: 20,

                              ),

                            ),


                            direction: DismissDirection.endToStart,
                            // Provide a function that tells the app
                            // what to do after an item has been swiped away.

                            confirmDismiss: (direction){
                              return Future.value(true);
                            },

                            onDismissed: (_){

                            },
                            child:ListTile(
                              leading: Hero(
                                tag:index,
                                child: CircleAvatar(
                                  backgroundColor:Colors.grey ,
                                ),
                              ),
                              title:Wrap(
                                direction:Axis.horizontal ,
                                children: [
                                  GestureDetector(
                                      onTap: (){Navigator.of(context).pushNamed(UserScreen.route);},
                                      child: Text('UserName',style: TextStyle(fontWeight: FontWeight.bold),)),
                                  Text(' has commented on your '),
                                  GestureDetector(
                                      onTap: (){Navigator.of(context).pushNamed(PostScreen.route);},
                                      child:Text('your Post',style: TextStyle(fontWeight: FontWeight.bold),))
                                ],
                              ) ,


                            )

                        ),
                        Divider()
                      ],
                    );

                  }
              ),

      ),
    );
  }
}
