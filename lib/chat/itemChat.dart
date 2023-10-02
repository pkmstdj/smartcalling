import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/chat/pageChatRoom.dart';

class itemChat extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> doc;
  final String myEmail;
  late String email;
  late String name;

  itemChat({super.key, required this.doc, required this.myEmail}) {
    if(doc['email'][0] == myEmail) {
      email = doc['email'][1];
      name = doc['name'][1];
    }
    else {
      email = doc['email'][0];
      name = doc['name'][0];
    }
  }

  @override
  _ItemChatState createState() => _ItemChatState();
}
class _ItemChatState extends State<itemChat> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .doc(widget.doc.id)
          .collection("msg")
          .where(Filter.and(Filter('senderName', isEqualTo: widget.email), Filter('unread', isEqualTo: true)))
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 로딩 인디케이터 표시
        } else if (snapshot.hasError) {
          return Text("오류 발생: ${snapshot.error}"); // 오류 메시지 표시
        }

        final docs = snapshot.data?.docs ?? [];
        final count = docs.length;

        DateTime now = DateTime.now();
        DateTime date = widget.doc['update'].toDate();

        return ListTile(
          visualDensity: VisualDensity(horizontal: 4, vertical: 0),
          minVerticalPadding: 6,
          // leading: CircleAvatar(child: Text(chatRoom.sender[0])),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.name, style: TextStyle(fontSize: 18)),
              if(now.year == date.year && now.month == date.month && now.day == date.day)...[
                Text(DateFormat('h시 m분').format(date), style: TextStyle(fontSize: 14),),
              ]
              else...[
                Text(DateFormat('y년 M월 d일').format(date), style: TextStyle(fontSize: 14),),
              ]
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(widget.doc['last'], style: TextStyle(fontSize: 14)),
              ),
              if(count > 0)...[
                Container(
                  // width: 23.0,
                  // height: 23.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  // margin: EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  child: Text(count.toString(), style: TextStyle(color: Colors.white, fontSize: 14),),
                ),
              ],
            ],
          ),

          onTap: () {
            // 채팅방 선택 시 동작
            // TODO: 채팅방으로 이동하거나 채팅을 시작하는 로직 추가
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => PageChatRoom(doc: widget.doc, email: widget.myEmail, name: widget.name,),
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
        );
      },
    );
  }
}