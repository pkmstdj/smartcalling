import 'package:flutter/material.dart';
import 'package:smartcalling/board/church/pageChurch.dart';
import 'package:smartcalling/board/people/pagePeople.dart';


class pageBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pageBoard();
  }
}
class _pageBoard extends State<pageBoard> with TickerProviderStateMixin {
  late TabController _tabController;
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
                        indicatorColor: Colors.green.shade400,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.green.shade400,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          onPressed: () {},
                          child: Icon(Icons.star_outline_rounded, color: Colors.grey, size: 30,),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          onPressed: () {},
                          child: Icon(Icons.search, color: Colors.grey, size: 30,),
                        )
                    ),
                    SizedBox(width: 7,)
                  ],
                ),
              )
          ),
          backgroundColor: Color(0xfff5f5f5),
          body: SafeArea(
            child: TabBarView(children: [
              pageChurch(),
              pagePeople(),
            ],
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,),
          )
      ),
    );
  }
}