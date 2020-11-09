
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class MessegeBox {
   static Future<void> ShowError({
    @required BuildContext context,
    String title = 'Something went wrong!',
    String msg = "Please try again after sometime.",
    String intent = '',
    var function = null})
  {
     return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Center(child: Text(title)),
          content: Text(msg),
          actions: <Widget>[
            intent.contains('ERROR')?
            FlatButton(
              child: Text('Okay'),
              onPressed:() => Navigator.of(ctx).pop(),
            ):Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  child: Text('Yes'),
                  onPressed:()async{await function;Navigator.of(ctx).pop();},
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed:() => Navigator.of(ctx).pop(),
                )
              ],
            )

          ],
        )
    );
  }



   static Future<String> takeImage(BuildContext context) async {
     bool camera = true;
     try{await showDialog(
         context: context,
         builder: (ctx) => AlertDialog(
           title: Center(child: Text("Take Image")),
           content: Text("Please select the way you want to take image"),
           actions: <Widget>[
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 FlatButton(
                   child: Text('Camera'),
                   onPressed:(){camera = true;Navigator.of(ctx).pop();},
                 ),
                 FlatButton(
                   child: Text('Gallery'),
                   onPressed:() {camera = false;Navigator.of(ctx).pop();},
                 )
               ],
             )

           ],
         )
     );
     var _myimage = await ImagePicker().getImage(source:camera? ImageSource.camera:ImageSource.gallery,
         //imageQuality: 50,
         maxWidth: 500
     );

     return _myimage.path;
     }
     catch(err){
       await ShowError(context: context,intent: 'ERROR');
     }


   }
}