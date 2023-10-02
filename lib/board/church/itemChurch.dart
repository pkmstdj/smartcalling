import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../firebase_options.dart';
import '../../main.dart';
import 'pageChurchInfo.dart';

class ItemChurch extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> doc;
  late String address;
  late String name;
  late String platform;
  late String time;
  late List<String> position;
  late bool open;

  bool mPick = false;

  ItemChurch({super.key, required this.doc}) {
    address = "${doc['address_sido']} ${doc['address_sigungu']}";
    name = doc['name'];
    platform = doc['platform'];
    position = List<String>.from(doc['position']);
    open = doc['open'];
    time = DateFormat('yyyy-MM-dd').format(TimestempToDate(doc['time']));
  }

  @override
  _ItemChurchState createState() => _ItemChurchState();
}

class _ItemChurchState extends State<ItemChurch> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PageChurchInfo(doc: widget.doc),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      },
      title: Column(
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
                Text(
                  '${widget.platform} ',
                  style: TextStyle(
                    color: widget.open
                        ? customGreenAccent
                        : customGreenAccent.shade100,
                    fontSize: 18,
                  ),
                ),
                Container(
                  width: 1.2,
                  height: 20,
                  color: widget.open
                      ? customGreenAccent
                      : customGreenAccent.shade100,
                  margin: EdgeInsets.fromLTRB(1, 0, 5, 0),
                ),
                Text(
                  widget.address,
                  style: TextStyle(
                    color: widget.open
                        ? customGreenAccent
                        : customGreenAccent.shade100,
                    fontSize: 18,
                  ),
                ),
                if (!widget.open) ...[
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
                    child: Text(
                      '마감',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.name,
              style: TextStyle(
                color: widget.open ? Colors.black : Colors.grey,
                fontSize: 22,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                for(int i = 0 ; i < POSITIONLIST.length ; i ++)...[
                  if(widget.position.contains(POSITIONLIST[i]))...[
                    Text('${POSITIONLIST[i]}${i < widget.position.length - 1 ? ', ' : ''}', style: TextStyle(color: Colors.grey, fontSize: 18),),
                  ],
                ],
              ],
            ),
          ),
          SizedBox(height: 3,),
          Row(
            children: [
              Text(
                '등록(수정)일 ${widget.time}',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.grey, fontSize: 17, ),
              ),
            ],
          ),
        ],
      ),
      trailing:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  widget.mPick ? Icons.star_rounded : Icons.star_outline_rounded,
                  size: 40,
                  color:
                  widget.open ? customGreenAccent : customGreenAccent.shade100,
                ),
                onPressed: () {
                  setState(() {
                    widget.mPick = !widget.mPick;
                    // widget.onPickChanged(widget.mPick);
                  });
                },
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
              ),
            ],
          ),
    );
  }
}