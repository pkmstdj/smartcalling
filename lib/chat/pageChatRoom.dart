import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'ChatClasses.dart';
import 'package:intl/intl.dart';

class PageChatRoom extends StatefulWidget {
  // final User? currentUser = FirebaseAuth.instance.currentUser;
  // final ChatRoom chatRoom;
  final QueryDocumentSnapshot<Object?> doc;
  final String email;
  final String name;
  PageChatRoom({super.key, required this.doc, required this.email, required this.name});

  @override
  _PageChatRoomState createState() => _PageChatRoomState();
}

class _PageChatRoomState extends State<PageChatRoom> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // ScrollController 추가
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    //
    // firestore.collection('chats').doc(widget.doc.id).collection('msg').orderBy('dateTime').get().then((value) =>
    // {
    //   setState(() {
    //     _messages = value.docs.map((doc) {
    //       return ChatMessage.fromJson(doc.data());
    //     } ).toList();
    //   })
    // });
    // _messages = widget.chatRoom.messages; // ChatRoom의 messages를 _messages에 복사
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _getDateString(DateTime date) {
    final formatter = DateFormat('M월 d일');
    return formatter.format(date);
  }

  Widget _buildMessage(ChatMessage message, {required bool showTime}) {
    final isMyMessage = message.senderName == widget.email;
    final backgroundColor = isMyMessage ? customGreenAccent : Colors.white;
    final fontColor = isMyMessage ? Colors.white : Colors.black;
    final align = isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final borderRadius = isMyMessage ? const BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(0.0),
    ) : const BorderRadius.only(
      topLeft: Radius.circular(0.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0),
    );

    Widget buildTimeWidget() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            DateFormat('h:mm a').format(message.dateTime),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12.0,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: align,
      children: [
        Row(
          mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isMyMessage)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: (message.unread ? Colors.red : Colors.green),
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.all(4.0),
                  ),
                  if (showTime) buildTimeWidget(),
                  SizedBox(height: 4.0),
                ],
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.0),
                  Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: fontColor,
                    ),
                  ),
                  SizedBox(height: 4.0),
                ],
              ),
            ),
            if (!isMyMessage)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: (message.unread ? Colors.red : Colors.green),
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.all(4.0),
                  ),
                  if (showTime) buildTimeWidget(),
                  SizedBox(height: 4.0),
                ],
              )
          ],
        ),
      ],
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      // Firestore의 chats 컬렉션으로부터 실시간 스트림을 가져옵니다.
      stream: FirebaseFirestore.instance.collection('chats').doc(widget.doc.id).collection('msg').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // 에러 발생시
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        // 데이터 로딩 중
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // Firestore로부터 데이터를 실시간으로 가져옵니다.
        final docs = snapshot.data!.docs;
        final List<ChatMessage> _messages = docs.map((doc) {
          final data = doc.data();
          if (data != null) {
            return ChatMessage.fromJson(data as Map<String, dynamic>);
          }
          return null;
        }).where((message) => message != null).toList().cast<ChatMessage>();


        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemCount: _messages.length + 1,
          itemBuilder: (context, index) {
            if (index == _messages.length) {
              if (_messages.isNotEmpty) {
                return _buildMessageDate(_messages.first.dateTime);
              } else {
                return SizedBox.shrink();  // 빈 위젯을 반환
              }
            }


            final adjustedIndex = _messages.length - 1 - index; // 인덱스를 조정하여 날짜 구분 기호를 고려합니다.
            final message = _messages[adjustedIndex];
            final prevMessage = adjustedIndex > 0 ? _messages[adjustedIndex - 1] : null;
            final nextMessage = adjustedIndex < _messages.length - 1 ? _messages[adjustedIndex + 1] : null;
            final showTime = nextMessage == null || message.dateTime != nextMessage.dateTime || message.senderName != nextMessage.senderName;

            if(message.unread) {
              if(message.senderName != widget.email) {
                message.unread = false;

                FirebaseFirestore.instance.collection('chats').doc(widget.doc.id).collection('msg').doc(message.dateTimeString).update(message.toJson());
              }
            }

            // 이전 메시지가 다른 날짜인 경우, 날짜 구분 위젯을 추가합니다.
            if (prevMessage != null && !_isSameDay(prevMessage.dateTime, message.dateTime)) {
              return Column(
                children: [
                  _buildMessageDate(message.dateTime),
                  _buildMessage(message, showTime: showTime),
                ],
              );
            } else {
              return _buildMessage(message, showTime: showTime);
            }
          },
        );
      },
    );

    // return ListView.builder(
    //   controller: _scrollController, // ScrollController 할당
    //   padding: EdgeInsets.all(8.0),
    //   reverse: true,
    //   itemCount: _messages.length + 1, // 첫 번째 메시지의 날짜 구분 기호를 포함하려면 1을 더해야 합니다.
    //   itemBuilder: (context, index) {
    //     if (index == _messages.length) {
    //       if (_messages.isNotEmpty) {
    //         return _buildMessageDate(_messages.first.dateTime);
    //       } else {
    //         return SizedBox.shrink();  // 빈 위젯을 반환
    //       }
    //     }
    //
    //
    //     final adjustedIndex = _messages.length - 1 - index; // 인덱스를 조정하여 날짜 구분 기호를 고려합니다.
    //     final message = _messages[adjustedIndex];
    //     final prevMessage = adjustedIndex > 0 ? _messages[adjustedIndex - 1] : null;
    //     final nextMessage = adjustedIndex < _messages.length - 1 ? _messages[adjustedIndex + 1] : null;
    //     final showTime = nextMessage == null || message.dateTime != nextMessage.dateTime || message.senderName != nextMessage.senderName;
    //
    //     // 이전 메시지가 다른 날짜인 경우, 날짜 구분 위젯을 추가합니다.
    //     if (prevMessage != null && !_isSameDay(prevMessage.dateTime, message.dateTime)) {
    //       return Column(
    //         children: [
    //           _buildMessageDate(message.dateTime),
    //           _buildMessage(message, showTime: showTime),
    //         ],
    //       );
    //     } else {
    //       return _buildMessage(message, showTime: showTime);
    //     }
    //   },
    // );
  }

  Widget _buildMessageDate(DateTime date) {
    final dateString = _getDateString(date);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            // color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            dateString,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              decoration: InputDecoration.collapsed(hintText: '메시지 보내기'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmit(_textController.text),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: customGreenAccent,
          icon: Icon(Icons.arrow_back),
        ),
        title: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Text(widget.name, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.assignment),
            color: customGreenAccent,
            onPressed: () {
              _showPopup(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildMessageList(),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme
                .of(context)
                .cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }


  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    // 이력서 요청하기 기능 구현
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('이력서 요청하기'),
                  ),
                ),
                SizedBox(height: 12.0), // 버튼 사이의 틈
                InkWell(
                  onTap: () {
                    // 이력서 전달하기 기능 구현
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('이력서 전달하기'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Future<void> _handleSubmit(String text) async {
    _textController.clear();

    DateTime now = DateTime.now();

    final message = ChatMessage(
      senderName: widget.email,
      content: text,
      unread: true,
      dateTime: now,
      dateTimeString: now.toString(),
      currentUser: widget.email,
    );

    FirebaseFirestore.instance.collection('chats').doc(widget.doc.id).collection('msg').doc(now.toString()).set(message.toJson());
    FirebaseFirestore.instance.collection('chats').doc(widget.doc.id).update({
      'update': now,
      'last': text,
    });

    // setState(() {
    //   _messages.add(message); // 메시지 추가
    //   _scrollController.animateTo(0, duration: Duration.zero, curve: Curves.linear);
    // });
  }
}
