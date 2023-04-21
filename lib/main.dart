import 'package:flutter/material.dart';
import 'package:smartcalling/board/pageBoard.dart';
import 'package:smartcalling/chat/pageChat.dart';
import 'package:smartcalling/custom_animated_bottom_bar.dart';
import 'package:smartcalling/home/pageHome.dart';
import 'package:smartcalling/mypage/pageMyPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customGreenAccent,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

MaterialColor customGreenAccent = const MaterialColor(
  0xFF69F0AE,
  <int, Color>{
    50: Color(0xFFE0F2F1),
    100: Color(0xFFB2DFDB),
    200: Color(0xFF80CBC4),
    300: Color(0xFF4DB6AC),
    400: Color(0xFF26A69A),
    500: Color(0xFF009688),
    600: Color(0xFF00897B),
    700: Color(0xFF00796B),
    800: Color(0xFF00695C),
    900: Color(0xFF004D40),
  },
);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;

  List<Widget> tabPages = List.empty(growable: true);
  DateTime? _currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 55,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home_filled),
          title: Text('홈'),
          activeColor: Colors.greenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.paste),
          title: Text('청빙 공고'),
          activeColor: Colors.greenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.message_rounded),
          title: Text('채팅'),
          activeColor: Colors.greenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.menu),
          title: Text('마이 페이지'),
          activeColor: Colors.greenAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  Widget getBody() {
    List<Widget> pages = [
      pageHome(),
      pageBoard(),
      pageChat(),
      pageMyPage(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
