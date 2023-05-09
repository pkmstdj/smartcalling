import 'package:flutter/material.dart';
import 'package:smartcalling/board/church/pageChurch.dart';
import 'package:smartcalling/board/people/pagePeople.dart';

import '../main.dart';


class pageBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageBoard();
  }
}
class _pageBoard extends State<pageBoard> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _showPickedOnly = false;

  List<Widget> get _items => [
    pageChurch(showPickedOnly: _showPickedOnly),
    pagePeople(),
  ];

  void _togglePickedOnly() {
    setState(() {
      _showPickedOnly = !_showPickedOnly;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController (
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              bottom:
              PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TabBar(
                        tabs: [
                          Tab(child: Text("청빙 공고", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold), maxLines: 1,),),
                          Tab(child: Text("사역자 이력서", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), maxLines: 1,),),
                        ],
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        indicatorColor: customGreenAccent,
                        unselectedLabelColor: Colors.grey,
                        labelColor: customGreenAccent,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          onPressed: _togglePickedOnly,
                          child: Icon(_showPickedOnly ? Icons.star_rounded : Icons.star_outline_rounded, color: _showPickedOnly ? customGreenAccent : Colors.grey, size: 30,),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          onPressed: () {},
                          child: Icon(Icons.filter_alt_outlined, color: Colors.grey, size: 30,),
                        )
                    ),
                    SizedBox(width: 7,)
                  ],
                ),
              )
          ),
          backgroundColor: Color(0xfff5f5f5),
          body: SafeArea(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _items,),
          )
      ),
    );
  }
}