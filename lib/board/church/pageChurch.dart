import 'package:flutter/material.dart';
import 'package:smartcalling/board/church/itemChurch.dart';

class pageChurch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageChurch();
  }
}
class _pageChurch extends State<pageChurch> {
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
            itemChurch(mType: "예장합동", mLocate: "경기도 수원시", mTitle: "수원삼일교회", mClass_0: true, mClass_1: true, mClass_2: true, mPick: true,),
            itemChurch(mType: "예장뭐뭐", mLocate: "경기도 안양시", mTitle: "안양삼일교회", mClass_0: false, mClass_1: true, mClass_2: true, mOver: true, mPick: true,),
            itemChurch(mType: "뭐뭐합동", mLocate: "경기도 안산시", mTitle: "안산삼일교회", mClass_0: false, mClass_1: false, mClass_2: true, mOver: true, mPick: false,),
            itemChurch(mType: "예뭐뭐동", mLocate: "경기도 용인시", mTitle: "용인삼일교회", mClass_0: true, mClass_1: false, mClass_2: true, mPick: true,),
            itemChurch(mType: "예뭐합뭐", mLocate: "경기도 안성시", mTitle: "안성삼일교회", mClass_0: true, mClass_1: true, mClass_2: false, mOver: true, mPick: false,),
            itemChurch(mType: "뭐장뭐동", mLocate: "경기도 의정부시", mTitle: "의정부삼일교회", mClass_0: true, mClass_1: false, mClass_2: false, mPick: false,),
            itemChurch(mType: "뭐장합뭐", mLocate: "경기도 성남시", mTitle: "성남삼일교회", mClass_0: true, mClass_1: true, mClass_2: true, mPick: true,),
          ],
        ),
      )
    );
  }
}