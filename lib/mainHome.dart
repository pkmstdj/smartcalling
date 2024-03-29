import 'package:flutter/material.dart';
import 'package:smartcalling/board/pageBoard.dart';
import 'package:smartcalling/chat/pageChat.dart';
import 'package:smartcalling/custom_animated_bottom_bar.dart';
import 'package:smartcalling/home/pageHome.dart';
import 'package:smartcalling/mypage/pageMyPage.dart';

import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;

  List<Widget> tabPages = List.empty(growable: true);
  DateTime? _currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 55,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home_filled),
          title: Text('홈'),
          activeColor: customGreenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.paste),
          title: Text('청빙 공고'),
          activeColor: customGreenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.message_rounded),
          title: Text('채팅'),
          activeColor: customGreenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.menu),
          title: Text('마이 페이지'),
          activeColor: customGreenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  Widget getBody() {
    List<Widget> pages = [
      pageHome(),
      pageBoard(),
      pageChat(),
      pageMyPage(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
