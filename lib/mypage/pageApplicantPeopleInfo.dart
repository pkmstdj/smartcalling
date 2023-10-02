import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/chat/pageChat.dart';

import '../../main.dart';
import '../../firebase_options.dart';

class pageApplicantPeopleInfo extends StatelessWidget {
  final DocumentSnapshot<Object?> doc;
  late Map<String, List<String>> cities;

  late final name;
  late final birth;
  late final position;
  late final platform;
  late final position1;
  late final position2;
  late final vision;
  List<Map<String, dynamic>> education;
  late final sex;
  late final marriage;
  late final military;
  late final etc;
  List<Map<String, dynamic>> career;

  pageApplicantPeopleInfo({super.key, required this.doc, required this.education, required this.career}) {
    var citiesData = doc['cities'];
    if (citiesData is Map<String, dynamic>) {
      cities = citiesData.map((key, value) => MapEntry(key, List<String>.from(value)));
    } else {
      // Handle the case where citiesData is not of the expected type
    }
    name = doc['name'];
    birth = doc['birth'];
    position = doc['position'];
    platform = doc['platform'];
    position1 = doc['position1'];
    position2 = doc['position2'];
    vision = doc['vision'];
    sex = doc['sex'];
    marriage = doc['marriage'];
    military = doc['military'];
    etc = doc['etc'];
  }
  Widget displaySelectedCities(Map<String, List<String>> cities) {
    String displayText = generateSelectedCitiesText(cities);

    return Text(displayText, style: TextStyle(fontSize: 20));
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 22)),
          SizedBox(width: 16.0),
          Expanded(child: Text(content, style: TextStyle(fontSize: 22))),
        ],
      ),
    );
  }
  Widget _buildInfoRowCities(String title, Map<String, List<String>> cities) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 22)),
          SizedBox(width: 16.0),
          Expanded(child: displaySelectedCities(cities)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 24),
      ),
    );
  }

  Widget _buildEducationData(List<Map<String, dynamic>> educationList) {
    return ListView.separated(
      shrinkWrap: true,  // This is important
      physics: NeverScrollableScrollPhysics(),  // This is important
      itemCount: educationList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
              Text('${educationList[index]['school']}', style: TextStyle(fontSize: 22, color: Colors.black),),
              SizedBox(width: 20,),
              Text('${educationList[index]['major']}', style: TextStyle(fontSize: 22, color: Colors.black),),
              SizedBox(width: 20,),
            ],
          ),
          subtitle: Row(
            children: [
              Text('${DateFormat('yyyy-MM').format(DateTime.parse(educationList[index]['entry']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              SizedBox(width: 13,),
              Text('~', style: TextStyle(fontSize: 19, color: Colors.grey)),
              if(educationList[index]['graduation'] != '9999-12-01')...[
                SizedBox(width: 13,),
                Text('${DateFormat('yyyy-MM').format(DateTime.parse(educationList[index]['graduation']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              ],
              SizedBox(width: 23,),
              Text('${educationList[index]['status']}', style: TextStyle(fontSize: 19, color: Colors.grey)),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(),//const Divider(),
    );
  }

  Widget _buildCareerData(List<Map<String, dynamic>> list) {
    return ListView.separated(
      shrinkWrap: true,  // This is important
      physics: NeverScrollableScrollPhysics(),  // This is important
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${list[index]['name']}', style: TextStyle(fontSize: 22, color: Colors.black),),
              // SizedBox(width: 20,),
              Text('${list[index]['major']}', style: TextStyle(fontSize: 22, color: Colors.black),),
              // SizedBox(width: 20,),
            ],
          ),
          subtitle: Row(
            children: [
              Text('${DateFormat('yyyy-MM').format(DateTime.parse(list[index]['entry']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              SizedBox(width: 13,),
              Text('~', style: TextStyle(fontSize: 19, color: Colors.grey)),
              if(list[index]['graduation'] != '9999-12-01')...[
                SizedBox(width: 13,),
                Text('${DateFormat('yyyy-MM').format(DateTime.parse(list[index]['graduation']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              ]
              else...[
                SizedBox(width: 23,),
                Text('사역중', style: TextStyle(fontSize: 19, color: Colors.grey)),
              ]
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(),//const Divider(),
    );
  }
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
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        position != '목사' ?
                        '$name / $position' : '$name / $position / ${DateFormat(
                            'y년 M개월').format(
                            subDate(DateTime.now(), getDate(position2)))}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '생년월일: ${DateFormat('yyyy년 MM월 dd일').format(
                            getDate(birth))}',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$sex / $marriage',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Divider(thickness: 1.0, ),
                      _buildInfoRow('병역', military),
                      _buildInfoRow('교단', platform),
                      if(position != "전도사")...[
                        _buildInfoRow('강도사인허',
                            DateFormat('yyyy년 MM월 dd일').format(
                                getDate(position1))),
                        if(position == "목사")...[
                          _buildInfoRow('목사안수',
                              DateFormat('yyyy년 MM월 dd일').format(
                                  getDate(position2)))
                        ],
                      ],
                      _buildInfoRowCities('선호지역', cities),
                      Divider(thickness: 1.0, ),
                      _buildSectionTitle('학력'),
                      _buildEducationData(education),
                      Divider(thickness: 1.0, ),
                      _buildSectionTitle('경력'),
                      _buildCareerData(career),
                      Divider(thickness: 1.0, ),
                      _buildSectionTitle('사역 비전'),
                      Text(
                        vision,
                        style: TextStyle(fontSize: 22),
                      ),
                      Divider(thickness: 1.0, ),
                      _buildSectionTitle('교육 및 수료 등 기타사항'),
                      Text(
                        etc,
                        style: TextStyle(fontSize: 22),
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
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            pageChat(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  color: customGreenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Text(
                      '채팅하기', style: TextStyle(fontSize: 26, color: Colors
                        .white),),
                  ),
                ),
              ),),
          ],
        ),

      ),
    );
  }
}

