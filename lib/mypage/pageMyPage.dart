import 'package:flutter/material.dart';

class pageMyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageMyPage();
  }
}
class _pageMyPage extends State<pageMyPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Text('Page MyPage'),
      )
    );
  }
}