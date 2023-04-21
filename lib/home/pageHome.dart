import 'package:flutter/material.dart';

class pageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageHome();
  }
}

class _pageHome extends State<pageHome> {
  PageController _pageControllerA = PageController(initialPage: 0);
  List<String> _imageUrlsA = [
    'https://cdn.discordapp.com/attachments/369924436096188419/1098252677462376488/R1280x0.png',
    'https://cdn.discordapp.com/attachments/369924436096188419/1098252677462376488/R1280x0.png',
    'https://cdn.discordapp.com/attachments/369924436096188419/1098252677462376488/R1280x0.png',
  ];
  int _currentPageIndexA = 0;

  PageController _pageControllerB = PageController(initialPage: 0);
  List<String> _imageUrlsB = [
    'https://cdn.discordapp.com/attachments/369924436096188419/1098252677462376488/R1280x0.png',
    'https://cdn.discordapp.com/attachments/369924436096188419/1098252677462376488/R1280x0.png',
    'https://cdn.discordapp.com/attachments/369924436096188419/1098252677462376488/R1280x0.png',
  ];
  int _currentPageIndexB = 0;

  List<Map<String, dynamic>> _noticeList = [
    {'title': '공지사항 제목 1', 'date': DateTime(2023, 4, 20)},
    {'title': '공지사항 제목 2', 'date': DateTime(2023, 4, 19)},
    {'title': '공지사항 제목 3', 'date': DateTime(2023, 4, 18)},
    {'title': '공지사항 제목 4', 'date': DateTime(2023, 4, 17)},
    {'title': '공지사항 제목 5', 'date': DateTime(2023, 4, 16)},
  ];

  @override
  void initState() {
    super.initState();
    _pageControllerA.addListener(() {
      setState(() {
        _currentPageIndexA = _pageControllerA.page!.round();
      });
    });
    _pageControllerB.addListener(() {
      setState(() {
        _currentPageIndexB = _pageControllerB.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스마트 청빙',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title:
          PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Text("스마트 청빙", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.greenAccent), maxLines: 1,),
          ),
        ),

        body: Padding(
          padding: EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '공지사항',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _noticeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_noticeList[index]['title']),
                      trailing: Text((_noticeList[index]['date'] as DateTime).toIso8601String().substring(0, 10)),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '수련회 & 컨퍼런스 정보',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    PageView.builder(
                      controller: _pageControllerA,
                      itemCount: _imageUrlsA.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrlsA[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      },
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPageIndexA = index;
                        });
                      },
                      physics: ScrollPhysics(),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _imageUrlsA.length,
                                (index) => GestureDetector(
                              onTap: () {
                                if (index != _currentPageIndexA) {
                                  _pageControllerA.animateToPage(
                                    index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                width: _currentPageIndexA == index ? 16.0 : 12.0,
                                height: _currentPageIndexA == index ? 16.0 : 12.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPageIndexA == index
                                      ? Colors.greenAccent
                                      : Colors.grey[300],
                                  border: Border.all(
                                    color: _currentPageIndexA == index
                                        ? Colors.greenAccent!
                                        : Colors.grey[700]!,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '이벤트',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    PageView.builder(
                      controller: _pageControllerB,
                      itemCount: _imageUrlsB.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrlsB[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      },
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPageIndexB = index;
                        });
                      },
                      physics: ScrollPhysics(),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _imageUrlsB.length,
                                (index) => GestureDetector(
                              onTap: () {
                                if (index != _currentPageIndexB) {
                                  _pageControllerB.animateToPage(
                                    index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                width: _currentPageIndexB == index ? 16.0 : 12.0,
                                height: _currentPageIndexB == index ? 16.0 : 12.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPageIndexB == index
                                      ? Colors.greenAccent
                                      : Colors.grey[300],
                                  border: Border.all(
                                    color: _currentPageIndexB == index
                                        ? Colors.greenAccent!
                                        : Colors.grey[700]!,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}