import 'package:flutter/material.dart';

class pageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageHome();
  }
}

class _pageHome extends State<pageHome> {
  PageController _pageController = PageController(initialPage: 0);
  List<String> _imageUrls = [
    'https://cdn.discordapp.com/attachments/369924436096188419/1098252677462376488/R1280x0.png',
    'https://cdn.discordapp.com/attachments/369924436096188419/1098249610591477874/image.png',
    'https://cdn.discordapp.com/attachments/369924436096188419/1098249610591477874/image.png'
  ];
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '공지사항',
      home: Scaffold(
        appBar: AppBar(
          title: Text('공지사항'),
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
                    color: Colors.green[300],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('공지사항 제목 1'),
                    ),
                    ListTile(
                      title: Text('공지사항 제목 2'),
                    ),
                    ListTile(
                      title: Text('공지사항 제목 3'),
                    ),
                    ListTile(
                      title: Text('공지사항 제목 4'),
                    ),
                    ListTile(
                      title: Text('공지사항 제목 5'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '수련회 & 컨퍼런스 정보',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green[300],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    PageView.builder(
                      controller: _pageController,
                      itemCount: _imageUrls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      },
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPageIndex = index;
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
                            _imageUrls.length,
                                (index) => GestureDetector(
                              onTap: () {
                                if (index != _currentPageIndex) {
                                  _pageController.animateToPage(
                                    index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                width: _currentPageIndex == index ? 16.0 : 12.0,
                                height: _currentPageIndex == index ? 16.0 : 12.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPageIndex == index
                                      ? Colors.green[200]
                                      : Colors.grey[300],
                                  border: Border.all(
                                    color: _currentPageIndex == index
                                        ? Colors.green[200]!
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
                    color: Colors.green[300],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    PageView.builder(
                      controller: _pageController,
                      itemCount: _imageUrls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      },
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPageIndex = index;
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
                            _imageUrls.length,
                                (index) => GestureDetector(
                              onTap: () {
                                if (index != _currentPageIndex) {
                                  _pageController.animateToPage(
                                    index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.0),
                                width: _currentPageIndex == index ? 16.0 : 12.0,
                                height: _currentPageIndex == index ? 16.0 : 12.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPageIndex == index
                                      ? Colors.green[200]
                                      : Colors.grey[300],
                                  border: Border.all(
                                    color: _currentPageIndex == index
                                        ? Colors.green[200]!
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