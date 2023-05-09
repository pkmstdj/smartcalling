import 'package:flutter/material.dart';
import 'package:smartcalling/board/church/itemChurch.dart';

class pageChurch extends StatefulWidget {
  final bool showPickedOnly;

  const pageChurch({Key? key, this.showPickedOnly = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _pageChurch();
  }
}

class _pageChurch extends State<pageChurch> {
  late ScrollController _scrollController;
  bool _fabVisible = true;
  double? _lastScrollOffset;

  // List<ItemChurch> get _filteredItems => widget.showPickedOnly
  //     ? _items.where((item) => item.mPick).toList()
  //     : _items;

  List<ItemChurch> _items = [
    ItemChurch(mType: "예장합동", mLocate: "경기도 수원시", mTitle: "수원삼일교회", mClass_0: true, mClass_1: true, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
    ItemChurch(mType: "예장뭐뭐", mLocate: "경기도 안양시", mTitle: "안양삼일교회", mClass_0: false, mClass_1: true, mClass_2: true, mOver: true, mPick: true, onPickChanged: (bool value) {  },),
    ItemChurch(mType: "뭐뭐합동", mLocate: "경기도 안산시", mTitle: "안산삼일교회", mClass_0: false, mClass_1: false, mClass_2: true, mOver: true, mPick: false, onPickChanged: (bool value) {  },),
    ItemChurch(mType: "예뭐뭐동", mLocate: "경기도 용인시", mTitle: "용인삼일교회", mClass_0: true, mClass_1: false, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
    ItemChurch(mType: "예뭐합뭐", mLocate: "경기도 안성시", mTitle: "안성삼일교회", mClass_0: true, mClass_1: true, mClass_2: false, mOver: true, mPick: false, onPickChanged: (bool value) {  },),
    ItemChurch(mType: "뭐장뭐동", mLocate: "경기도 의정부시", mTitle: "의정부삼일교회", mClass_0: true, mClass_1: false, mClass_2: false, mPick: false, onPickChanged: (bool value) {  },),
    ItemChurch(mType: "뭐장합뭐", mLocate: "경기도 성남시", mTitle: "성남삼일교회", mClass_0: true, mClass_1: true, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    double currentScrollOffset = _scrollController.position.pixels;
    if (_lastScrollOffset != null &&
        currentScrollOffset < _lastScrollOffset!) {
      setState(() {
        _fabVisible = true;
      });
    } else if (_lastScrollOffset != null &&
        currentScrollOffset > _lastScrollOffset!) {
      setState(() {
        _fabVisible = false;
      });
    }
    _lastScrollOffset = currentScrollOffset;
  }

  @override
  Widget build(BuildContext context) {
    List<ItemChurch> filteredItems = widget.showPickedOnly
        ? _items.where((item) => item.mPick).toList()
        : _items;
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            _scrollListener();
          },
          child: ListView(
            controller: _scrollController,
            children: filteredItems,
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _fabVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: _fabVisible
              ? () {
            // 버튼을 눌렀을 때 수행할 작업을 여기에 작성하세요.
          }
              : null,
          child: Icon(Icons.add, color: Colors.white,),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:smartcalling/board/church/itemChurch.dart';
//
// class pageChurch extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _pageChurch();
//   }
// }
//
// class _pageChurch extends State<pageChurch> {
//   late ScrollController _scrollController;
//   bool _fabVisible = true;
//   double? _lastScrollOffset;
//   late bool _showAll;
//
//   List<ItemChurch> _items = [
//     ItemChurch(mType: "예장합동", mLocate: "경기도 수원시", mTitle: "수원삼일교회", mClass_0: true, mClass_1: true, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "예장뭐뭐", mLocate: "경기도 안양시", mTitle: "안양삼일교회", mClass_0: false, mClass_1: true, mClass_2: true, mOver: true, mPick: true, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "뭐뭐합동", mLocate: "경기도 안산시", mTitle: "안산삼일교회", mClass_0: false, mClass_1: false, mClass_2: true, mOver: true, mPick: false, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "예뭐뭐동", mLocate: "경기도 용인시", mTitle: "용인삼일교회", mClass_0: true, mClass_1: false, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "예뭐합뭐", mLocate: "경기도 안성시", mTitle: "안성삼일교회", mClass_0: true, mClass_1: true, mClass_2: false, mOver: true, mPick: false, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "뭐장뭐동", mLocate: "경기도 의정부시", mTitle: "의정부삼일교회", mClass_0: true, mClass_1: false, mClass_2: false, mPick: false, onPickChanged: (bool value) {  },),
//     ItemChurch(mType: "뭐장합뭐", mLocate: "경기도 성남시", mTitle: "성남삼일교회", mClass_0: true, mClass_1: true, mClass_2: true, mPick: true, onPickChanged: (bool value) {  },),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//   }
//
//   void _scrollListener() {
//     double currentScrollOffset = _scrollController.position.pixels;
//     if (_lastScrollOffset != null &&
//         currentScrollOffset < _lastScrollOffset!) {
//       setState(() {
//         _fabVisible = true;
//       });
//     } else if (_lastScrollOffset != null &&
//         currentScrollOffset > _lastScrollOffset!) {
//       setState(() {
//         _fabVisible = false;
//       });
//     }
//     _lastScrollOffset = currentScrollOffset;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff5f5f5),
//       body: SafeArea(
//         child: GestureDetector(
//           onVerticalDragUpdate: (details) {
//             _scrollListener();
//           },
//           child: ListView(
//             controller: _scrollController,
//             children: _items,
//           ),
//         ),
//       ),
//       floatingActionButton: AnimatedOpacity(
//         opacity: _fabVisible ? 1.0 : 0.0,
//         duration: Duration(milliseconds: 300),
//         child: FloatingActionButton(
//           onPressed: _fabVisible
//               ? () {
//             // 버튼을 눌렀을 때 수행할 작업을 여기에 작성하세요.
//           }
//               : null,
//           child: Icon(Icons.add, color: Colors.white,),
//         ),
//       ),
//     );
//   }
// }