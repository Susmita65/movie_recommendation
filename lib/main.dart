import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sstfix/Ask%20Name/Askname.dart';
import 'package:sstfix/Onboarding%20Page/Genere%20selection/GenreSelection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart' as sizer;
import 'package:firebase_core/firebase_core.dart';
import 'About me/Aboutme.dart';
import 'Onboarding Page/Language Selection/LanguageSelection.dart';
import 'Screens/DetailsPage/Components/DetailsPageBody.dart';
import 'Screens/Introduction Screen/IntroductionScreen.dart';
import 'Splash/SplashScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
late SharedPreferences preferences;
List persistedGenres = [];
List persistedLanguages = [];
List<String> remembermovies = [];
List<String> recommemdedmovienames = [];
List<String> recommemdedmovieimages = [];
List<String> images = [];
List<String> title = [];

List<String> searchdata = [];
String username = "";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(const Duration(milliseconds: 500));
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    if (inDebug) return ErrorWidget(details.exception);
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error! ${details.exception}',
        style: TextStyle(color: Colors.yellow),
        textDirection: TextDirection.ltr,
      ),
    );
  };
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    persistedGenres = preferences.getStringList('_keygenres') ?? [];
    persistedLanguages = preferences.getStringList('_language') ?? [];
    remembermovies = preferences.getStringList('savedmoviehistory') ?? [];
    recommemdedmovieimages =
        preferences.getStringList('recommemdedmovieimages') ?? [];
    recommemdedmovienames =
        preferences.getStringList('recommemdedmovietitles') ?? [];

    searchdata = preferences.getStringList('searchdatas') ?? [];

    recommemdedmovieimages = recommemdedmovieimages.reversed.toList();
    recommemdedmovienames = recommemdedmovienames.reversed.toList();

    remembermovies = remembermovies.reversed.toList();
    searchdata = searchdata.reversed.toList();
    images = preferences.getStringList('posters') ?? [];
    title = preferences.getStringList('movienames') ?? [];
    images = images.reversed.toList();
    title = title.reversed.toList();

    username = preferences.getString('keyusername') ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return sizer.Sizer(builder: (BuildContext context, Orientation orientation,
        sizer.DeviceType deviceType) {
      return GetMaterialApp(
        routes: {
          '/GenreSelection': (context) => GenreSelection(),
          '/LanguageSelection': (context) => BuildLanguageSelection(),
          '/Splash': (context) => SplashScreen(),
          '/details': (context) => DetailsPageBody(),
          '/intro': (context) => IntroductionPage(),
          '/ask': (context) => ask(),
          '/settings': (context) => Aboutme(),
        },

        theme: ThemeData(
          fontFamily: GoogleFonts.chivo().fontFamily,
        ),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        ///home: Show(),
      );
    });
  }
}
