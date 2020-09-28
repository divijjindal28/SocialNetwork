import 'package:flutter/material.dart';

class PostFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print("width    " + width.toString());

    return Center(
      child: Container(
            width: width > 500 ? 500 : double.infinity,
            child: Card(

              margin:const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              elevation: 4,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:const EdgeInsets.all(15),
                      child: FittedBox(
                          child: Text('Post Heading')),
                    ),
                  ),
                  Container(
                    //should be Image
                    //image: null,
                    color: Colors.black,
                    height: 300,
                    width: double.infinity,
                    //fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        feedbackRow(const Icon(Icons.favorite_border,color: Colors.grey),null,342),
                        feedbackRow(const Icon(Icons.mode_comment,color: Colors.grey),null,5),
                        feedbackRow(const Icon(Icons.share,color: Colors.grey),null,16)
                      ],
                    ),
                  )

                ],
              ),
            )
      ),
    );
  }

  Row feedbackRow(Icon icon, Function function,int count) {
    return Row(
                        children: <Widget>[
                          IconButton(
                            icon: icon,
                            onPressed: null,
                          ),

                          Text(count.toString(),style: TextStyle(color: Colors.grey))
                        ],
                      );
  }
}
