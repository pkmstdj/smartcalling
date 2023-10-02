import 'package:flutter/material.dart';
import 'package:smartcalling/main.dart';

import 'firebase_options.dart';

class ListSelectionScreen extends StatefulWidget {
  final List<String> TileList;
  final List<String> selectedList;

  ListSelectionScreen({required this.TileList, required this.selectedList});

  @override
  _ListSelectionScreenState createState() => _ListSelectionScreenState();
}

class _ListSelectionScreenState extends State<ListSelectionScreen> {
  List<String> _selectedLists = [];

  @override
  void initState() {
    super.initState();
    _selectedLists = List.from(widget.selectedList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customGreenAccent,
        title: Text('부서 선택'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, _selectedLists);
            },
          ),
        ],
      ),
      body:
          Column(
            children: [
              buildSelectedClips(_selectedLists),
              Divider(thickness: 1,),
              Expanded(child: ListView.separated(
                itemCount: widget.TileList.length,
                itemBuilder: (context, index) {
                  String work = widget.TileList[index];
                  bool isSelected = _selectedLists.contains(work);
                  return ListTile(
                    title: Text(work, style: TextStyle(fontSize: 23),),
                    trailing: isSelected ? Icon(Icons.check, color: customGreenAccent,) : null,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedLists.remove(work);
                        } else {
                          _selectedLists.add(work);
                        }
                      });
                    },
                  );
                }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 1.0,); },
              )),
            ],
          ),
    );
  }
}
