import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcalling/main.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String content;

  CustomDialog({required this.title, required this.content, });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
        ),
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [Text(widget.title, style: TextStyle(color: customGreenAccent, fontSize: 26, ), textAlign: TextAlign.left,)],),
            SizedBox(height: 10),
            Row(children: [Text(widget.content, style: TextStyle(color: Colors.black, fontSize: 21, ), textAlign: TextAlign.left,)],),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: MaterialButton(
                  color: customGreenAccent,
                  padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                  child: Text('취소', style: TextStyle(color:Colors.white, fontSize: 22)),
                  onPressed: () => Navigator.pop(context, false),
                )),
                SizedBox(width: 25),
                Expanded(child: MaterialButton(
                  color: customGreenAccent,
                  padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                  child: Text('확인', style: TextStyle(color:Colors.white, fontSize: 22)),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )),
              ],
            )
          ],
        ),
      );
  }
}
