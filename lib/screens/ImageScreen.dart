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

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 1,
                child: Container(
                  height: 500,
                    color: Colors.grey,
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
