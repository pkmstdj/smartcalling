import 'package:flutter/material.dart';

import '../main.dart';

class PageSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageSettingState();
  }
}

class _PageSettingState extends State<PageSetting> {
  bool _isPublic = true;

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
          child: Text(
            "설정",
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: customGreenAccent),
            maxLines: 1,
          ),
        ),
      ),
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 16, bottom: 16),
              child:
                Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "이력서 공개여부",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: Padding(padding: EdgeInsets.only(left: 30),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPublic = true;
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 55,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: _isPublic ? customGreenAccent : Colors.grey.shade200,
                          // borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "공개",
                          style: TextStyle(
                            fontSize: 22,
                            color: _isPublic ? Colors.white : Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(padding: EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPublic = false;
                          });
                        },
                        child: Container(
                          width: 200,
                          height: 55,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: !_isPublic ? customGreenAccent : Colors.grey.shade200,
                            // borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "비공개",
                            style: TextStyle(
                              fontSize: 22,
                              color: !_isPublic ? Colors.white : Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}