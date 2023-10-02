import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartcalling/board/church/itemChurch.dart';
import 'package:smartcalling/mypage/pageAdd.dart';

import '../../main.dart';

class pageChurch extends StatefulWidget {
  final bool showPickedOnly;

  const pageChurch({Key? key, this.showPickedOnly = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _pageChurch();
  }
}

class _pageChurch extends State<pageChurch> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('board').snapshots(),
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
                  return ItemChurch(doc: doc);
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0),
                itemCount: snapshot.data!.docs.length
            );
          }
        ),
      ),
    );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:smartcalling/board/church/itemChurch.dart';
// import 'package:smartcalling/board/church/pageAdd.dart';
// import 'package:smartcalling/main.dart';
//
// class pageChurch extends StatefulWidget {
//   final bool showPickedOnly;
//
//   const pageChurch({Key? key, this.showPickedOnly = false})
//       : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _pageChurch();
//   }
// }
//
// class _pageChurch extends State<pageChurch> {
//   late ScrollController _scrollController;
//
//   User? currentUser = FirebaseAuth.instance.currentUser;
//   bool _fabVisible = true;
//   double? _lastScrollOffset;
//
//   List<ItemChurch> _items = [
//     ItemChurch(mType: "예장합동", mLocate: "경기도 수원시", mTitle: "수원삼일교회", mClass_0: true, mClass_1: true, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "예장뭐뭐", mLocate: "경기도 안양시", mTitle: "안양삼일교회", mClass_0: false, mClass_1: true, mClass_2: true, mOver: true, mPick: true, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "뭐뭐합동", mLocate: "경기도 안산시", mTitle: "안산삼일교회", mClass_0: false, mClass_1: false, mClass_2: true, mOver: true, mPick: false, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "예뭐뭐동", mLocate: "경기도 용인시", mTitle: "용인삼일교회", mClass_0: true, mClass_1: false, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "예뭐합뭐", mLocate: "경기도 안성시", mTitle: "안성삼일교회", mClass_0: true, mClass_1: true, mClass_2: false, mOver: true, mPick: false, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "뭐장뭐동", mLocate: "경기도 의정부시", mTitle: "의정부삼일교회", mClass_0: true, mClass_1: false, mClass_2: false, mPick: false, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "뭐장합뭐", mLocate: "경기도 성남시", mTitle: "성남삼일교회", mClass_0: true, mClass_1: true, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//   }
//
//   void _scrollListener() {
//     double currentScrollOffset = _scrollController.position.pixels;
//     if (_lastScrollOffset != null &&
//         currentScrollOffset < _lastScrollOffset!) {
//       setState(() {
//         _fabVisible = true;
//       });
//     } else if (_lastScrollOffset != null &&
//         currentScrollOffset > _lastScrollOffset!) {
//       setState(() {
//         _fabVisible = false;
//       });
//     }
//     _lastScrollOffset = currentScrollOffset;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<ItemChurch> filteredItems = widget.showPickedOnly
//         ? _items.where((item) => item.mPick).toList()
//         : _items;
//     return Scaffold(
//       backgroundColor: Color(0xfff5f5f5),
//       body: SafeArea(
//         child: GestureDetector(
//           onVerticalDragUpdate: (details) {
//             _scrollListener();
//           },
//           child: ListView(
//             controller: _scrollController,
//             children: filteredItems,
//           ),
//         ),
//       ),
//       floatingActionButton: AnimatedOpacity(
//         opacity: _fabVisible ? 1.0 : 0.0,
//         duration: Duration(milliseconds: 300),
//         child: FloatingActionButton(
//           backgroundColor: customGreenAccent,
//           onPressed: _fabVisible
//               ? () async {
//             final data = await FirebaseFirestore.instance
//                 .collection('resume')
//                 .doc(currentUser!.uid)
//                 .collection("career")
//                 .where("status", isEqualTo: true)
//                 .get();
//             if(data.size > 0) {
//               final result = await Navigator.push(
//                 context,
//                 PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) =>
//                       pageAdd(data: data.docs[0].data()),
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) {
//                     var begin = Offset(0.0, 1.0);
//                     var end = Offset.zero;
//                     var curve = Curves.ease;
//
//                     var tween = Tween(begin: begin, end: end)
//                         .chain(CurveTween(curve: curve));
//
//                     return SlideTransition(
//                       position: animation.drive(tween),
//                       child: child,
//                     );
//                   },
//                   transitionDuration: Duration(milliseconds: 500),
//                 ),
//               );
//             }
//             else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("사역지가 없습니다.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
//                   backgroundColor: Colors.redAccent,
//                   duration: Duration(seconds: 3),
//                 ),
//               );
//             }
//           }
//               : null,
//           child: Icon(Icons.add, color: Colors.white,),
//         ),
//       ),
//     );
//   }
// }
