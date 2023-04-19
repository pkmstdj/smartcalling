import 'package:flutter/material.dart';
import 'package:smartcalling/itemCheckBoxText.dart';

class pagePeopleInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pagePeopleInfo();
  }
}
class _pagePeopleInfo extends State<pagePeopleInfo> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green.shade400,
        title: Container(child: Text('사역자 이력서', style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 0.3), ), alignment: Alignment.center,),
        actions: [
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: SizedBox(
              width: 50,
              child: MaterialButton(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                onPressed: () {},
                child: Icon(Icons.star_outline_rounded, color: Colors.green.shade400, size: 36,),
              )
            )
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child:
                          Icon(Icons.account_box_rounded, size: 150, color: Colors.white,)
                      ),
                      Container(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('OOO', style: TextStyle(color: Colors.black, fontSize: 21,),),
                          Container(height: 10,),
                          Text('강도사', style: TextStyle(fontSize: 19,),),
                          Text('3년', style: TextStyle(fontSize: 19,),),
                        ]
                      ),
                    ],
                  ),
                  Container(height: 30,),
                  Container(height: 1.3, width: double.infinity, color: Colors.grey.shade400,),
                  Container(height: 30,),
                  // Containesx(
                  //   width: double.maxFinite,
                  //   child: MaterialButton(
                  //     onPressed: () {},
                  //     color: Colors.green.shade400,
                  //     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(7.0)),
                  //     child: Container(
                  //       padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  //       child: Text('채팅하기', style: TextStyle(fontSize: 19, color: Colors.white),),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
        )
      )
    );
  }
}