import 'package:flutter/material.dart';
import 'ChatClasses.dart';


class PageChatRoom extends StatelessWidget {
  final ChatRoom chatRoom;

  PageChatRoom({required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatRoom.name), // 채팅방 이름을 앱바 타이틀로 설정
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false, // 리스트 역순으로 출력
              itemCount: chatRoom.messages.length,
              itemBuilder: (_, index) {
                // 채팅 메시지를 생성하는 코드
                final message = chatRoom.messages[index];
                final isMyMessage = message.sender == '내이름'; // 발신자가 내 이름인지 확인
                final messageAlignment = isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start; // 발신자가 내 이름이면 오른쪽 정렬, 아니면 왼쪽 정렬

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: messageAlignment,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75, // 가로 크기의 50%
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isMyMessage ? Colors.green[300] : Colors.grey[300],
                        ),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          message.content,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        isMyMessage ? '나' : message.sender, // 발신자가 내 이름이면 '나'로 표시, 아니면 발신자 이름으로 표시
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    // 채팅 입력 필드
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '메시지를 입력하세요',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // 채팅 전송 버튼 클릭 시 동작
                  },
                  child: Text('전송'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}