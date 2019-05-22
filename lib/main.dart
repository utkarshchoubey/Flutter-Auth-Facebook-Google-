import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'quiz_page.dart';
import 'score_page.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main(){
  runApp(new MaterialApp(
    home: new MyMainPage(),
  ));
}

class MyMainPage extends StatefulWidget{
  @override
  MyPageState createState()=> MyPageState();
}
class MyPageState extends State<MyMainPage>{
  FirebaseAuth _auth=FirebaseAuth.instance;
  bool isLogged =false;
  FirebaseUser myUser;

  Future<FirebaseUser> _loginWithFacebook() async{
    var facebookLogin= new FacebookLogin();
    var result= await facebookLogin.logInWithReadPermissions(["email"]);
    debugPrint(result.status.toString());


    if(result.status==FacebookLoginStatus.loggedIn) {
      AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token);
      FirebaseUser firebaseUser = await FirebaseAuth.instance
          .signInWithCredential(credential);
      return firebaseUser;
    }
  return null;
  }

    void _LogIn(){
      _loginWithFacebook().then((response) {
        if(response!=null){
          myUser=response;
          isLogged=true;
          setState(() {

          });
        }
      });
    }

    void _LogOut() async{
      await _auth.signOut().then((response){
        isLogged=false;
        setState(() {

        });
      });
    }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar:
        AppBar(title: Text(isLogged ? "Profile Page":"Facebook login Example"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: (){
              _LogOut();
            },
          )
        ],
        ),
      body:Center(
        child: isLogged ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Name :"+ myUser.displayName),
            Image.network(myUser.photoUrl),
          ],
        ) : FacebookSignInButton(onPressed: _LogIn),
      ),
    );
  }
}