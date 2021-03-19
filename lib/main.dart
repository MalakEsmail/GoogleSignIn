import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('GoogleSignIn'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await signInWithGoogle();
                },
                child: Text('SignIn With Google')),
            SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
                onPressed: () async {
                  await signOut();
                },
                child: Text('Sign Out'))
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _gooleSignInAuth =
        await _googleSignInAccount.authentication;
    AuthCredential _authCredential = GoogleAuthProvider.credential(
        idToken: _gooleSignInAuth.idToken,
        accessToken: _gooleSignInAuth.accessToken);
    UserCredential authResultOrUserCredential =
        await _auth.signInWithCredential(_authCredential);
    User user = authResultOrUserCredential.user;

    print('email 2 : ${user.email}');
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    print('signOut');
  }
}
