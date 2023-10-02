import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartcalling/mainLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartcalling/mypage/pageMyPage.dart';

import '../main.dart';
import '../mainHome.dart';

class PageSetting extends ConsumerStatefulWidget {
  @override
  _PageSettingState createState() => _PageSettingState();
}

class _PageSettingState extends ConsumerState<PageSetting> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            final isOpen = ref.read(myOpenProvider);
            FirebaseFirestore.instance
                .collection('resume')
                .doc(currentUser!.uid)
                .update({'open': isOpen});
            Navigator.pop(context);
          },
          color: customGreenAccent,
          icon: Icon(Icons.arrow_back),
        ),
        title: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Text(
            "설정",
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: customGreenAccent),
            maxLines: 1,
          ),
        ),
      ),
      backgroundColor: Color(0xfff5f5f5),
      body: WillPopScope(
        onWillPop: () async {
          final isOpen = ref.read(myOpenProvider);
          await FirebaseFirestore.instance
              .collection('resume')
              .doc(currentUser!.uid)
              .update({'open': isOpen});
          return true;
        },
        child: SafeArea(
          child: MyPageWidget(),
        ),
      ),
    );
  }
}



class MyPageWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    // TODO: implement build
    // throw UnimplementedError();
    return Consumer(builder: (context, watch, child) {
      final isOpen = ref.watch(myOpenProvider);
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 30, right: 30, top: 16, bottom: 16),
            child: Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  "이력서 공개여부",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(myOpenProvider.notifier).set(true);
                    },
                    child: Container(
                      width: 200,
                      height: 55,
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isOpen
                            ? customGreenAccent
                            : Colors.grey.shade200,
                      ),
                      child: Text(
                        "공개",
                        style: TextStyle(
                          fontSize: 22,
                          color:
                          isOpen ? Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(myOpenProvider.notifier).set(false);
                    },
                    child: Container(
                      width: 200,
                      height: 55,
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: !isOpen
                            ? customGreenAccent
                            : Colors.grey.shade200,
                      ),
                      child: Text(
                        "비공개",
                        style: TextStyle(
                          fontSize: 22,
                          color:
                          !isOpen ? Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.maxFinite,
              child: MaterialButton(
                onPressed: () async {
                  // auth.re;
                  await auth.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                },
                color: customGreenAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text('로그아웃',
                      style: TextStyle(fontSize: 19, color: Colors.white)),
                ),
              ),
            ),
          ),
          // buildLogoutButton(),
        ],
      );
    });
  }
}
