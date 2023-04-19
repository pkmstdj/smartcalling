import 'package:flutter/material.dart';

class pageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageHome();
  }
}
class _pageHome extends State<pageHome> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Text('Page Home'),
      )
    );
  }
}