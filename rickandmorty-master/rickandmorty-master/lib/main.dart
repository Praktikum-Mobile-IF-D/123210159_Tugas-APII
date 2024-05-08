import 'package:rickandmorty/dasboard.dart';
import 'package:rickandmorty/home.dart';
import 'package:rickandmorty/register.dart';
import 'package:rickandmorty/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
   MyWidget({super.key});



  @override
  State<MyWidget> createState() => _MyWidgetState();
}



class _MyWidgetState extends State<MyWidget> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
