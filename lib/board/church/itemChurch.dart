import 'package:flutter/material.dart';
import '../../main.dart';
import 'pageChurchInfo.dart';

class ItemChurch extends StatefulWidget {
  final String mType;
  final String mLocate;
  final String mTitle;
  final bool mClass_0;
  final bool mClass_1;
  final bool mClass_2;
  final bool mOver;
  late bool mPick;
  final ValueChanged<bool> onPickChanged;

  ItemChurch({
    Key? key,
    required this.mType,
    required this.mLocate,
    required this.mTitle,
    required this.mClass_0,
    required this.mClass_1,
    required this.mClass_2,
    this.mOver = false,
    required this.mPick,
    required this.onPickChanged,
  }) : super(key: key);

  @override
  _ItemChurchState createState() => _ItemChurchState();
}

class _ItemChurchState extends State<ItemChurch> {

  @override
  void initState() {
    super.initState();
  }

  Widget _buildCardWidget(Widget child) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PageChurchInfo(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(9, 1, 9, 1),
        child: _buildCardWidget(
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.mType + ' ',
                              style: TextStyle(
                                color: !widget.mOver
                                    ? Colors.blue
                                    : Colors.blue.shade100,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              width: 1.2,
                              height: 20,
                              color: !widget.mOver
                                  ? Colors.blue
                                  : Colors.blue.shade100,
                              margin: EdgeInsets.fromLTRB(1, 0, 5, 0),
                            ),
                            Text(
                              widget.mLocate + ' ',
                              style: TextStyle(
                                color: !widget.mOver
                                    ? Colors.blue
                                    : Colors.blue.shade100,
                                fontSize: 18,
                              ),
                            ),
                            if (widget.mOver) ...[
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.2,
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  '완료',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.mTitle,
                          style: TextStyle(
                            color: !widget.mOver ? Colors.black : Colors.grey,
                            fontSize: 22,
                            letterSpacing: widget.mOver ? 0.2 : 0.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            if (widget.mClass_0) ...[
                              Text(
                                '목사 ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                            if (widget.mClass_1) ...[
                              Text(
                                '강도사 ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                            if (widget.mClass_2) ...[
                              Text(
                                '전도사 ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    widget.mPick ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 40,
                    color:
                      !widget.mOver ? customGreenAccent : customGreenAccent.shade100,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.mPick = !widget.mPick;
                      widget.onPickChanged(widget.mPick);
                    });
                  },
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
