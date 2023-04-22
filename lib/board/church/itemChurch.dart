import 'package:flutter/material.dart';
import '../../main.dart';
import 'pageChurchInfo.dart';

class itemChurch extends StatelessWidget {
  const itemChurch({
    Key? key,
    required this.mType,
    required this.mLocate,
    required this.mTitle,
    required this.mClass_0,
    required this.mClass_1,
    required this.mClass_2,
    this.mOver = false,
    required this.mPick,
  }) : super(key: key);
  final String mType;
  final String mLocate;
  final String mTitle;
  final bool mClass_0;
  final bool mClass_1;
  final bool mClass_2;
  final bool mOver;
  final bool mPick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => PageChurchInfo(),
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
        child: mOver ?
        Card(
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
                                  Text(mType + ' ', style: TextStyle(color: Colors.blue, fontSize: 18,),),
                                  Container(
                                    width: 1.2,
                                    height: 20,
                                    color: Colors.blue,
                                    margin: EdgeInsets.fromLTRB(1, 0, 5, 0),
                                  ),
                                  Text(mLocate + ' ', style: TextStyle(color: Colors.blue, fontSize: 18,),),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              alignment: Alignment.centerLeft,
                              child: Text(mTitle, style: TextStyle(color: Colors.black, fontSize: 22, letterSpacing: 0.2),),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    if(mClass_0)...[Text('목사 ', style: TextStyle(color: Colors.grey, fontSize: 16,),),],
                                    if(mClass_1)...[Text('강도사 ', style: TextStyle(color: Colors.grey, fontSize: 16,),),],
                                    if(mClass_2)...[Text('전도사 ', style: TextStyle(color: Colors.grey, fontSize: 16,),),],
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      if(mPick)...[
                        Icon(Icons.star_rounded, size: 40, color: customGreenAccent),
                      ]
                      else... [
                        Icon(Icons.star_outline_rounded, size: 40, color: customGreenAccent),
                      ]
                    ],
                  )
              )
          ),
        ) :
        Card(
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
                                  Text(mType + ' ', style: TextStyle(color: Colors.blue.shade100, fontSize: 18,),),
                                  Container(
                                    width: 1.2,
                                    height: 20,
                                    color: Colors.blue.shade100,
                                    margin: EdgeInsets.fromLTRB(1, 0, 5, 0),
                                  ),
                                  Text(mLocate + ' ', style: TextStyle(color: Colors.blue.shade100, fontSize: 18,),),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.2,
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Text('완료', style: TextStyle(color: Colors.red, fontSize: 15),),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              alignment: Alignment.centerLeft,
                              child: Text(mTitle, style: TextStyle(color: Colors.grey, fontSize: 22, letterSpacing: 0.5),),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    if(mClass_0)...[Text('목사 ', style: TextStyle(color: Colors.grey.shade300, fontSize: 16,),),],
                                    if(mClass_1)...[Text('강도사 ', style: TextStyle(color: Colors.grey.shade300, fontSize: 16,),),],
                                    if(mClass_2)...[Text('전도사 ', style: TextStyle(color: Colors.grey.shade300, fontSize: 16,),),],
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      if(mPick)...[
                        Icon(Icons.star_rounded, size: 40, color: customGreenAccent.shade50,),
                      ]
                      else... [
                        Icon(Icons.star_outline_rounded, size: 40, color: customGreenAccent.shade100),
                      ]
                    ],
                  )
              )
          ),
        ),
      ),
    );

  }
}