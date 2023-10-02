import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartcalling/board/people/itemPeople.dart';

class pagePeople extends StatefulWidget {
  final bool showPickedOnly;

  const pagePeople({Key? key, this.showPickedOnly = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _pagePeople();
  }
}

class _pagePeople extends State<pagePeople> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('resume').where('open', isEqualTo: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      var doc = snapshot.data!.docs[index];
                      return itemPeople(doc: doc);
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1.0,),
                    itemCount: snapshot.data!.docs.length
                );
              }
          ),
        )
    );
  }
}
