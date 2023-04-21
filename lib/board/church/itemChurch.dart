import 'package:flutter/material.dart';
import 'package:smartcalling/board/church/pageChurchInfo.dart';

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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => pageChurchInfo()));
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
                        Icon(Icons.star_rounded, size: 40, color: Colors.greenAccent),
                      ]
                      else... [
                        Icon(Icons.star_outline_rounded, size: 40, color: Colors.greenAccent),
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
                        Icon(Icons.star_rounded, size: 40, color: Colors.greenAccent.shade100,),
                      ]
                      else... [
                        Icon(Icons.star_outline_rounded, size: 40, color: Colors.greenAccent.shade100),
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