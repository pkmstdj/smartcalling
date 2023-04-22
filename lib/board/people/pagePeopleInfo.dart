import 'package:flutter/material.dart';

import '../../main.dart';

class pagePeopleInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: customGreenAccent,
            icon: Icon(Icons.arrow_back),
          ),
          title: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Text("사역자 이력서", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.star_outline_rounded),
              color: customGreenAccent,
              onPressed: () {
              },
            ),
          ],
        ),
        body:
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '[직분]',
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '이름 / 직분 / 사역기간',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          _buildInfoRow('강도사인허', '강도사인허'),
                          _buildInfoRow('목사안수', '목사안수'),
                          _buildInfoRow('선호지역', '전국, 수원시 전체'),
                          Divider(),
                          _buildSectionTitle('교육 및 수료 기타사항'),
                          Text('교육 및 수료', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8),
                          Text('자격 및 수료', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8),
                          Text('병역', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 8),
                          Text('기타 경력', style: TextStyle(fontSize: 18)),
                          Divider(),
                          _buildSectionTitle('사역 비전'),
                          Text(
                            '먹이를 찾아 산기슭을 어슬렁거리는 하이에나를 본 일이 있는가 짐승의 썩은 고기만을 찾아다니는 산기슭의 하이에나 나는 하이에나가 아니라 표범이고 싶다 산정 높이 올라가 굶어서 얼어 죽는 눈 덮인 킬리만자로의 그 표범이고 싶다 자고나면 위대해지고 자고나면 초라해지는 나는 지금 지구의 어두운 모퉁이에서 잠시 쉬고 있다 먹이를 찾아 산기슭을 어슬렁거리는 하이에나를 본 일이 있는가 짐승의 썩은 고기만을 찾아다니는 산기슭의 하이에나 나는 하이에나가 아니라 표범이고 싶다 산정 높이 올라가 굶어서 얼어 죽는 눈 덮인 킬리만자로의 그 표범이고 싶다 자고나면 위대해지고 자고나면 초라해지는 나는 지금 지구의 어두운 모퉁이에서 잠시 쉬고 있다',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(padding: EdgeInsets.all(20.0), 
                child: SizedBox(
                  width: double.maxFinite,
                  child: MaterialButton(
                    onPressed: () {},
                    color: customGreenAccent,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(7.0)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text('채팅하기', style: TextStyle(fontSize: 19, color: Colors.white),),
                    ),
                  ),
                ),),
              ],
            )

      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 18)),
          SizedBox(width: 16.0),
          Expanded(child: Text(content, style: TextStyle(fontSize: 18))),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:smartcalling/itemCheckBoxText.dart';
//
// class pagePeopleInfo extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _pagePeopleInfo();
//   }
// }
// class _pagePeopleInfo extends State<pagePeopleInfo> {
//   @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.greenAccent,
//         title: Container(child: Text('사역자 이력서', style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 0.3), ), alignment: Alignment.center,),
//         actions: [
//           Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
//             child: SizedBox(
//               width: 50,
//               child: MaterialButton(
//                 padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//                 onPressed: () {},
//                 child: Icon(Icons.star_outline_rounded, color: Colors.greenAccent, size: 36,),
//               )
//             )
//           ),
//         ],
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 150,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           color: Colors.greenAccent,
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                         ),
//                         child:
//                           Icon(Icons.account_box_rounded, size: 150, color: Colors.white,)
//                       ),
//                       Container(width: 30,),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('OOO', style: TextStyle(color: Colors.black, fontSize: 21,),),
//                           Container(height: 10,),
//                           Text('강도사', style: TextStyle(fontSize: 19,),),
//                           Text('3년', style: TextStyle(fontSize: 19,),),
//                         ]
//                       ),
//                     ],
//                   ),
//                   Container(height: 30,),
//                   Container(height: 1.3, width: double.infinity, color: Colors.grey.shade400,),
//                   Container(height: 30,),
//                   // Containesx(
//                   //   width: double.maxFinite,
//                   //   child: MaterialButton(
//                   //     onPressed: () {},
//                   //     color: Colors.green.shade400,
//                   //     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(7.0)),
//                   //     child: Container(
//                   //       padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
//                   //       child: Text('채팅하기', style: TextStyle(fontSize: 19, color: Colors.white),),
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             )
//         )
//       )
//     );
//   }
// }