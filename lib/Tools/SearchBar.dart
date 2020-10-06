import 'package:flutter/material.dart';


class SearchBar extends StatefulWidget {

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {


  void _onMessageSend()async{
    FocusScope.of(context).unfocus();

    _controller.clear();
  }
  var messages = '';
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
      child: Container(

        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).accentColor,
              width: 2
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(25.0) //
          ),
        ),

        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(

                  controller: _controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
                      hintText: 'Search'),

                  onChanged: (value){
                    setState(() {
                      messages = value;
                    });
                  },
                ),


            ),
            IconButton(icon:const Icon(Icons.search,size: 25,), onPressed: _onMessageSend)
          ],
        ),

      ),
    );
  }
}
