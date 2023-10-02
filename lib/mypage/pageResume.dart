import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smartcalling/firebase_options.dart';
import 'package:smartcalling/mypage/pageMyPage.dart';
import 'package:smartcalling/mypage/pageResumeEdit.dart';
import '../../main.dart';


class PageResume extends ConsumerStatefulWidget {
  const PageResume({super.key});

  @override
  _PageResumeState createState() => _PageResumeState();
}

class _PageResumeState extends ConsumerState<PageResume> {
  @override
  Widget build(BuildContext context) {
    return
      // MaterialApp(
      // home:
      Scaffold(
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
              child: Text("내 이력서", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: customGreenAccent), maxLines: 1,),
            ),
            actions: [
            ],
          ),
          body: MyPageWidget(),
      );//,
    // );
  }
}
// 데이터를 가져오는 과정이 완료될 때까지 로딩 인디케이터를 보여주는 위젯
class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
class VisionNotifier extends StateNotifier<String> {
  VisionNotifier() : super('');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['vision'] ?? ''); }
  }
}
class BirthNotifier extends StateNotifier<String> {
  BirthNotifier() : super('1800-01-01');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['birth'] ?? '1800-01-01'); }
  }
}
class PlatformNotifier extends StateNotifier<String> {
  PlatformNotifier() : super('');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['platform'] ?? ''); }
  }
}
class Position1Notifier extends StateNotifier<String> {
  Position1Notifier() : super('1800-01-01');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['position1'] ?? '1800-01-01'); }
  }
}
class Position2Notifier extends StateNotifier<String> {
  Position2Notifier() : super('1800-01-01');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['position2'] ?? '1800-01-01'); }
  }
}
class PositionNotifier extends StateNotifier<String> {
  PositionNotifier() : super('');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['position'] ?? ''); }
  }
}

class EducationNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  EducationNotifier() : super([]);
  void set(List<Map<String, dynamic>> value) { state = value;}
  Future<void> fetchData() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume')
        .doc(currentUser!.uid)
        .collection('education')
        .get();
    List<Map<String, dynamic>> dataList = [];
    for (var doc in data.docs) {
      dataList.add(doc.data());
    }
    set(dataList);
  }
}
int citiesLoding = 0;
class CitiesNotifier extends StateNotifier<Map<String, List<String>>> {
  CitiesNotifier() : super({});
  void set(Map<String, List<String>> value) { state = value;}
  Future<void> fetchData() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) {
      var citiesData = data.data()?['cities'];
      if (citiesData is Map<String, dynamic>) {
        set(citiesData.map((key, value) => MapEntry(key, List<String>.from(value))));
      }
    }
    if(citiesLoding == 0) {citiesLoding = 1;}
  }
}

class SexNotifier extends StateNotifier<String> {
  SexNotifier() : super('');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['sex'] ?? ''); }
  }
}

class MarriageNotifier extends StateNotifier<String> {
  MarriageNotifier() : super('');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['marriage'] ?? ''); }
  }
}

class MilitaryNotifier extends StateNotifier<String> {
  MilitaryNotifier() : super('');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['military'] ?? ''); }
  }
}

class EtcNotifier extends StateNotifier<String> {
  EtcNotifier() : super('');
  void set(String value) { state = value; }
  Future<void> fetchData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume').doc(currentUser!.uid).get();
    if (data.exists) { set(data.data()?['etc'] ?? ''); }
  }
}

class CareerNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  CareerNotifier() : super([]);
  void set(List<Map<String, dynamic>> value) { state = value;}
  Future<void> fetchData() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('resume')
        .doc(currentUser!.uid)
        .collection('career')
        .get();
    List<Map<String, dynamic>> dataList = [];
    for (var doc in data.docs) {
      dataList.add(doc.data());
    }
    set(dataList);
  }
}

