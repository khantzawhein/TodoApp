import 'package:TodoByKZH/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.instance.userInteractions = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.black),
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.black),
          primaryTextTheme: TextTheme(
              bodyText1:
                  TextStyle(color: Colors.black, fontFamily: "Montserrat"),
              headline5: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light),
      routes: Routes.routes,
      initialRoute: '/',
      builder: EasyLoading.init(),
    );
  }
}
