import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/board/people/pagePeopleInfo.dart';
import 'package:smartcalling/mypage/pageApplicantPeopleInfo.dart';

import '../../firebase_options.dart';
import '../../main.dart';

class itemApplicantPeople extends StatefulWidget {
  final DocumentSnapshot<Object?> doc;
  late Map<String, List<String>> cities;

  bool mPick = false;

  itemApplicantPeople({super.key, required this.doc}) {
    var citiesData = doc['cities'];
    if (citiesData is Map<String, dynamic>) {
      cities = citiesData.map((key, value) => MapEntry(key, List<String>.from(value)));
    } else {
      // Handle the case where citiesData is not of the expected type
    }
  }

  @override
  _ItemApplicantPeopleState createState() => _ItemApplicantPeopleState();
}
class _ItemApplicantPeopleState extends State<itemApplicantPeople> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final User? currentUser = FirebaseAuth.instance.currentUser;
        final dataEdu = await FirebaseFirestore.instance
            .collection('resume')
            .doc(widget.doc.id)
            .collection('education')
            .get();
        List<Map<String, dynamic>> eduDataList = [];
        for (var doc in dataEdu.docs) {
          eduDataList.add(doc.data());
        }
        final dataCareer = await FirebaseFirestore.instance
            .collection('resume')
            .doc(widget.doc.id)
            .collection('career')
            .get();
        List<Map<String, dynamic>> careerDataList = [];
        for (var doc in dataCareer.docs) {
          careerDataList.add(doc.data());
        }

        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => pageApplicantPeopleInfo(doc: widget.doc, education: eduDataList, career: careerDataList),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      },
      title: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${widget.doc['position']} ',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                if(widget.doc['position'] == '목사')...[
                  Text(
                    '${DateFormat('y년 M개월').format( subDate(DateTime.now(), getDate(widget.doc['position2'])))}',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ]
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
            alignment: Alignment.centerLeft,
            child: Text('${widget.doc['platform']} ', style: TextStyle(color: customGreenAccent, fontSize: 18,),),
          ),
        ],
      ),
      subtitle: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Flexible(
                child: Text(generateSelectedCitiesText(widget.cities), style: TextStyle(color: Colors.grey, fontSize: 16,),),
              ),
            ],
          )
      ),
      trailing: null,
    );
  }
}