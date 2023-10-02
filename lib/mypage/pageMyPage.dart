import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcalling/mypage/pageMyBoard.dart';
import 'package:smartcalling/mypage/pageResume.dart';
import '../main.dart';
import 'pageSetting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class pageMyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageMyPage();
  }
}

class _pageMyPage extends State<pageMyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Text(
            "마이 페이지",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: customGreenAccent,
            ),
            maxLines: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: customGreenAccent,
            onPressed: () async {
              final result = await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      PageSetting(),
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
          ),
        ],
      ),
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: MyPageWidget(),
      ),
    );
  }
}

class MyOpenNotifier extends StateNotifier<bool> {
  MyOpenNotifier() : super(false);

  void set(bool value) {
    state = value;
  }

  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final data = await FirebaseFirestore.instance
        .collection('resume')
        .doc(currentUser!.uid)
        .get();

    if (data.exists) {
      set(data.data()?['open'] ?? false);
    }
  }
}
final myOpenProvider = StateNotifierProvider<MyOpenNotifier, bool>((ref) {
  var notifier = MyOpenNotifier();
  notifier.fetchData();
  return notifier;
});

class MyNameNotifier extends StateNotifier<String> {
  MyNameNotifier() : super("이름");

  void set(String str) {
    state = str;
  }

  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final data = await FirebaseFirestore.instance
        .collection('resume')
        .doc(currentUser!.uid)
        .get();

    if (data.exists) {
      set(data.data()?['name'] ?? "이름");
    }
  }
}
final myNameProvider = StateNotifierProvider<MyNameNotifier, String>((ref) {
  var notifier = MyNameNotifier();
  notifier.fetchData();
  return notifier;
});

class MyPageWidget extends ConsumerWidget {
  MyPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer(builder: (context, watch, child) {
              final myName = ref.watch(myNameProvider);
              return Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    myName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ));
            }),
            Consumer(builder: (context, watch, child) {
              final myOpen = ref.watch(myOpenProvider);
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: myOpen ? customGreenAccent : Colors.black38),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 25),
                  child: Text(
                    myOpen ? "이력서 공개" : "이력서 비공개",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            }),
          ],
        ),
        Divider(),
        ListTile(
          title: Text("내 이력서",
              style: TextStyle(fontSize: 18, color: Colors.black)),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PageResume(),
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
        ),
        Divider(),
        ListTile(
          title: Text("내 지원내역",
              style: TextStyle(fontSize: 18, color: Colors.black)),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         pageMyBoard(),
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
          },
        ),
        Divider(),
        ListTile(
          title: Text("내 청빙공고",
              style: TextStyle(fontSize: 18, color: Colors.black)),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    pageMyBoard(),
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
        ),
        Divider(),
      ],
    );
  }
}
