import 'package:flutter/material.dart';
import 'package:socialmediaapp/screens/ImageScreen.dart';

class UserDescription extends StatelessWidget {
  final bool currentUser ;
  UserDescription({this.currentUser = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom: 4),
      constraints: BoxConstraints(
        maxHeight: 240
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Hero(
                          tag: 1,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed(ImageScreen.route);
                            },
                            child: CircleAvatar(
                              child: Text('Add Image',style: TextStyle(color: Colors.white),),
                              backgroundColor: Colors.grey,
                              maxRadius: 70,

                              //should be image

                            ),
                          ),
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
                              child:  Text("Divij Jindal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20 ),)),


                      const SizedBox(height: 20,),
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
                  child: Text(currentUser?'LogOut': "Follow"),
                  onPressed: (){},
                ),
              ),
              SizedBox(width: 10,),

              currentUser?Container(): Expanded(
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