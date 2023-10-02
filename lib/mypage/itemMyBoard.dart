
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/main.dart';
import 'package:smartcalling/mypage/pageApplicantList.dart';

import '../firebase_options.dart';

class itemMyBoard extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final QueryDocumentSnapshot<Object?> doc;
  late String address;
  late String name;
  late String platform;
  late String time;
  late String limit;
  late List<String> position;
  late bool open;


  itemMyBoard({super.key, required this.doc}) {
    address = "${doc['address_sido']} ${doc['address_sigungu']}";
    name = doc['name'];
    platform = doc['platform'];
    position = List<String>.from(doc['position']);
    time = DateFormat('yyyy-MM-dd').format(TimestempToDate(doc['time']));
    limit = DateFormat('yyyy-MM-dd').format(TimestempToDate(doc['limit']));
    open = doc['open'];
  }


  @override
  _itemMyBoard createState() => _itemMyBoard();
}

class _itemMyBoard extends State<itemMyBoard> {
  bool isExpanded = false;
  int count = 0;
  Future<void> getApplicant() async {
    final applicant = await widget._firestore.collection('applicant').where('board', isEqualTo: widget.doc.id).get();
    setState(() {
      count = applicant.size;
    });
  }
  @override
  Widget build(BuildContext context) {
    getApplicant();
    return
    ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text( widget.name,
              style: TextStyle( color: widget.open ? Colors.black : Colors.grey, fontSize: 20, letterSpacing: 0.3, overflow: TextOverflow.clip),
            )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 4,),
              Text( '등록(수정)일:  ${widget.time}', style: TextStyle(color: Colors.grey, fontSize: 17), ),
              SizedBox(height: 4,),
              Text( '마감일: ${widget.limit}', style: TextStyle(color: Colors.grey, fontSize: 17), ),
              SizedBox(height: 10,),
            ],
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text( '지원자 : ${count} 명',
            style: TextStyle( color: Colors.grey, fontSize: 17),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(8, 0, 0, 3),
            padding: EdgeInsets.fromLTRB(8, 2, 8, 4),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.2,
                color: (widget.open) ? Colors.blueAccent : Colors.red,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              (widget.open) ? '모집중' : '마감',
              style: TextStyle(
                color: (widget.open) ? Colors.blueAccent : Colors.red,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      onTap: () async {
        // print(widget.doc.id);

        final result = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                pageApplicantList(doc: widget.doc),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      },
    );
  }
}