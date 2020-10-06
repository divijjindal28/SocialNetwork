import 'package:flutter/material.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

class PostFrame extends StatelessWidget {
  bool commentWork;
  PostFrame({this.commentWork = true});
  @override
  Widget build(BuildContext context) {

    void comment()
    {
      Navigator.of(context).pushNamed(PostScreen.route);
    }

    return  Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(UserScreen.route);

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: FittedBox(child: Text('Post Heading',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top:0,bottom: 15,left:15,right:15),
                    child:  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut'
                        ' labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi'
                        ' ut aliquip ex ea commodo consequat. '),
                  ),
                ),
                Image(
                  //should be Image
                  //image: null,
                  image: AssetImage('t_shirt.png'),
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                  //fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      feedbackRow(
                          const Icon(Icons.favorite_border, color: Colors.grey),
                          null,
                          342),
                      feedbackRow(
                          const Icon(Icons.mode_comment, color: Colors.grey),
                          commentWork ? comment : null,
                          5),
                      feedbackRow(
                          const Icon(Icons.share, color: Colors.grey), null, 16)
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
