import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';
import 'mainHome.dart';

class MyLoginPage extends ConsumerStatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends ConsumerState<MyLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late GoogleSignIn googleSignIn;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _checkUserLoggedIn();
    });
  }

  void _checkUserLoggedIn() async {
    // Check if user is already logged in.
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Get the user data from Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      DocumentSnapshot docSnapshot = await users.doc(currentUser.email).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('ban') && data['ban'] == true) {
          print('User is banned');
          // Log out the user
          await _auth.signOut();
        } else {
          LoginSuccess(false, currentUser);
        }
      } else {
        print('No user data found in Firestore');
        // Handle this case as needed
      }
    }
  }

  Future<String?> signInWithGoogle() async {
    // await Firebase.initializeApp();
    if(kIsWeb) {
      googleSignIn = GoogleSignIn(
          scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ],
          clientId: '449915173434-lba59upj0q0vo3jdfmi5trvuu4nmtaf8.apps.googleusercontent.com'
      );
    }
    else {
      if(Platform.isAndroid) {
        googleSignIn = GoogleSignIn(
          scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ],);
      }
      else if(Platform.isIOS) {

        googleSignIn = GoogleSignIn(
          scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ],);

      }
      else {
      }
    }
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return null;
    }
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);

      print('signInWithGoogle succeeded: $user');

      // Here we will add the user data to Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Check if user is banned
      DocumentSnapshot docSnapshot = await users.doc(user.email).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('ban') && data['ban'] == true) {
          print('User is banned');
          return null; // User is banned, do not log them in
        }
        else {
          LoginSuccess(false, user);
        }
      } else {
        LoginSuccess(true, user);
      }


      return '$user';
    }

    return null;
  }

  void LoginSuccess(bool first, User user) {

    if(first) {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      // If user does not exist, add them to Firestore
      FirebaseFirestore.instance.collection("users").doc(user.email).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'ban': false,
        // Add other properties you need
      });

      FirebaseFirestore.instance.collection("users").doc(user.email).collection("profile").doc("options").set({
        'open': false,
        'take_resume': [],
        'send_resume': [],
      });
      FirebaseFirestore.instance.collection("resume").doc(user.uid).set({
        'name': user.displayName,
        'open': false,
        'vision': '',
        'birth': date,
        'platform': '예장합동',
        'position': '전도사',
        'position1': date,
        'position2': date,
        'cities': {},
        'sex': '남자',
        'marriage': '미혼',
        'military': '해당없음',
        'etc': ''
      });
    }

    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          child: Text('Sign in with Google'),
          onPressed: () {
            signInWithGoogle();
          },
        ),
      ),
    );
  }
}

// final currentUserProvider = StateNotifierProvider<currentUserNotifier, User>((ref) {
//   var notifier = currentUserNotifier();
//   return notifier;
// });
