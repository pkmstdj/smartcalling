import 'package:flutter/material.dart';
import '../main.dart';
import 'ChatClasses.dart';
import 'package:intl/intl.dart';

class PageChatRoom extends StatefulWidget {
  final ChatRoom chatRoom;
  final String currentUser;

  PageChatRoom({required this.chatRoom, required this.currentUser});

  @override
  _PageChatRoomState createState() => _PageChatRoomState();
}

class _PageChatRoomState extends State<PageChatRoom> {
  final TextEditingController _textController = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages = widget.chatRoom.messages; // ChatRoom의 messages를 _messages에 복사
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
    final isMyMessage = message.senderName == widget.currentUser;
    final backgroundColor = isMyMessage ? customGreenAccent : Colors.white;
    final fontColor = isMyMessage ? Colors.white : Colors.black;
    final align = isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final borderRadius = isMyMessage ? BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(0.0),
    ) : BorderRadius.only(
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
    List<Widget> messages = [];

    // Add the first message's date to the top of the list
    if (_messages.isNotEmpty) {
      messages.add(_buildMessageDate(_messages[0].dateTime));
    }

    // Iterate through all the messages and add each message and its date
    for (int i = 0; i < _messages.length; i++) {
      final message = _messages[i];
      final prevMessage = i > 0 ? _messages[i - 1] : null;
      final nextMessage = i < _messages.length - 1 ? _messages[i + 1] : null;
      // final showTime = prevMessage == null ||
      //     !_isSameDay(prevMessage.dateTime, message.dateTime);
      final showTime = nextMessage == null || message.dateTime != nextMessage.dateTime || message.senderName != nextMessage.senderName;

      // If the previous message is from a different date, add a date separator widget
      if (prevMessage != null && !_isSameDay(prevMessage.dateTime, message.dateTime)) {
        messages.add(_buildMessageDate(message.dateTime));
      }

      messages.add(_buildMessage(message, showTime: showTime));
    }

    return Flexible(
      child: ListView(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        children: messages.reversed.toList(),
      ),
    );
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
          child: Text(widget.chatRoom.roomName, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
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


  void _handleSubmit(String text) {
    _textController.clear();
    // final message = ChatMessage(
    //   senderName: widget.currentUser,
    //   content: text,
    //   unread: true,
    //   dateTime: DateTime.now(),
    //   currentUser: widget.currentUser,
    // );
    // setState(() {
    //   // _messages.insert(0, message); // 메
    //   _messages.add(message); // 메시지 추가
    // });
  }
}









//
// import 'package:flutter/material.dart';
// import '../main.dart';
// import 'ChatClasses.dart';
// import 'package:intl/intl.dart';
//
// class PageChatRoom extends StatefulWidget {
//   final ChatRoom chatRoom;
//   final String currentUser;
//
//   PageChatRoom({required this.chatRoom, required this.currentUser});
//
//   @override
//   _PageChatRoomState createState() => _PageChatRoomState();
// }
//
// class _PageChatRoomState extends State<PageChatRoom> {
//   final TextEditingController _textController = TextEditingController();
//   List<ChatMessage> _messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _messages = widget.chatRoom.messages; // ChatRoom의 messages를 _messages에 복사
//   }
//
//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }
//
//   String _getDateString(DateTime date) {
//     final formatter = DateFormat('M월 d일');
//     return formatter.format(date);
//   }
//
//   Widget _buildMessage(ChatMessage message) {
//     final isMyMessage = message.senderName == widget.currentUser;
//     final backgroundColor = isMyMessage ? customGreenAccent : Colors.white;
//     final fontColor = isMyMessage ? Colors.white : Colors.black;
//     final align = isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
//     final borderRadius = isMyMessage ? BorderRadius.only(
//       topLeft: Radius.circular(16.0),
//       topRight: Radius.circular(16.0),
//       bottomLeft: Radius.circular(16.0),
//       bottomRight: Radius.circular(0.0),
//     ) : BorderRadius.only(
//       topLeft: Radius.circular(0.0),
//       topRight: Radius.circular(16.0),
//       bottomLeft: Radius.circular(16.0),
//       bottomRight: Radius.circular(16.0),
//     );
//
//     return Column(
//       crossAxisAlignment: align,
//       children: [
//         Row(
//           mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             if (isMyMessage)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: 6.0,
//                     height: 6.0,
//                     decoration: BoxDecoration(
//                       color: (message.unread ? Colors.red : Colors.green),
//                       shape: BoxShape.circle,
//                     ),
//                     margin: EdgeInsets.all(4.0),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         DateFormat('h:mm a').format(message.dateTime),
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 12.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4.0),
//                 ],
//               ),
//             Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.7,
//               ),
//               decoration: BoxDecoration(
//                 color: backgroundColor,
//                 borderRadius: borderRadius,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 3,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.all(8.0),
//               margin: EdgeInsets.all(4.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 4.0),
//                   Text(
//                     message.content,
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       color: fontColor,
//                     ),
//                   ),
//                   SizedBox(height: 4.0),
//                 ],
//               ),
//             ),
//             if (!isMyMessage)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 6.0,
//                     height: 6.0,
//                     decoration: BoxDecoration(
//                       color: (message.unread ? Colors.red : Colors.green),
//                       shape: BoxShape.circle,
//                     ),
//                     margin: EdgeInsets.all(4.0),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         DateFormat('h:mm a').format(message.dateTime),
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 12.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4.0),
//                 ],
//               )
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMessageList() {
//     List<Widget> messages = [];
//
//     // Add the first message's date to the top of the list
//     if (_messages.isNotEmpty) {
//       messages.add(_buildMessageDate(_messages[0].dateTime));
//     }
//
//     // Iterate through all the messages and add each message and its date
//     for (int i = 0; i < _messages.length; i++) {
//       final message = _messages[i];
//       final prevMessageDate = i > 0 ? _messages[i - 1].dateTime : null;
//
//       // If the previous message is from a different date, add a date separator widget
//       if (prevMessageDate != null && !_isSameDay(prevMessageDate, message.dateTime)) {
//         messages.add(_buildMessageDate(message.dateTime));
//       }
//
//       messages.add(_buildMessage(message));
//     }
//
//     return Flexible(
//       child: ListView(
//         padding: EdgeInsets.all(8.0),
//         reverse: true,
//         children: messages.reversed.toList(),
//       ),
//     );
//   }
//
//   Widget _buildMessageDate(DateTime date) {
//     final dateString = _getDateString(date);
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8.0),
//       child: Center(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           decoration: BoxDecoration(
//             // color: Colors.grey[300],
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Text(
//             dateString,
//             style: TextStyle(
//               fontSize: 12.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[500],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextComposer() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(color: Colors.grey, width: 0.5),
//         ),
//       ),
//       child: Row(
//         children: <Widget>[
//           Flexible(
//             child: TextField(
//               controller: _textController,
//               onSubmitted: _handleSubmit,
//               decoration: InputDecoration.collapsed(hintText: '메시지 보내기'),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () => _handleSubmit(_textController.text),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           color: customGreenAccent,
//           icon: Icon(Icons.arrow_back),
//         ),
//         title: PreferredSize(
//           preferredSize: const Size.fromHeight(0.0),
//           child: Text(widget.chatRoom.roomName, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.assignment),
//             color: customGreenAccent,
//             onPressed: () {
//               _showPopup(context);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: _buildMessageList(),
//           ),
//           Divider(height: 1.0),
//           Container(
//             decoration: BoxDecoration(color: Theme
//                 .of(context)
//                 .cardColor),
//             child: _buildTextComposer(),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   void _showPopup(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SizedBox(
//             width: double.maxFinite,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     // 이력서 요청하기 기능 구현
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('이력서 요청하기'),
//                   ),
//                 ),
//                 SizedBox(height: 12.0), // 버튼 사이의 틈
//                 InkWell(
//                   onTap: () {
//                     // 이력서 전달하기 기능 구현
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('이력서 전달하기'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//   void _handleSubmit(String text) {
//     _textController.clear();
//     // final message = ChatMessage(
//     //   senderName: widget.currentUser,
//     //   content: text,
//     //   unread: true,
//     //   dateTime: DateTime.now(),
//     //   currentUser: widget.currentUser,
//     // );
//     // setState(() {
//     //   // _messages.insert(0, message); // 메
//     //   _messages.add(message); // 메시지 추가
//     // });
//   }
// }



