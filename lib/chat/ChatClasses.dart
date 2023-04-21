
class ChatMessage {
  final String senderName;
  final String content;
  bool unread;
  final DateTime dateTime;
  final bool isMine;

  ChatMessage({
    required this.senderName,
    required this.content,
    required this.unread,
    required this.dateTime,
    required String currentUser,
  }) : isMine = senderName == currentUser;
}

class ChatRoom {
  String roomName;
  List<ChatMessage> messages;
  ChatRoom({required this.roomName, required this.messages});
}

class ChatMessageData {
  final String senderName;
  final String content;
  bool unread;
  final DateTime dateTime;

  ChatMessageData({
    required this.senderName,
    required this.content,
    required this.unread,
    required this.dateTime,
  });
}