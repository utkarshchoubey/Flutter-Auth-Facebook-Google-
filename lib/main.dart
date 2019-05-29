import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'profile_screen.dart';
import 'emailAuth/pages/root_page.dart';
import 'emailAuth/services/authentication.dart';
//import 'googledemo.dart';
//import 'landing_page.dart';
//import 'quiz_page.dart';
//import 'score_page.dart';
//import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(new MaterialApp(
    home: new RootPage(auth: new Auth()),
  ));
}
//Email Auth -  RootPage(auth: new Auth())
//Facebook Auth - MyMainPage()
//Google Auth - GoogleSignApp()
//Quiz App - LandingPage()

class GoogleSignApp extends StatefulWidget {
  @override
  _GoogleSignAppState createState() => _GoogleSignAppState();
}

class MyMainPage extends StatefulWidget {
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyMainPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged = false;
  FirebaseUser myUser;

  //Facebook Auth
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogged ? "Profile Page" : "Facebook login Example"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              _LogOut();
            },
          )
        ],
      ),
      body: Center(
        child: isLogged
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Name :" + myUser.displayName),
                  Image.network(myUser.photoUrl),
                ],
              )
            : FacebookSignInButton(onPressed: _LogIn),
      ),
    );
  }

  void _LogIn() {
    _loginWithFacebook().then((response) {
      if (response != null) {
        myUser = response;
        isLogged = true;
        setState(() {});
      }
    });
  }

  Future<FirebaseUser> _loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(["email"]);
    debugPrint(result.status.toString());

    if (result.status == FacebookLoginStatus.loggedIn) {
      AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token);
      FirebaseUser firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return firebaseUser;
    }
    return null;
  }

  void _LogOut() async {
    await _auth.signOut().then((response) {
      isLogged = false;
      setState(() {});
    });
  }
}

class ProviderDetails {
  final String providerDetails;
  ProviderDetails(this.providerDetails);
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class _GoogleSignAppState extends State<GoogleSignApp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
          builder: (context) => Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.network(
                      "https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      fit: BoxFit.fill,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 250.0,
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Color(0xffffff),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Sign in with Google",
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                )
                              ],
                            ),
                            onPressed: () {
                              _signIn(context)
                                  .then((FirebaseUser user) => print(user))
                                  .catchError((e) => print(e));
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
    );
  }

  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text("Sign In")));

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credentials = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    FirebaseUser userDetails =
        await _firebaseAuth.signInWithCredential(credentials);
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);
    UserDetails details = new UserDetails(
        userDetails.providerId,
        userDetails.displayName,
        userDetails.photoUrl,
        userDetails.email,
        providerData);

    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new ProfileScreen(detailsUser: details)),
    );
    return userDetails;
  }
}
