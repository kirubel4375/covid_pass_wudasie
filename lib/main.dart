import 'package:covid_pass_wudasie/Responsive/responsive_layout.dart';
import 'package:covid_pass_wudasie/Screens/MobileScreen/Home/homepage.dart';
import 'package:covid_pass_wudasie/Themes/theme_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/WebScreen/user_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBHTws4qdnlilnqiCQ8L9L4ihqa1MnmtdA",
      appId: "1:1075239018075:web:8402607251be3c705da97e",
      authDomain: "covid-app-c813a.firebaseapp.com",
      messagingSenderId: "1075239018075",
      projectId: "covid-app-c813a",
      storageBucket: "covid-app-c813a.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomeTheme.lightTheme,
      darkTheme: CustomeTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: const Responsive(
        mobileScreenLayout: MobileHome(),
        webscreenLayout: UserListPage(),
      ),
    );
  }
}
