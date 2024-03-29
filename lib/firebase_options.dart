// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA_k0sZKGSdWmSkS8K6aVpOguwMKSzzDmI',
    appId: '1:449915173434:web:9976f735e21bd1f8e2d303',
    messagingSenderId: '449915173434',
    projectId: 'smart-calling-adad0',
    authDomain: 'smart-calling-adad0.firebaseapp.com',
    databaseURL: 'https://smart-calling-adad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'smart-calling-adad0.appspot.com',
    measurementId: 'G-VF4VNXV7NE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYNzoiWkeC8kh8P5Y7Ngt4jXyq_KeFGsQ',
    appId: '1:449915173434:android:42a235128cce5231e2d303',
    messagingSenderId: '449915173434',
    projectId: 'smart-calling-adad0',
    databaseURL: 'https://smart-calling-adad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'smart-calling-adad0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDINlEV3yMy1yQI1Lz7AidzDne_1ja_tzQ',
    appId: '1:449915173434:ios:b105a4eb21faba2ee2d303',
    messagingSenderId: '449915173434',
    projectId: 'smart-calling-adad0',
    databaseURL: 'https://smart-calling-adad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'smart-calling-adad0.appspot.com',
    iosClientId: '449915173434-3ef5sl6ak9k5gdec5h9s6ob86rafsoot.apps.googleusercontent.com',
    iosBundleId: 'com.mnb.smartcalling.smartcalling',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDINlEV3yMy1yQI1Lz7AidzDne_1ja_tzQ',
    appId: '1:449915173434:ios:b105a4eb21faba2ee2d303',
    messagingSenderId: '449915173434',
    projectId: 'smart-calling-adad0',
    databaseURL: 'https://smart-calling-adad0-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'smart-calling-adad0.appspot.com',
    iosClientId: '449915173434-3ef5sl6ak9k5gdec5h9s6ob86rafsoot.apps.googleusercontent.com',
    iosBundleId: 'com.mnb.smartcalling.smartcalling',
  );
}
const List<String> PLATFORMLIST = ["예장합동", "예장통합", "예장고신", "예장대신", "예장백석", "초교파", "기장", "기감", "예감", "기성", "예성", "기침", "기하성", "기타"];
const List<String> POSITIONLIST = ["전도사", "강도사", "목사"];
const List<String> STATUSLIST = ["졸업", "수료", "휴학", "중퇴", "재학"];
const List<String> SEXLIST = ["남자", "여자"];
const List<String> MARRIAGELIST = ["미혼", "기혼"];
const List<String> MILITARYLIST = ["해당없음", "군필", "미필", "복무중"];
const List<String> WORKLIST = ["예배", "교구", "행정", "심방", "영아", "유아", "유치", "유등", "초등", "중등", "고등", "청년", "미디어", "기타"];
const List<String> PARTIST = ["전임", "준전임", "파트"];

bool getEduStatus(String str) {
  bool result = true;
  switch(str) {
    case "졸업":
    case "수료":
    case "중퇴":
      result = false;
  }
  return result;
}

DateTime TimestempToDate(Timestamp ts) {
  return ts.toDate();
}
DateTime getDate(String v) {
  DateTime dt = DateTime.parse(v);
  return dt;
}
DateTime subDate(DateTime a, DateTime b) {
  final period = a.difference(b);
  return DateTime((period.inDays ~/ 30) ~/ 12, (period.inDays ~/ 30) % 12, period.inDays % 30);
}
String generateSelectedCitiesText(Map<String, List<String>> cities) {
  List<String> cityTexts = [];
  cities.forEach((province, cities) {
    String citiesJoined = cities.join(', ');
    if(cities.isNotEmpty) {
      cityTexts.add('$province: $citiesJoined');
    }
  });
  return cityTexts.join(' / ');
}