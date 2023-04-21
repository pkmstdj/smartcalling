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
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title:
          PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Text("마이 페이지", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.greenAccent), maxLines: 1,),
          ),
        ),
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Text('Page MyPage'),
      )
    );
  }
}