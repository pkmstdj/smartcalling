import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartcalling/board/church/itemChurch.dart';
import 'package:smartcalling/mypage/itemMyBoard.dart';
import 'package:smartcalling/mypage/pageAdd.dart';

import '../../main.dart';

class pageMyBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageMyBoard();
  }
}

class _pageMyBoard extends State<pageMyBoard> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Text(
            "내 청빙공고",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: customGreenAccent,
            ),
            maxLines: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: customGreenAccent,
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: customGreenAccent,
            onPressed: () async {
              final data = await FirebaseFirestore.instance
                  .collection('resume')
                  .doc(currentUser!.uid)
                  .collection("career")
                  .where("status", isEqualTo: true)
                  .get();
              if (data.size > 0) {
                final result = await Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        pageAdd(data: data.docs[0].data()),
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
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("사역지가 없습니다.", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            }
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('board').where('uid', isEqualTo: currentUser?.uid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    var doc = snapshot.data!.docs[index];
                    // return ItemChurch(doc: doc);
                    return itemMyBoard(doc: doc);
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0,),
                  itemCount: snapshot.data!.docs.length
              );
            }
        ),
      ),
    );
  }
}