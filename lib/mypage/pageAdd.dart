import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/ListSelectionScreen.dart';
import 'package:smartcalling/firebase_options.dart';

import '../CustomDatePicker.dart';
import '../LibraryDaumPostcodeScreen.dart';
import '../main.dart';

class pageAdd extends StatelessWidget {
  final Map<String, dynamic> data;

  pageAdd({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
            child: Text("구인글 작성", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
          ),
          actions: [
          ],
        ),
        body: add(data: data,),
      ),
    );//,
    // );
  }
}

class add extends ConsumerStatefulWidget {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final Map<String, dynamic> data;
  add({required this.data, Key? key}) : super(key: key);
  @override
  _add createState() => _add();
}

class _add extends ConsumerState<add> {
  DataModel? _dataModel;
  String errStr = '';
  List<String> works = [];
  List<String> positions = [];
  List<String> parts = [];
  TextEditingController addressController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  DateTime limit = DateTime.now();

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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text( '${widget.data['name']}', style: TextStyle( fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 0.3, overflow: TextOverflow.clip), ), ),
                          SizedBox(width: 15,),
                          Text( '${widget.data['platform']}', style: TextStyle( color: customGreenAccent, fontSize: 21, ), ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Divider(thickness: 1.0),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text( '주소', style: TextStyle( fontSize: 23, color: Colors.grey, letterSpacing: 0.3, overflow: TextOverflow.clip), ),
                          IconButton(onPressed: () async {
                            HapticFeedback.mediumImpact();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return LibraryDaumPostcodeScreen();
                            })).then((value) {
                              if (value != null) {
                                setState(() {
                                  _dataModel = value;
                                });
                              }
                            });
                          }, icon: Icon(Icons.location_on_rounded, color: customGreenAccent,))
                        ],
                      ),
                      if(_dataModel != null)...[
                        SizedBox(height: 12,),
                        Text( '${_dataModel?.address} ${_dataModel?.buildingName}', style: TextStyle( fontSize: 21, color: Colors.black, letterSpacing: 0.3, overflow: TextOverflow.clip), ),
                        SizedBox(height: 12,),
                        TextField(
                          controller: addressController,
                          decoration: InputDecoration(labelText: '상세 주소', labelStyle: TextStyle(color: customGreenAccent, fontSize: 22)),
                          style: TextStyle(fontSize: 21),
                        ),
                      ],
                      SizedBox(height: 12,),
                      Divider(thickness: 1.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSectionTitle('사역 부서'),
                          IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      ListSelectionScreen(TileList: WORKLIST, selectedList: works),
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
                                  works = result;
                                });
                              }
                            },
                            icon: Icon(Icons.edit_note, color: customGreenAccent,),
                          )
                        ],
                      ),
                      buildSelectedClips(works),
                      SizedBox(height: 12,),
                      Divider(thickness: 1.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSectionTitle('사역 직분'),
                          IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      ListSelectionScreen(TileList: POSITIONLIST, selectedList: positions),
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
                                  positions = result;
                                });
                              }
                            },
                            icon: Icon(Icons.edit_note, color: customGreenAccent,),
                          )
                        ],
                      ),
                      buildSelectedClips(positions),
                      SizedBox(height: 12,),
                      Divider(thickness: 1.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSectionTitle('사역 형태'),
                          IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      ListSelectionScreen(TileList: PARTIST, selectedList: parts),
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
                                  parts = result;
                                });
                              }
                            },
                            icon: Icon(Icons.edit_note, color: customGreenAccent,),
                          )
                        ],
                      ),
                      buildSelectedClips(parts),
                      SizedBox(height: 12,),
                      Divider(thickness: 1.0),

                      TextField(
                        controller: moneyController,
                        onChanged: (String? text) {
                          setState(() {
                          });
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(labelText: '월 사례금 (만원)', labelStyle: TextStyle(color: customGreenAccent, fontSize: 22)),
                        style: TextStyle(fontSize: 21),
                      ),
                      SizedBox(height: 12,),
                      Divider(thickness: 1.0),

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
                                child: CustomDatePicker(initialDate: limit, title: '모집 마감일', check: true),
                              ),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                limit = pickedDate;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text('모집 마감일: ${DateFormat('yyyy년 MM월 dd일').format(limit)}',
                                style: TextStyle(
                                    color: customGreenAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),

                      SizedBox(height: 12,),
                      Divider(thickness: 1.0),

                      TextField(
                        controller: infoController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(labelText: '기타 안내', labelStyle: TextStyle(color: customGreenAccent, fontSize: 22)),
                        style: TextStyle(fontSize: 21, ),
                      ),
                    ],
                  )
              )
            )
        ),
        Divider(),
        Padding(padding: EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.maxFinite,
            child: MaterialButton(
              onPressed: () async {
                if(canSave()) {
                  // widget.currentUser
                  FirebaseFirestore.instance.collection("board").doc().set({
                    'name': widget.data['name'],
                    'platform': widget.data['platform'],
                    'address0': '${_dataModel?.address} ${_dataModel?.buildingName}',
                    'address1': addressController.text,
                    'address_sido': _dataModel?.sido,
                    'address_sigungu': _dataModel?.sigungu,
                    'work': works,
                    'position': positions,
                    'part': parts,
                    'money': moneyController.text,
                    'time': DateTime.now(),
                    'limit': limit,
                    // 'applicant': [],
                    'info': infoController.text,
                    'open': true,
                    'uid': widget.currentUser?.uid
                  });

                  Navigator.pop(context);
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errStr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              color: canSave() ? customGreenAccent : Colors.grey,
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 24),
      ),
    );
  }
  bool canSave() {
    bool check = true;
    if(_dataModel == null) {
      check = false;
      errStr = '주소를 입력해 주세요.';
    }
    else if(works.isEmpty) {
      check = false;
      errStr = '사역 부서를 선택해 주세요.';
    }
    else if(positions.isEmpty) {
      check = false;
      errStr = '사역 직분을 선택해 주세요.';
    }
    else if(parts.isEmpty) {
      check = false;
      errStr = '사역 형태를 선택해 주세요.';
    }
    else if(moneyController.text == '') {
      check = false;
      errStr = '사례금을 입력해 주세요.';
    }
    return check;
  }
}