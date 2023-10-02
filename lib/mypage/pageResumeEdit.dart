
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/AreaSelectionScreen.dart';
import 'package:smartcalling/CustomEducationInfo.dart';
import 'package:smartcalling/mypage/pageMyPage.dart';
import 'package:smartcalling/mypage/pageResume.dart';
import '../../main.dart';
import '../CustomCareerInfo.dart';
import '../CustomDatePicker.dart';
import '../firebase_options.dart';

late BuildContext cont;
class PageResumeEdit extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    cont = context;
    return
      // MaterialApp(
      // home:
      Scaffold(
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
            child: Text("이력서 수정", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
          ),
          actions: [
          ],
        ),
        body: resumeEdit(),
      );//,
    // );
  }
}

class resumeEdit extends ConsumerStatefulWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  _resumeEditState createState() => _resumeEditState();
}

class _resumeEditState extends ConsumerState<resumeEdit> {
  late TextEditingController cName;
  late TextEditingController cVision;
  late TextEditingController cEtc;
  late StateController<DateTime> birthController;
  late StateController<String> platformController;
  late StateController<String> positionController;
  late StateController<DateTime> position1Controller;
  late StateController<DateTime> position2Controller;
  late StateController<List<Map<String, dynamic>>> educationController;
  late StateController<Map<String, List<String>>> citiesController;
  late StateController<String> sexController;
  late StateController<String> marriageController;
  late StateController<String> militaryController;
  late StateController<List<Map<String, dynamic>>> careerController;

  List<Map<String, dynamic>> tempEducationList = [];
  List<Map<String, dynamic>> tempCareerList = [];

  bool careerCheck = true;
  // late List<eduClass> myEduWidgets;

