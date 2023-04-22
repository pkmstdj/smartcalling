import 'package:flutter/material.dart';
import 'package:smartcalling/board/people/pagePeopleInfo.dart';

import '../../main.dart';

class itemPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => pagePeopleInfo(),
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(9, 1, 9, 1),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: GestureDetector(
              onTap: (){},
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('목사 ', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),),
                                  Text('5년', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              alignment: Alignment.centerLeft,
                              child: Text('예장합동 ', style: TextStyle(color: Colors.blue, fontSize: 18,),),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text('경기도 수원시 ', style: TextStyle(color: Colors.grey, fontSize: 16,),),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.star_outline_rounded, size: 40, color: customGreenAccent),
                    ],
                  )
              )
          ),
        ),
      ),
    );
  }
}