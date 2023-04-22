import 'package:flutter/material.dart';
import '../main.dart';
import 'pageSetting.dart';

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
            child: Text("마이 페이지", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              color: customGreenAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => PageSetting(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(0.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("박범순", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: customGreenAccent
                  ),
                  child:
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 25),
                    child: Text("이력서 공개", style: TextStyle(fontSize: 18, color: Colors.white),),
                  ),
                )
              ],
            ),
            Divider(),
            ListTile(
              title: Text("이력서 관리하기", style: TextStyle(fontSize: 18, color: Colors.black)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){},
            ),
            Divider(),
            ListTile(
              title: Text("청빙공고 관리하기", style: TextStyle(fontSize: 18, color: Colors.black)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){},
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}