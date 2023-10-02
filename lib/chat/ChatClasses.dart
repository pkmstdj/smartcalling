
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderName;
  final String content;
  bool unread;
  final DateTime dateTime;
  final String dateTimeString;
  late bool isMine;

  ChatMessage({
    required this.senderName,
    required this.content,
    required this.unread,
    required this.dateTime,
    required String currentUser,
    required this.dateTimeString,
  }) : isMine = senderName == currentUser;

  // Firestore 문서를 ChatMessage 객체로 변환
  ChatMessage.fromJson(Map<String, dynamic> json)
      : senderName = json['senderName'],
        content = json['content'],
        unread = json['unread'],
        dateTimeString = json['dateTimeString'],
        dateTime = (json['dateTime'] as Timestamp).toDate(); // Firestore의 Timestamp를 DateTime으로 변환


  // ChatMessage 객체를 Firestore 문서로 변환
  Map<String, dynamic> toJson() => {
    'senderName': senderName,
    'content': content,
    'unread': unread,
    'dateTime': dateTime,
    'dateTimeString': dateTimeString,
  };
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