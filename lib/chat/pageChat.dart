import 'package:flutter/material.dart';
import 'pageChatRoom.dart';
import 'ChatClasses.dart';

class pageChat extends StatefulWidget {
  @override
  _pageChat createState() => _pageChat();
}

class _pageChat extends State<pageChat> {
  List<ChatRoom> _chatRooms = []; // 채팅방 목록

  @override
  void initState() {
    super.initState();
    List<ChatMessage> list = [];
    list.add(ChatMessage(senderName: 'ABC', content: '1111111111', dateTime: DateTime(2023,4,11,18,18), isLiked: false, unread: false, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'ABC', content: '22222222222222222222222222222222222222222222222222222222222', dateTime: DateTime(2023,4,12,18,18), isLiked: false, unread: false, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'DEF', content: '33333333333333333333333333333333333333333333333333333333333333', dateTime: DateTime(2023,4,13,18,18), isLiked: false, unread: false, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'DEF', content: '444444444444444', dateTime: DateTime(2023,4,14,18,18), isLiked: true, unread: false, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'ABC', content: '555555555555555555', dateTime: DateTime(2023,4,14,18,18), isLiked: true, unread: false, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'ABC', content: '66666666666666666666666666666666666666666666666666666666', dateTime: DateTime(2023,4,14,18,18), isLiked: false, unread: false, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'DEF', content: '7777777777777777777777777777777777777777777777777777777777', dateTime: DateTime(2023,4,15,18,18), isLiked: false, unread: false, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'DEF', content: '888888888888888888888888888888888888888888888888888888888888888888', dateTime: DateTime(2023,4,18,18,18), isLiked: false, unread: false, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'ABC', content: '8888888888', dateTime: DateTime(2023,4,18,18,18), isLiked: true, unread: true, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'ABC', content: '9999999999999999999999999', dateTime: DateTime(2023,4,18,18,18), isLiked: false, unread: true, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'DEF', content: '99999999999999999999999999', dateTime: DateTime(2023,4,18,18,18), isLiked: false, unread: true, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'DEF', content: '000000000', dateTime: DateTime(2023,4,18,18,18), isLiked: false, unread: true, currentUser: 'ABC'));
    list.add(ChatMessage(senderName: 'ABC', content: '0000000000', dateTime: DateTime(2023,4,18,18,18), isLiked: false, unread: true, currentUser: 'ABC'));

    _chatRooms.add(ChatRoom(roomName: 'John', messages: list) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Rooms')),
      body: ListView.builder(
        itemCount: _chatRooms.length,
        itemBuilder: (_, int index) => ChatRoomListItem(chatRoom: _chatRooms[index]),
      ),
    );
  }
}

class ChatRoomListItem extends StatelessWidget {
  final ChatRoom chatRoom;
  ChatRoomListItem({required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: CircleAvatar(child: Text(chatRoom.sender[0])),
      title: Text(chatRoom.roomName),
      onTap: () {
        // 채팅방 선택 시 동작
        // TODO: 채팅방으로 이동하거나 채팅을 시작하는 로직 추가
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageChatRoom(chatRoom: chatRoom, currentUser: 'ABC',),
          ),
        );
      },
    );
  }
}