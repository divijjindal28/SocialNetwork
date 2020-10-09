import 'package:flutter/material.dart';
import 'package:socialmediaapp/Tools/MesseegeBox.dart';
import 'package:socialmediaapp/screens/AddAndEditPost.dart';
import 'package:socialmediaapp/screens/PostScreen.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';

class PostFrame extends StatelessWidget {
  bool commentWork;
  bool currentUser;
  PostFrame({this.commentWork = true, this.currentUser = false});
  @override
  Widget build(BuildContext context) {
    void comment() {
      Navigator.of(context).pushNamed(PostScreen.route);
    }



    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(UserScreen.route);
                  },
                  child: FittedBox(
                      child: Text(
                    'Post Heading',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              currentUser
                  ?
              DropdownButton(

                  icon: Icon(Icons.more_horiz),
                  items: [
                    DropdownMenuItem(
                      child:  Text('Edit'),
                      value: 'edit',
                    ),DropdownMenuItem(
                      child:  Text('Delete'),
                      value: 'delete',
                    )
                  ],
                  onChanged: (value) {
                    if (value == 'edit') {
                      Navigator.of(context).pushNamed(AddAndEditPost.route);

                    }else
                    {

                    }
                  })
                  : Container()
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 15, left: 15, right: 15),
            child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut'
                ' labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi'
                ' ut aliquip ex ea commodo consequat. '),
          ),
        ),
        FadeInImage(
            placeholder: AssetImage('assets/loading3.gif'),
            image: NetworkImage('https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg'),
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
        ),
//        Image.network(
//          'https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg',
//          fit: BoxFit.cover,
//          height: 300,
//          width: double.infinity,
//          //fit: BoxFit.cover,
//        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              feedbackRow(const Icon(Icons.favorite_border, color: Colors.grey),
                  null, 342),
              feedbackRow(const Icon(Icons.mode_comment, color: Colors.grey),
                  commentWork ? comment : null, 5),
              feedbackRow(const Icon(Icons.share, color: Colors.grey),null, 16)
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