final visionProvider = StateNotifierProvider<VisionNotifier, String>((ref) {
  var notifier = VisionNotifier();
  notifier.fetchData();
  return notifier;
});
final birthProvider = StateNotifierProvider<BirthNotifier, String>((ref) {
  var notifier = BirthNotifier();
  notifier.fetchData();
  return notifier;
});
final platformProvider = StateNotifierProvider<PlatformNotifier, String>((ref) {
  var notifier = PlatformNotifier();
  notifier.fetchData();
  return notifier;
});
final positionProvider = StateNotifierProvider<PositionNotifier, String>((ref) {
  var notifier = PositionNotifier();
  notifier.fetchData();
  return notifier;
});
final position1Provider = StateNotifierProvider<Position1Notifier, String>((ref) {
  var notifier = Position1Notifier();
  notifier.fetchData();
  return notifier;
});
final position2Provider = StateNotifierProvider<Position2Notifier, String>((ref) {
  var notifier = Position2Notifier();
  notifier.fetchData();
  return notifier;
});
final educationProvider = StateNotifierProvider<EducationNotifier, List<Map<String, dynamic>>>((ref) {
  var notifier = EducationNotifier();
  notifier.fetchData();
  return notifier;
});
final citiesProvider = StateNotifierProvider<CitiesNotifier, Map<String, List<String>>>((ref) {
  var notifier = CitiesNotifier();
  notifier.fetchData();
  return notifier;
});
final sexProvider = StateNotifierProvider<SexNotifier, String>((ref) {
  var notifier = SexNotifier();
  notifier.fetchData();
  return notifier;
});
final marriageProvider = StateNotifierProvider<MarriageNotifier, String>((ref) {
  var notifier = MarriageNotifier();
  notifier.fetchData();
  return notifier;
});
final militaryProvider = StateNotifierProvider<MilitaryNotifier, String>((ref) {
  var notifier = MilitaryNotifier();
  notifier.fetchData();
  return notifier;
});
final etcProvider = StateNotifierProvider<EtcNotifier, String>((ref) {
  var notifier = EtcNotifier();
  notifier.fetchData();
  return notifier;
});
final careerProvider = StateNotifierProvider<CareerNotifier, List<Map<String, dynamic>>>((ref) {
  var notifier = CareerNotifier();
  notifier.fetchData();
  return notifier;
});

