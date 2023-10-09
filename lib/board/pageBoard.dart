import 'package:flutter/material.dart';
import 'package:smartcalling/Popover.dart';
import 'package:smartcalling/board/church/pageChurch.dart';
import 'package:smartcalling/board/people/pagePeople.dart';

import '../main.dart';


class pageBoard extends StatefulWidget {
  List<bool> positions = [true, true, true];
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
    pagePeople(showPickedOnly: _showPickedOnly),
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
                          onPressed: () {

                            _showModalBottomSheet(context);
                          },
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
  void _showModalBottomSheet(BuildContext mainContext) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: mainContext,
      builder: (context) {
        return Popover(
          child: Container(
            height: 350,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCheckPosition(),
                ],
              ),
            ),
          ),
          onItemTapped: () {
            Navigator.of(context).pop();
            setState(() {});
          },
        );
      },
    );
  }
  Widget _buildCheckPosition() {
    return Builder(
        builder: (context) {
          final popover = context.findAncestorWidgetOfExactType<Popover>();

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.positions[0] = !widget.positions[0];
                      });
                      if (popover?.onItemTapped != null) {
                        popover?.onItemTapped!();  // 콜백 호출
                      }
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: widget.positions[0]
                            ? customGreenAccent
                            : Colors.grey.shade200,
                      ),
                      child: Text(
                        "전도사",
                        style: TextStyle(
                          fontSize: 22,
                          color:
                          widget.positions[0] ? Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 2, left: 2),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.positions[1] = !widget.positions[1];
                      });
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: widget.positions[1]
                            ? customGreenAccent
                            : Colors.grey.shade200,
                      ),
                      child: Text(
                        "강도사",
                        style: TextStyle(
                          fontSize: 22,
                          color:
                          widget.positions[1] ? Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.positions[2] = widget.positions[2];
                      });
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: widget.positions[2]
                            ? customGreenAccent
                            : Colors.grey.shade200,
                      ),
                      child: Text(
                        "목사",
                        style: TextStyle(
                          fontSize: 22,
                          color:
                          widget.positions[2] ? Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    );

  }
}