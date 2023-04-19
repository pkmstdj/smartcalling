import 'package:flutter/material.dart';
import 'package:smartcalling/itemCheckBoxText.dart';

class pageChurchInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageChurchInfo();
  }
}
class _pageChurchInfo extends State<pageChurchInfo> {
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
        title: Container(child: Text('수원삼일교회', style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 0.3), ), alignment: Alignment.center,),
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
                  Text('예장합동 ', style: TextStyle(color: Colors.blue, fontSize: 21,),),
                  Container(height: 10,),
                  Text('경기도 수원시 영통구 삼성로267번길 2', style: TextStyle(fontSize: 19,),),
                  Text('수원삼일교회 건물', style: TextStyle(fontSize: 19,),),
                  Container(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('등록날짜 2023.02.28', style: TextStyle(color: Colors.grey, fontSize: 17,),),
                      Text('마감날짜 2023.02.28', style: TextStyle(color: Colors.grey, fontSize: 17,),),
                    ],
                  ),
                  Container(height: 30,),
                  Container(height: 1.3, width: double.infinity, color: Colors.grey.shade400,),
                  Container(height: 30,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 60, padding: EdgeInsets.fromLTRB(0, 4, 0, 0), child: Text('분야', style: TextStyle(fontSize: 19, color: Colors.grey),),),
                      Container(width: 10,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                itemCheckBoxText(width:110, text: Text("청년부", style: TextStyle(fontSize: 18),), value: true, onChanged: null),
                                itemCheckBoxText(width:110, text: Text("청소년부", style: TextStyle(fontSize: 18),), value: true, onChanged: null),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                itemCheckBoxText(width:110, text: Text("방송", style: TextStyle(fontSize: 18),), value: false, onChanged: null),
                                itemCheckBoxText(width:110, text: Text("뭐그런", style: TextStyle(fontSize: 18),), value: false, onChanged: null),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                itemCheckBoxText(width:110, text: Text("여러가지", style: TextStyle(fontSize: 18),), value: false, onChanged: null),
                                itemCheckBoxText(width:110, text: Text("부서들", style: TextStyle(fontSize: 18),), value: false, onChanged: null),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(height: 30,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 60, padding: EdgeInsets.fromLTRB(0, 4, 0, 0), child: Text('파트', style: TextStyle(fontSize: 19, color: Colors.grey),),),
                      Container(width: 10,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                itemCheckBoxText(width:110, text: Text("풀타임", style: TextStyle(fontSize: 18),), value: false, onChanged: null),
                                itemCheckBoxText(width:110, text: Text("파트타임", style: TextStyle(fontSize: 18),), value: true, onChanged: null),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(height: 30,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 60, child: Text('사례금', style: TextStyle(fontSize: 19, color: Colors.grey),),),
                      Container(width: 15,),
                      Container(child: Text('3,500,000', style: TextStyle(fontSize: 19,),),),
                    ],
                  ),
                  Container(height: 30,),
                  Container(height: 1.3, width: double.infinity, color: Colors.grey.shade400,),
                  Container(height: 30,),
                  Text('기타안내', style: TextStyle(fontSize: 19, color: Colors.grey),),
                  Container(height: 15,),
                  Container(child: Text(
                    '먹이를 찾아 산기슭을 어슬렁거리는 하이에나를 본 일이 있는가 짐승의 썩은 고기만을 찾아다니는 산기슭의 하이에나 나는 하이에나가 아니라 표범이고 싶다 산정 높이 올라가 굶어서 얼어 죽는 눈 덮인 킬리만자로의 그 표범이고 싶다 자고나면 위대해지고 자고나면 초라해지는 나는 지금 지구의 어두운 모퉁이에서 잠시 쉬고 있다 먹이를 찾아 산기슭을 어슬렁거리는 하이에나를 본 일이 있는가 짐승의 썩은 고기만을 찾아다니는 산기슭의 하이에나 나는 하이에나가 아니라 표범이고 싶다 산정 높이 올라가 굶어서 얼어 죽는 눈 덮인 킬리만자로의 그 표범이고 싶다 자고나면 위대해지고 자고나면 초라해지는 나는 지금 지구의 어두운 모퉁이에서 잠시 쉬고 있다',
                    style: TextStyle(fontSize: 19),),),
                  Container(height: 30,),
                  SizedBox(
                    width: double.maxFinite,
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.green.shade400,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(7.0)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text('채팅하기', style: TextStyle(fontSize: 19, color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
      )
    );
  }
}