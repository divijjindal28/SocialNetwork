import 'package:flutter/material.dart';


class ImageScreen extends StatelessWidget {
  static const route  = './imageScreen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:Text('Image')
      ),
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: 1,
                  child: Container(
                    height: 500,
                      color: Colors.grey,
                      ),
                ),
              ),
              FlatButton(minWidth: double.infinity,onPressed: (){}, child: Text('Change Image',style: TextStyle(color: Theme.of(context).primaryColor),))
            ],
          ),
        ),
      ),
    );
  }
}
