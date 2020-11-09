import 'package:flutter/material.dart';
import 'package:socialmediaapp/Providers/UserProvider.dart';
import 'package:socialmediaapp/screens/UserScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  static const route = './searchScreen';
  final controller = TextEditingController();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print("CNTRL"+widget.controller.text);
    return Scaffold(
      body: Center(
        child: Container(
          width: width > 500 ? 500 : double.infinity,
          margin:
              const EdgeInsets.only(top: 30, bottom: 4, left: 10, right: 10),
          child: Column(
            children: [
          Padding(
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

                    controller:widget.controller,

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
                        print("VAL"+ value);

                      });
                    },
                  ),


                ),
                IconButton(icon:const Icon(Icons.search,size: 25,), onPressed: null)
              ],
            ),

          ),
        ),
              Expanded(
                  child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('users')
                          .where('userName',
                              isGreaterThanOrEqualTo: widget.controller.text.toString())

                          .snapshots(),
                      builder: (ctx, streamSnapshot) {
                        if (streamSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!streamSnapshot.hasData) {
                          return Center(child: Text('no result'));
                        }
                        var document = streamSnapshot.data.documents;
                        if (document.length == 0) {
                          return Center(child: Text('no result'));
                        }
                        print("DOC"+document[0].documentID);

                        return ListView.builder(
                            itemCount:  document.length,
                            itemBuilder: (ctx, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Hero(
                                      tag: document[index].documentID,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(document[index]["userImage"]),
                                      ),
                                    ),
                                    title: Text(document[index]["userName"]),
                                    onTap: () {
                                      if(document[index].documentID == UserProvider.mainUser.userId)
                                        {
                                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please go to account screen.',style: TextStyle(color:Colors.white),),backgroundColor: Theme.of(context).primaryColor,));
                                        }else {
                                        Navigator.of(context)
                                            .pushNamed(
                                            UserScreen.route, arguments: document[index].documentID
                                        );
                                      }
                                    },
                                  ),
                                  Divider()
                                ],
                              );
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
