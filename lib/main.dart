import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'mainHome.dart';
import 'mainLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
final Color baseColor = Color(0xFF1EC580);
final MaterialColor customGreenAccent = createMaterialColor(baseColor);

Widget buildSelectedAreaClips(Map<String, List<String>> selected) {
  if (selected.isEmpty) {
    return SizedBox.shrink();
  } else {
    Map<String, List<String>> provinceToCities = {};
    selected.forEach((province, cities) {
      if (cities.isNotEmpty) {
        provinceToCities[province] = cities.map((city) => city).toList();
      }
    });

    List<Widget> clips = [];
    provinceToCities.forEach((province, cities) {
      String citiesText = cities.join(', ');
      String displayText = cities.length > 1 ? '$province: $citiesText' : '$province $citiesText';
      clips.add(
        ClipRRect(
          // borderRadius: BorderRadius.circular(25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: customGreenAccent, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
              child: Text(displayText, style: TextStyle(fontSize: 20, color: customGreenAccent),),
            ),
          ),
        ),
      );
    });
    return Container(width: double.infinity, padding: EdgeInsets.all(8), child: Wrap(spacing: 13.0, runSpacing: 6.0, children: clips, alignment: WrapAlignment.start,));
  }
}

Widget buildSelectedClips(List<String> selectedWorks) {
  if (selectedWorks.isEmpty) {
    return SizedBox.shrink();
  } else {
    List<Widget> clips = [];
    selectedWorks.forEach((work) {
      clips.add(
        ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: customGreenAccent, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
              child: Text(work, style: TextStyle(fontSize: 20, color: customGreenAccent),),
            ),
          ),
        ),
      );
    });
    return Container(width: double.infinity, padding: EdgeInsets.all(8), child: Wrap(spacing: 13.0, runSpacing: 6.0, children: clips, alignment: WrapAlignment.start,));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Firebase Google Auth',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: MainPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => MyLoginPage(),
        '/home': (context) => MyHomePage(title: 'title'),
      }
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => MainLogin()),
      // );
      Navigator.of(context).pushReplacementNamed('/login');
      // Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(),
      ),
    );
  }
}
