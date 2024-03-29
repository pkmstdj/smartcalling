import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/firebase_options.dart';
import '../main.dart';
import 'itemChat.dart';
import 'pageChatRoom.dart';
import 'ChatClasses.dart';

class pageChat extends StatefulWidget {
  @override
  _pageChat createState() => _pageChat();
}

class _pageChat extends State<pageChat> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getData() async {
    //   await _firestore.collection("user").doc(currentUser?.email).collection("chats").get().then((value) => null)
    // }
    // String str = "a";

    // var docs = _firestore.collection("user").doc(currentUser?.email).collection("chats").get().then((value) => {
    //   setState(() {
    //     print(currentUser?.email);
    //     print(value.docs.length);
    //   })
    // });
    // setState((){
    //   _firestore.collection("user").doc(currentUser?.email).collection("chats").get().then((value) => {
    //     print(value.docs)
    //   });
    // });

    return Scaffold(
      body: SafeArea(
        // child: Text(str),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('chats').where('email', arrayContains: currentUser?.email ).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    var doc = snapshot.data!.docs[index];
                    return itemChat(doc: doc, myEmail: currentUser!.email!);
                    // return Text(doc.id);
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0),
                  itemCount: snapshot.data!.docs.length
              );
            }
        ),
      ),
    );
  }
}

// class _pageChat extends State<pageChat> {
//   final List<ChatRoom> _chatRooms = []; // 채팅방 목록
//
//   @override
//   void initState() {
//     super.initState();
//     List<ChatMessage> list = [];
//     list.add(ChatMessage(senderName: 'ABC', content: '안녕하십니까.', dateTime: DateTime(2023,4,11,18,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'ABC', content: '안녕하십니까.', dateTime: DateTime(2023,4,11,18,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'ABC', content: '어쩌구 저쩌구에 지원하겠습니다.어쩌구 저쩌구에 지원하겠습니다.어쩌구 저쩌구에 지원하겠습니다.', dateTime: DateTime(2023,4,12,18,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'ABC', content: '어쩌구 저쩌구에 지원하겠습니다.어쩌구 저쩌구에 지원하겠습니다.어쩌구 저쩌구에 지원하겠습니다.', dateTime: DateTime(2023,4,12,18,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'DEF', content: '좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.', dateTime: DateTime(2023,4,13,18,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'DEF', content: '좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.좋아요.', dateTime: DateTime(2023,4,13,18,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'DEF', content: '이력서를 보내주세요', dateTime: DateTime(2023,4,14,18,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'DEF', content: '이력서를 보내주세요', dateTime: DateTime(2023,4,14,18,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'DEF', content: '이력서를 보내주세요', dateTime: DateTime(2023,4,14,18,19), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'ABC', content: '이력서를 열람 권한이 등록되었습니다.', dateTime: DateTime(2023,4,14,17,18), unread: false, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'ABC', content: '잘 부탁 드립니다.', dateTime: DateTime(2023,4,14,18,18), unread: true, currentUser: 'ABC'));
//     list.add(ChatMessage(senderName: 'ABC', content: '여보세요?', dateTime: DateTime(2023,4,14,19,18), unread: true, currentUser: 'ABC'));
//
//     _chatRooms.add(ChatRoom(roomName: '박범순', messages: list) );
//     _chatRooms.add(ChatRoom(roomName: '박범순', messages: list) );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title:
//         PreferredSize(
//           preferredSize: const Size.fromHeight(0.0),
//           child: Text("채팅 목록", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
//         ),
//       ),
//       body: SafeArea(
//         child: ListView.separated(
//             itemBuilder: (_, int index) => ChatRoomListItem(chatRoom: _chatRooms[index]),
//             separatorBuilder: (BuildContext context, int index) => const Divider(),
//             itemCount: _chatRooms.length
//         ),
//       )
//     );
//   }
// }

// class ChatRoomListItem extends StatelessWidget {
//   final ChatRoom chatRoom;
//   const ChatRoomListItem({super.key, required this.chatRoom});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       visualDensity: VisualDensity(horizontal: 4, vertical: 0),
//       minVerticalPadding: 6,
//       // leading: CircleAvatar(child: Text(chatRoom.sender[0])),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(chatRoom.roomName, style: TextStyle(fontSize: 18)),
//           Text(DateFormat('y년 M월 d일').format(chatRoom.messages.last.dateTime), style: TextStyle(fontSize: 14),),
//         ],
//       ),
//       subtitle: Container(
//         margin: EdgeInsets.only(top: 10),
//         child: Text(chatRoom.messages.last.content, style: TextStyle(fontSize: 14)),
//       ),
//
//       onTap: () {
//         // 채팅방 선택 시 동작
//         // TODO: 채팅방으로 이동하거나 채팅을 시작하는 로직 추가
//
//         Navigator.push(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) => PageChatRoom(chatRoom: chatRoom, currentUser: 'ABC',),
//             transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               var begin = Offset(0.0, 1.0);
//               var end = Offset.zero;
//               var curve = Curves.ease;
//
//               var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//               return SlideTransition(
//                 position: animation.drive(tween),
//                 child: child,
//               );
//             },
//             transitionDuration: Duration(milliseconds: 500),
//           ),
//         );
//       },
//     );
//   }
// }