class MyPageWidget extends ConsumerWidget {

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 22)),
          SizedBox(width: 16.0),
          Expanded(child: Text(content, style: TextStyle(fontSize: 22))),
        ],
      ),
    );
  }
  Widget _buildInfoRowCities(String title, Map<String, List<String>> cities) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 22)),
          SizedBox(width: 16.0),
          Expanded(child: displaySelectedCities(cities)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 24),
      ),
    );
  }

  Widget _buildEducationData(List<Map<String, dynamic>> educationList) {
    return ListView.separated(
      shrinkWrap: true,  // This is important
      physics: NeverScrollableScrollPhysics(),  // This is important
      itemCount: educationList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
              Text('${educationList[index]['school']}', style: TextStyle(fontSize: 22, color: Colors.black),),
              SizedBox(width: 20,),
              Text('${educationList[index]['major']}', style: TextStyle(fontSize: 22, color: Colors.black),),
              SizedBox(width: 20,),
            ],
          ),
          subtitle: Row(
            children: [
              Text('${DateFormat('yyyy-MM').format(DateTime.parse(educationList[index]['entry']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              SizedBox(width: 13,),
              Text('~', style: TextStyle(fontSize: 19, color: Colors.grey)),
              if(educationList[index]['graduation'] != '9999-12-01')...[
                SizedBox(width: 13,),
                Text('${DateFormat('yyyy-MM').format(DateTime.parse(educationList[index]['graduation']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              ],
              SizedBox(width: 23,),
              Text('${educationList[index]['status']}', style: TextStyle(fontSize: 19, color: Colors.grey)),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(),//const Divider(),
    );
  }

  Widget _buildCareerData(List<Map<String, dynamic>> list) {
    return ListView.separated(
      shrinkWrap: true,  // This is important
      physics: NeverScrollableScrollPhysics(),  // This is important
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('${list[index]['name']}', style: TextStyle(fontSize: 22, color: Colors.black, overflow: TextOverflow.clip),),),
                  SizedBox(width: 5,),
                  Text('${list[index]['platform']}',style: TextStyle(color: customGreenAccent, fontSize: 21,),),
                ],
              ),
              Text('${list[index]['major']}', style: TextStyle(fontSize: 22, color: Colors.black),),

              // Text('${list[index]['name']}', style: TextStyle(fontSize: 22, color: Colors.black),),
              // // SizedBox(width: 20,),
              // Text('${list[index]['major']}', style: TextStyle(fontSize: 22, color: Colors.black),),
              // // SizedBox(width: 20,),
            ],
          ),
          subtitle: Row(
            children: [
              Text('${DateFormat('yyyy-MM').format(DateTime.parse(list[index]['entry']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              SizedBox(width: 13,),
              Text('~', style: TextStyle(fontSize: 19, color: Colors.grey)),
              if(list[index]['graduation'] != '9999-12-01')...[
                SizedBox(width: 13,),
                Text('${DateFormat('yyyy-MM').format(DateTime.parse(list[index]['graduation']))}', style: TextStyle(fontSize: 19, color: Colors.grey)),
              ]
              else...[
                SizedBox(width: 23,),
                Text('사역중', style: TextStyle(fontSize: 19, color: Colors.grey)),
              ]
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(),//const Divider(),
    );
  }

  Widget displaySelectedCities(Map<String, List<String>> cities) {
    String displayText = generateSelectedCitiesText(cities);

    return Text(displayText, style: TextStyle(fontSize: 20));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    // throw UnimplementedError();
    final name = ref.watch(myNameProvider);
    final birth = ref.watch(birthProvider);
    final position = ref.watch(positionProvider);
    final platform = ref.watch(platformProvider);
    final position1 = ref.watch(position1Provider);
    final position2 = ref.watch(position2Provider);
    final vision = ref.watch(visionProvider);
    final education = ref.watch(educationProvider);
    final cities = ref.watch(citiesProvider);
    final sex = ref.watch(sexProvider);
    final marriage = ref.watch(marriageProvider);
    final military = ref.watch(militaryProvider);
    final etc = ref.watch(etcProvider);
    final career = ref.watch(careerProvider);

    if(citiesLoding == 1) {ref.refresh(citiesProvider); citiesLoding = 2;}

    return Consumer(builder: (context, watch, child) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        position != '목사' ?
                        '$name / $position' : '$name / $position / ${DateFormat(
                            'y년 M개월').format(
                            subDate(DateTime.now(), getDate(position2)))}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '생년월일: ${DateFormat('yyyy년 MM월 dd일').format(
                            getDate(birth))}',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$sex / $marriage',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Divider(thickness: 1.0, ),
                      _buildInfoRow('병역', military),
                      _buildInfoRow('교단', platform),
                      if(position != "전도사")...[
                        _buildInfoRow('강도사인허',
                            DateFormat('yyyy년 MM월 dd일').format(
                                getDate(position1))),
                        if(position == "목사")...[
                          _buildInfoRow('목사안수',
                              DateFormat('yyyy년 MM월 dd일').format(
                                  getDate(position2)))
                        ],
                      ],
                      _buildInfoRowCities('선호지역', cities),
                      Divider(thickness: 1.0, ),
                      _buildSectionTitle('학력'),
                      _buildEducationData(education),
                      Divider(thickness: 1.0, ),
                      _buildSectionTitle('경력'),
                      _buildCareerData(career),
                      Divider(thickness: 1.0, ),
                      _buildSectionTitle('사역 비전'),
                      Text(
                        vision,
                        style: TextStyle(fontSize: 22),
                      ),
                      Divider(thickness: 1.0, ),
                      _buildSectionTitle('교육 및 수료 등 기타사항'),
                      Text(
                        etc,
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.maxFinite,
                child: MaterialButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PageResumeEdit(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                    ref.refresh(educationProvider);
                  },
                  color: customGreenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Text(
                      '수정하기', style: TextStyle(fontSize: 26, color: Colors
                        .white),),
                  ),
                ),
              ),),
          ],
        );
      });
  }
}
