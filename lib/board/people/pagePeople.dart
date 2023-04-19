import 'package:flutter/material.dart';
import 'package:smartcalling/board/people/itemPeople.dart';

class pagePeople extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pagePeople();
  }
}
class _pagePeople extends State<pagePeople> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: ListView(
          children: [
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
            itemPeople(),
          ],
        ),
      )
    );
  }
}