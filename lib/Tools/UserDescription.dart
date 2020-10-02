import 'package:flutter/material.dart';

class UserDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(left: 10,right: 10, top: 0,bottom: 4),
      height: 200,
      child: Column(
        children: <Widget>[

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      maxRadius: 60,
                      //should be image

                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FittedBox(
                          child: const Text("Divij Jindal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 ),)),
                      SizedBox(height: 20,),
                      Column(
                        children: <Widget>[
                          const Text("Followers" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                           FittedBox(
                             child: Column(
                               children: <Widget>[
                                 Text("342",style: TextStyle( fontSize: 18),),
                               ],
                             ),
                           ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(

                child: RaisedButton(
                  child: Text("Follow"),
                  onPressed: (){},
                ),
              ),
              SizedBox(width: 10,),

              Expanded(
                child: RaisedButton(
                  child: Text("Messege"),
                  onPressed: (){},
                ),
              ),
            ],
          )
        ],

      ),
    );
  }
}