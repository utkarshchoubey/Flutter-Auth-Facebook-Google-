import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final UserDetails detailsUser;

  ProfileScreen({Key key, @required this.detailsUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn = GoogleSignIn();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(detailsUser.userName),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
            ),
            onPressed: () {
              _gSignIn.signOut();
              print("Signed Out");
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(detailsUser.photoUrl),
              radius: 50.0,
            ),
            SizedBox(height: 10.0),
            Text("Name :" + detailsUser.userName,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0)),
            Text("Email :" + detailsUser.userEmail,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0)),
            Text("Provider :" + detailsUser.providerDetails,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
