import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



enum AuthType {SignUp,LogIn}

class AuthScreen extends StatelessWidget{

  static const route = './authScreen';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(

          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,

              width: deviceSize.width,
              child: Center(
                child: AuthCard(),
              )

            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget{
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin{

  var _isLoading = false;
  var userName='';
  var email = '';
  var password='';
  var _auth_type = AuthType.LogIn;
  final _form = GlobalKey<FormState>();
  final userNameFocus=FocusNode();
  final _email_focus=FocusNode();
  final _password_focus=FocusNode();
  final _confirm_password_focus=FocusNode();
  final _password_controller =  TextEditingController();
  AnimationController _controller;
  Animation<Offset> _offset_animation;
  Animation<double> _opacity_animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    _offset_animation = Tween<Offset>(begin: Offset(0,-0.5),end: Offset(0,0)).animate(CurvedAnimation(parent: _controller,curve: Curves.linear));
    _opacity_animation = Tween<double>(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: _controller,curve: Curves.linear));

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    userNameFocus.dispose();
    _email_focus.dispose();
    _password_focus.dispose();
    _confirm_password_focus.dispose();
    _password_controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    void SaveForm() async{
//      print("saveform");
//      if(!_form.currentState.validate()){return;}
//      print("saveform2");
//      _form.currentState.save();
//      setState(() {
//        _isLoading = true;
//      });
//      try{
//        if(_auth_type == AuthType.LogIn){
//          print('working_login');
//        }else{
//          print('working');
//
//        }
//      }
//      on HttpException catch(error){
//        String message='Authentication failed!';
//        if(error.toString().contains("EMAIL_NOT_FOUND"))
//        {
//          message='Email not found.';
//        }else if(error.toString().contains("INVALID_PASSWORD"))
//        {
//          message='Password is invalid.';
//        }else if(error.toString().contains("USER_DISABLED"))
//        {
//          message='Sorry, your account has been disabled.';
//        }else if(error.toString().contains("EMAIL_EXISTS"))
//        {
//          message='Email already exist, please sign in.';
//        }else if(error.toString().contains("TOO_MANY_ATTEMPTS_TRY_LATER"))
//        {
//          message='Too many attempts , try again later.';
//        }
//
//      }catch(error){
//      }
//      setState(() {
//        _isLoading = false;
//      });
    }

    final deviceSize = MediaQuery.of(context).size;

    OutlineInputBorder myBorder(){
      return OutlineInputBorder(
          borderRadius:  BorderRadius.circular(25.0),
      borderSide:  BorderSide(
      ));
    }

    // TODO: implement build
    return Flexible(
      flex: deviceSize.width>600? 2 :1,
      child: SingleChildScrollView(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
          height:_auth_type == AuthType.SignUp ? 400: 270 ,
          child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      FadeTransition(
                        opacity: _opacity_animation,
                        child: SlideTransition(
                          position:_offset_animation,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear,
                            constraints: BoxConstraints(
                                minHeight: _auth_type == AuthType.SignUp?60:0,
                                maxHeight: _auth_type == AuthType.SignUp?120:0
                            ),

                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'User Name',
                              ),
                              focusNode: userNameFocus,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_email_focus);

                              },

                              validator: (value){
                                return "Please enter the password";

                              },
                              onSaved: (value){
                                if(_auth_type == AuthType.SignUp)
                                  userName = value;

                              },
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email id',
                        ),
                        focusNode: _email_focus,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (_){
                          FocusScope.of(context).requestFocus(_password_focus);
                        },

                        validator: (value){
                          if(value.isEmpty){
                            return "Please enter the Email";
                          }
                          return null;

                        },
                        onSaved: (value){
                          email = value;

                        },

                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                        ),
                        focusNode: _password_focus,
                        textInputAction: TextInputAction.next,
                        controller: _password_controller,
                        obscureText: true,
                        onFieldSubmitted: (_){
                          FocusScope.of(context).requestFocus(_confirm_password_focus);
                        },

                        validator: (value){
                          if(value.isEmpty){
                            return "Please enter the password";
                          }
                          return null;

                        },
                        onSaved: (value){
                          password = value;

                        },
                      ),

                      FadeTransition(
                        opacity: _opacity_animation,
                        child: SlideTransition(
                          position:_offset_animation,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear,
                            constraints: BoxConstraints(
                                minHeight: _auth_type == AuthType.SignUp?60:0,
                                maxHeight: _auth_type == AuthType.SignUp?120:0
                            ),

                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                              ),
                              focusNode: _confirm_password_focus,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              onFieldSubmitted: (_){
                              },

                              validator: (value){
                                if(_auth_type == AuthType.SignUp) {
                                  if (value.isEmpty) {
                                    return "Please enter the password";
                                  } else
                                  if (_password_controller.text != value) {
                                    return "Passwords donot match!";
                                  }
                                  return null;
                                }else{return null;}

                              },
                              onSaved: (value){
                                if(_auth_type == AuthType.SignUp)
                                  password = value;

                              },
                            ),
                          ),
                        ),
                      ),
                      _isLoading? Center(child: CircularProgressIndicator(),): RaisedButton(

                        elevation: 3,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_auth_type == AuthType.SignUp ? "SignUp" : "LogIn",style:TextStyle(color:Colors.white,fontSize: 15),),
                        ),
                        onPressed: (){
                          SaveForm();

                        },


                      ),
                      FlatButton(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_auth_type == AuthType.SignUp ? "LogIn Instead" : "SignUp Instead",style:TextStyle(color:Theme.of(context).primaryColor,fontSize: 15)),
                        ),
                        onPressed: (){

                          if(_auth_type == AuthType.SignUp)
                          {
                            setState(() {
                              _auth_type = AuthType.LogIn;
                              _controller.reverse();

                            });
                          }
                          else{
                            setState(() {
                              _auth_type = AuthType.SignUp;
                              _controller.forward();

                            });
                          }
                        },

                      )
                    ],
                  ),
                ),
              )

          ),
        ),
      ),
    );
  }
}