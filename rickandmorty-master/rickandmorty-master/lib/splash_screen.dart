import 'package:rickandmorty/dasboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rickandmorty/helpers/style.dart';
import 'package:rickandmorty/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
        Future.delayed(Duration(seconds: 5), () {
            _loadPreferences();
        });
  }

  void _loadPreferences() async {
    debugPrint("hitted");
    final prefs = await SharedPreferences.getInstance();
    final isUserAvailable =  prefs.getString("user");
    if(isUserAvailable != '' || isUserAvailable != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));

    }
  }

 

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final size = MediaQuery.of(context).size.height;
    final appSize = size - paddingTop;
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size * 0.35,
                height: size * 0.35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/comics.png'))),
              ),
              Text(
                "Rick and Morty",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600),
              ),
            ]),
      ),
    );
  }
}