  @override
  void initState() {
    super.initState();

    final name = ref.read(myNameProvider);
    final birth = ref.read(birthProvider);
    final platform = ref.read(platformProvider);
    final position = ref.read(positionProvider);
    final position1 = ref.read(position1Provider);
    final position2 = ref.read(position2Provider);
    final vision = ref.read(visionProvider);
    final education = ref.read(educationProvider);
    final cities = ref.read(citiesProvider);
    final etc = ref.read(etcProvider);
    final sex = ref.read(sexProvider);
    final marriage = ref.read(marriageProvider);
    final military = ref.read(militaryProvider);
    final career = ref.read(careerProvider);

    cName = TextEditingController(text: name);
    cVision = TextEditingController(text: vision);
    platformController = StateController<String>(platform);
    positionController = StateController<String>(position);
    position1Controller = StateController<DateTime>(DateTime.parse(position1));
    position2Controller = StateController<DateTime>(DateTime.parse(position2));
    birthController = StateController<DateTime>(DateTime.parse(birth));
    educationController = StateController<List<Map<String, dynamic>>>(education);
    citiesController = StateController<Map<String, List<String>>>(cities);
    cEtc = TextEditingController(text: etc);
    sexController = StateController<String>(sex);
    marriageController = StateController<String>(marriage);
    militaryController = StateController<String>(military);
    careerController = StateController<List<Map<String, dynamic>>>(career);
    // myEduWidgets = [];

    tempEducationList = List<Map<String, dynamic>>.from(educationController.state);
    tempCareerList = List<Map<String, dynamic>>.from(careerController.state);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child:
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSectionTitle('이름'),
                  TextField(
                    controller: cName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '이름을 입력해주세요.'
                    ),
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 11,),
                  SizedBox(
                    width: double.maxFinite,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: customGreenAccent, width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),
                      onPressed: () async {
                        DateTime? pickedDate = await showDialog<DateTime>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            child: CustomDatePicker(initialDate: birthController.state, title: '생년월일', check: false),
                          ),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            birthController.state = pickedDate;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text('생년월일: ${DateFormat('yyyy년 MM월 dd일').format(birthController.state)}',
                            style: TextStyle(
                                color: customGreenAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  SizedBox(height: 11,),
                  Row(
                    children: [
                      Expanded(
                        child:
                        Column(
                          children: [
                            _buildSectionTitle('성별'),
                            DropdownButton(
                              isExpanded: true,
                              value: sexController.state,
                              style: TextStyle(fontSize: 22, color: Colors.black),
                              items: SEXLIST.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item, style: TextStyle(fontSize: 22, color: Colors.black)),
                                );
                              }).toList(),
                              onChanged: (dynamic value) {
                                setState(() {
                                  sexController.state = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:
                        Column(
                          children: [
                            _buildSectionTitle('혼인'),
                            DropdownButton(
                              isExpanded: true,
                              value: marriageController.state,
                              style: TextStyle(fontSize: 22, color: Colors.black),
                              items: MARRIAGELIST.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item, style: TextStyle(fontSize: 22, color: Colors.black)),
                                );
                              }).toList(),
                              onChanged: (dynamic value) {
                                setState(() {
                                  marriageController.state = value;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  _buildSectionTitle('병역'),
                  DropdownButton(
                    isExpanded: true,
                    value: militaryController.state,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                    items: MILITARYLIST.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 22, color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        militaryController.state = value;
                      });
                    },
                  ),
                  Divider(),
                  _buildSectionTitle('교단'),
                  DropdownButton(
                    isExpanded: true,
                    value: platformController.state,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                    items: PLATFORMLIST.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 22, color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        platformController.state = value;
                      });
                    },
                  ),
                  Divider(),
                  _buildSectionTitle('직분'),
                  DropdownButton(
                    isExpanded: true,
                    value: positionController.state,
                    style: TextStyle(fontSize: 22, color: Colors.black),
                    items: POSITIONLIST.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 22, color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        positionController.state = value;
                      });
                    },
                  ),
                  if(positionController.state == "전도사")...[
                  ],
                  if(positionController.state != "전도사")...[
                    SizedBox(height: 11,),
                    SizedBox(
                      width: double.maxFinite,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: customGreenAccent, width: 2),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))),
                        ),
                        onPressed: () async {
                          DateTime? pickedDate = await showDialog<DateTime>(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              child: CustomDatePicker(initialDate: position1Controller.state, title: '강도사인허', check: false),
                            ),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              position1Controller.state = pickedDate;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text('강도사인허: ${DateFormat('yyyy년 MM월 dd일').format(position1Controller.state)}',
                              style: TextStyle(
                                  color: customGreenAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    if(positionController.state == "목사")...[
                      SizedBox(height: 11,),
                      SizedBox(
                        width: double.maxFinite,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: customGreenAccent, width: 2),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25))),
                          ),
                          onPressed: () async {
                            DateTime? pickedDate = await showDialog<DateTime>(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                child: CustomDatePicker(initialDate: position2Controller.state, title: '목사안수', check: false),
                              ),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                position2Controller.state = pickedDate;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text('목사안수: ${DateFormat('yyyy년 MM월 dd일').format(position2Controller.state)}',
                                style: TextStyle(
                                    color: customGreenAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      )
                    ],
                    SizedBox(height: 11,),
                  ],
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle('선호지역'),
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  AreaSelectionScreen(selected: citiesController.state,),
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
                          if(result != null) {
                            setState(() {
                              citiesController.state = result;
                            });
                          }
                        },
                        icon: Icon(Icons.location_on, color: customGreenAccent,),
                      )
                    ],
                  ),
                  buildSelectedAreaClips(citiesController.state),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle('학력'),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            // educationController.state.add(value)
                            Map<String, dynamic> newData = {
                              'school': '학교',
                              'major': '전공',
                              'entry': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              'graduation': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              'status': '졸업',
                            };
                            tempEducationList.add(newData);
                            // educationController.state.add(newData);
                            // ref.read(educationDataProvider.notifier).addData(newEducationData);
                            // myEduWidgets.add(eduClass(school: '학교', major: '전공', entry: '입학년월', graduation: '졸업년월'));
                          });
                        },
                        icon: Icon(Icons.add, color: customGreenAccent,),
                        // padding: EdgeInsets.all(20),
                      )
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tempEducationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildEducationCard(tempEducationList[index], index);
                      }
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle('경력'),
                      if(!careerCheck)...[_buildRedTitle('사역지 중복 선택 불가.')],
                      IconButton(
                        onPressed: () {
                          setState(() {
                            // educationController.state.add(value)
                            Map<String, dynamic> newData = {
                              'name': '교회',
                              'major': '사역 활동',
                              'entry': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              'graduation': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              'status': false,
                              'platform': PLATFORMLIST[0],
                            };
                            // careerController.state.add(newData);
                            tempCareerList.add(newData);
                            // ref.read(educationDataProvider.notifier).addData(newEducationData);
                            // myEduWidgets.add(eduClass(school: '학교', major: '전공', entry: '입학년월', graduation: '졸업년월'));
                          });
                        },
                        icon: Icon(Icons.add, color: customGreenAccent,),
                        // padding: EdgeInsets.all(20),
                      )
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tempCareerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildCareerCard(tempCareerList[index], index);
                      }
                  ),
                  Divider(),
                  _buildSectionTitle('사역 비전'),
                  TextField(
                    controller: cVision,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '본인만의 사역비전을 입력해주세요.'
                      // labelText: '사역 비전',
                    ),
                    style: TextStyle(fontSize: 22),
                  ),
                  Divider(),
                  _buildSectionTitle('교육 및 수료 등 기타사항'),
                  TextField(
                    controller: cEtc,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '본인을 나타낼 수 있는 항목들을 입력해주세요.'
                      // labelText: '사역 비전',
                    ),
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.maxFinite,
            child: MaterialButton(
              onPressed: () async {
                if (!careerCheck) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("사역지 중복 선택 불가.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
                else {
                  careerController.state = tempCareerList;
                  educationController.state = tempEducationList;
                  await FirebaseFirestore.instance
                      .collection('resume')
                      .doc(widget.currentUser!.uid).update({
                    'name': cName.text,
                    'birth': DateFormat('yyyy-MM-dd').format(
                        birthController.state),
                    'platform': platformController.state,
                    'position': positionController.state,
                    'position1': DateFormat('yyyy-MM-dd').format(
                        position1Controller.state),
                    'position2': DateFormat('yyyy-MM-dd').format(
                        position2Controller.state),
                    'vision': cVision.text,
                    'cities': citiesController.state,
                    'sex': sexController.state,
                    'marriage': marriageController.state,
                    'military': militaryController.state,
                    'etc': cEtc.text
                  });

                  final educationRef = FirebaseFirestore.instance
                      .collection('resume')
                      .doc(widget.currentUser!.uid)
                      .collection('education');
                  final snapshotEdu = await educationRef.get();
                  for (var doc in snapshotEdu.docs) {
                    await doc.reference.delete();
                  }
                  for (var data in educationController.state) {
                    await educationRef.add(data);
                  }

                  final careerRef = FirebaseFirestore.instance
                      .collection('resume')
                      .doc(widget.currentUser!.uid)
                      .collection('career');
                  final snapshotCareer = await careerRef.get();
                  for (var doc in snapshotCareer.docs) {
                    await doc.reference.delete();
                  }
                  for (var data in careerController.state) {
                    await careerRef.add(data);
                  }

                  ref.read(myNameProvider.notifier).set(cName.text);
                  ref.read(birthProvider.notifier).set(
                      DateFormat('yyyy-MM-dd').format(birthController.state));
                  ref.read(platformProvider.notifier).set(
                      platformController.state);
                  ref.read(positionProvider.notifier).set(
                      positionController.state);
                  ref.read(position1Provider.notifier).set(
                      DateFormat('yyyy-MM-dd').format(
                          position1Controller.state));
                  ref.read(position2Provider.notifier).set(
                      DateFormat('yyyy-MM-dd').format(
                          position2Controller.state));
                  ref.read(visionProvider.notifier).set(cVision.text);
                  ref.read(educationProvider.notifier).set(
                      educationController.state);
                  ref.read(citiesProvider.notifier).set(citiesController.state);
                  ref.read(sexProvider.notifier).set(sexController.state);
                  ref.read(marriageProvider.notifier).set(
                      marriageController.state);
                  ref.read(militaryProvider.notifier).set(
                      militaryController.state);
                  ref.read(etcProvider.notifier).set(cEtc.text);
                  ref.read(careerProvider.notifier).set(careerController.state);
                  Navigator.pop(cont);
                }
              },
              color: careerCheck ? customGreenAccent : Colors.grey,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(7.0)),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Text('저장하기', style: TextStyle(fontSize: 19, color: Colors.white),),
              ),
            ),
          ),
        ),

      ],
    );
  }

  @override
  void dispose() {
    cName.dispose();
    cVision.dispose();
    super.dispose();
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 24),
      ),
    );
  }

  Widget _buildRedTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEducationCard(Map<String, dynamic> map, int index) {
    return Card(
      child: ListTile(
        onTap: () async {
          Map<String, dynamic>? data = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              child: CustomEducationInfo(data: map),
            ),
          );
          if (data != null) {
            setState(() {
              tempEducationList[index] = data;
              // position2Controller.state = pickedDate;
            });
          }
          // edu = CustomEducationInfo();
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Text('${map['school']}', style: TextStyle(fontSize: 22, color: Colors.black),),
            SizedBox(width: 20,),
            Text('${map['major']}', style: TextStyle(fontSize: 22, color: Colors.black),),
            SizedBox(width: 20,),
          ],
        ),
        subtitle: Row(
          children: [
            Text('${DateFormat('yyyy-MM').format(DateTime.parse(map['entry']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
            SizedBox(width: 13,),
            Text('~', style: TextStyle(fontSize: 19, color: Colors.grey)),
            if(map['graduation'] != '9999-12-01')... [
              SizedBox(width: 13,),
              Text('${DateFormat('yyyy-MM').format(DateTime.parse(map['graduation']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
            ],
            SizedBox(width: 23,),
            Text('${map['status']}', style: TextStyle(fontSize: 19, color: Colors.grey)),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () {
            setState(() {
              // ref.read(educationDataProvider.notifier).removeData(index);
              // myEduWidgets.removeAt(index);
              tempEducationList.removeAt(index);
            });
          },
        ),
      ),
    );
  }


  Widget _buildCareerCard(Map<String, dynamic> map, int index) {
    return Card(
      child: ListTile(
        onTap: () async {
          Map<String, dynamic>? data = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              child: CustomCareerInfo(data: map),
            ),
          );
          if (data != null) {
            setState(() {
              tempCareerList[index] = data;
              // position2Controller.state = pickedDate;
              int trueCount = tempCareerList.where((item) => item['status']).length;
              if (trueCount >= 2) {
                careerCheck = false;
              } else {
                careerCheck = true;
              }
            });
          }
          // edu = CustomEducationInfo();
        },
        title: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('${map['name']}', style: TextStyle(fontSize: 22, color: Colors.black, overflow: TextOverflow.clip),),),
                SizedBox(width: 5,),
                Text('${map['platform']}',style: TextStyle(color: customGreenAccent, fontSize: 21,),),
              ],
            ),
            Text('${map['major']}', style: TextStyle(fontSize: 22, color: Colors.black),),
          ],
        ),
        subtitle: Row(
          children: [
            Text('${DateFormat('yyyy-MM').format(DateTime.parse(map['entry']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
            SizedBox(width: 13,),
            Text('~', style: TextStyle(fontSize: 19, color: Colors.grey)),
            SizedBox(width: 13,),
            if(map['status'])...[
              Text('사역중', style: TextStyle(fontSize: 19, color: Colors.grey)),
              SizedBox(width: 23,),
            ]
            else ...[
              Text('${DateFormat('yyyy-MM').format(DateTime.parse(map['graduation']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              SizedBox(width: 23,),
            ],
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () {
            setState(() {
              tempCareerList.removeAt(index);
              int trueCount = tempCareerList.where((item) => item['status']).length;
              if (trueCount >= 2) {
                careerCheck = false;
              } else {
                careerCheck = true;
              }
            });
          },
        ),
      ),
    );
  }

}
