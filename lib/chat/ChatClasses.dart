
class ChatMessage {
  final String sender; // 발신자 이름
  final String content; // 채팅 내용

  ChatMessage({required this.sender, required this.content});
}

class ChatRoom {
  final String name; // 채팅방 이름
  final String profileImage; // 프로필 이미지 URL
  final List<ChatMessage> messages; // 채팅 메시지 리스트

  ChatRoom({required this.name, required this.profileImage, required this.messages});
}

