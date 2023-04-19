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
    list.add(ChatMessage(sender: 'John', content: '1111111111'));
    list.add(ChatMessage(sender: '내이름', content: '22222222222222222222222222222222222222222222222222222222222'));
    list.add(ChatMessage(sender: '내이름', content: '33333333333333333333333333333333333333333333333333333333333333'));
    list.add(ChatMessage(sender: 'John', content: '444444444444444'));
    list.add(ChatMessage(sender: 'John', content: '555555555555555555'));
    list.add(ChatMessage(sender: '내이름', content: '66666666666666666666666666666666666666666666666666666666'));
    list.add(ChatMessage(sender: '내이름', content: '7777777777777777777777777777777777777777777777777777777777'));
    list.add(ChatMessage(sender: 'John', content: '888888888888888888888888888888888888888888888888888888888888888888'));
    list.add(ChatMessage(sender: 'John', content: '8888888888'));
    list.add(ChatMessage(sender: '내이름', content: '9999999999999999999999999'));
    list.add(ChatMessage(sender: '내이름', content: '99999999999999999999999999'));
    list.add(ChatMessage(sender: 'John', content: '000000000'));
    list.add(ChatMessage(sender: 'John', content: '0000000000'));

    _chatRooms.add(ChatRoom(name: 'John', profileImage: 'Hello!', messages: list) );
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
      title: Text(chatRoom.name),
      onTap: () {
        // 채팅방 선택 시 동작
        // TODO: 채팅방으로 이동하거나 채팅을 시작하는 로직 추가
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageChatRoom(chatRoom: chatRoom),
          ),
        );
      },
    );
  }
}