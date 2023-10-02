import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../main.dart';
import 'itemApplicantPeople.dart';

class pageApplicantList extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> doc;
  pageApplicantList({super.key, required this.doc}) {}

  @override
  State<StatefulWidget> createState() {
    return _pageApplicantList();
  }
}

class _pageApplicantList extends State<pageApplicantList> {
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
            "청빙공고 관리",
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
              icon: Icon(Icons.remove_red_eye),
              color: customGreenAccent,
              onPressed: () async {
                // final result = await Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) =>
                //         pageAdd(data: data.docs[0].data()),
                //     transitionsBuilder:
                //         (context, animation, secondaryAnimation, child) {
                //       var begin = Offset(0.0, 1.0);
                //       var end = Offset.zero;
                //       var curve = Curves.ease;
                //
                //       var tween = Tween(begin: begin, end: end)
                //           .chain(CurveTween(curve: curve));
                //
                //       return SlideTransition(
                //         position: animation.drive(tween),
                //         child: child,
                //       );
                //     },
                //     transitionDuration: Duration(milliseconds: 500),
                //   ),
                // );
              }
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('applicant').where('board', isEqualTo: widget.doc.id).snapshots(),
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
                    // return Text(doc['uid']);
                    return FutureBuilder<DocumentSnapshot>(
                      future: _firestore.collection('resume').doc(doc['uid']).get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error occurred');
                        }

                        if (snapshot.data!.exists) {
                          // return Text(snapshot.data!.get('name'));
                          return itemApplicantPeople(doc: snapshot.data!);
                        } else {
                          return Text('No data');
                        }
                      },
                    );
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