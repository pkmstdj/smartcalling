import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/CustomDialog.dart';
import 'package:smartcalling/itemCheckBoxText.dart';

import '../../firebase_options.dart';
import '../../main.dart';

class PageChurchInfo extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> doc;
  PageChurchInfo({super.key, required this.doc}) {}

  @override
  _PageChurchInfoState createState() => _PageChurchInfoState();
}

class _PageChurchInfoState extends State<PageChurchInfo> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isMine = false;
  bool already = false;
  late final _doc;

  @override
  void initState() {
    super.initState();
    setBtn();
  }
  Future<void> setBtn() async {
    if(currentUser?.uid == widget.doc['uid']) {
      isMine = true;
    }
    else {
      // final d = await _firestore.collection('board').doc(widget.doc.id).collection('applicant').where('uid', isEqualTo: currentUser?.uid).get();
      _doc = await _firestore.collection('applicant').where('uid', isEqualTo: currentUser?.uid).where('board', isEqualTo: widget.doc.id).get();
      if(_doc.size > 0) {
        setState(() {
          already = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: customGreenAccent,
        centerTitle: true,
        title: Text(
          '${widget.doc['name']} 공고',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star_outline_rounded),
            color: customGreenAccent,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHeader(),
                        buildAddressInfo(),
                        buildRegistrationDates(),
                        buildSeparator(),
                        Row(
                          children: [
                            Text('사역 정보', style: TextStyle(color: Colors.grey, fontSize: 22)),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        buildList('부서', List<String>.from(widget.doc['work'])),
                        buildList('직분', List<String>.from(widget.doc['position'])),
                        buildList('형태', List<String>.from(widget.doc['part'])),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Text('사례', style: TextStyle(color: Colors.grey, fontSize: 19)),
                              SizedBox(width: 16.0),
                              Expanded(child: Text('${widget.doc['money']} 만원', style: TextStyle(fontSize: 22))),
                            ],
                          ),
                        ),
                        buildSeparator(),
                        buildOtherInfo(),
                      ],
                    ),
                  ),
                ),
            ),
            Divider(),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Text(
      widget.doc['platform'],
      style: TextStyle(
        color: customGreenAccent,
        fontSize: 21,
      ),
    );
  }

  Widget buildAddressInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(widget.doc['address0'], style: TextStyle(fontSize: 19)),
        if(widget.doc['address1'] != '')...[
          Text(widget.doc['address1'], style: TextStyle(fontSize: 19)),
        ],
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildRegistrationDates() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '등록(수정) ${DateFormat('yyyy-MM-dd').format(TimestempToDate(widget.doc['time']))}',
          style: TextStyle(color: Colors.grey, fontSize: 17),
        ),
        Text(
          '마감 ${DateFormat('yyyy-MM-dd').format(TimestempToDate(widget.doc['limit']))}',
          style: TextStyle(color: Colors.grey, fontSize: 17),
        ),
      ],
    );
  }

  Widget buildSeparator() {
    return Column(
      children: [
        SizedBox(height: 16),
        Divider(thickness: 1.0, ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildList(String title, List<String> contents) {
    String str = '';
    for(int i = 0 ; i < contents.length ; i ++ ) {
      str += contents[i];
      if(i < contents.length - 1) str += ', ';
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 19)),
          SizedBox(width: 16.0),
          Expanded(child: Text(str, style: TextStyle(fontSize: 22))),
        ],
      ),
    );
  }

  Widget buildOtherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기타안내',
          style: TextStyle(fontSize: 19, color: Colors.grey),
        ),
        SizedBox(height: 15),
        Text(
          widget.doc['info'],
          style: TextStyle(fontSize: 19),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget buildButton() {
    return Padding(padding: EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.maxFinite,
        child: MaterialButton(
          onPressed: () async {
            if(isMine) {

            }
            else if(already) {
              bool? c = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: CustomDialog(title: '지원 취소', content: "지원 취소 하시겠습니까?"),
                ),
              );
              if(c != null && c) {
                _firestore.collection('applicant').doc(_doc.docs[0].id).delete();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('지원이 취소 되었습니다.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 3),
                  ),
                );
                setState(() {
                  already = false;
                });
              }
            }
            else {
              bool? c = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: CustomDialog(title: '지원 확인', content: "지원 하시겠습니까?"),
                ),
              );
              if(c != null && c) {
                _firestore.collection('applicant').doc().set({
                  'time': DateTime.now(),
                  'uid': currentUser?.uid,
                  'board': widget.doc.id,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('지원이 완료 되었습니다..', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                    backgroundColor: customGreenAccent.shade200,
                    duration: Duration(seconds: 3),
                  ),
                );
                setState(() {
                  already = true;
                });
              }
            }
          },
          color: already ? Colors.redAccent : customGreenAccent,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(7.0)),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            child:
              isMine ? Text('내 공고 이동', style: TextStyle(fontSize: 19, color: Colors.white),) :
              already ? Text('지원취소', style: TextStyle(fontSize: 19, color: Colors.white),) :
              Text('지원하기', style: TextStyle(fontSize: 19, color: Colors.white),),
          ),
        ),
      ),
    );
  }

}
