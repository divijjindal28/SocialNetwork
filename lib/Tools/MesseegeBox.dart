

import 'package:flutter/material.dart';

class MessegeBox {
   static void ShowError({
    @required BuildContext context,
    String title = 'Something went wrong!',
    String msg = "Please try again after sometime.Please try again after sometime.",
    String intent,
    Function function})
  {
     showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Center(child: Text(title)),
          content: Text(msg),
          actions: <Widget>[
            intent.contains('ERROR')?
            FlatButton(
              child: Text('Okay'),
              onPressed:() => Navigator.of(ctx).pop(),
            ):
            FlatButton(
              child: Text('Yes'),
              onPressed:function,
            ),
            FlatButton(
              child: Text('No'),
              onPressed:() => Navigator.of(ctx).pop(),
            )
          ],
        )
    );
  }
}