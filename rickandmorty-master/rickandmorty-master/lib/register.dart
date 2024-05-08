import 'package:rickandmorty/home.dart';
import 'package:rickandmorty/login.dart';
import 'package:rickandmorty/profile.dart';
import 'package:rickandmorty/user.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/helpers/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toastification/toastification.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class RegisterScreen extends StatefulWidget {
  static const _backgroundColor = Color(0xFF92E3A9);

  static const _colors = [
    Colors.blue,
    Color(0xFFFFFFFF),
  ];

  static const _durations = [
    5000,
    4000,
  ];

  static const _heightPercentages = [
    0.65,
    0.66,
  ];

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDayController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SharedPreferences? _prefs;

 @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  void _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

   Future<void> _selectDate(BuildContext context) async {
      DateTime? selectedDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDayController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          WaveWidget(
            config: CustomConfig(
              colors: RegisterScreen._colors,
              durations: RegisterScreen._durations,
              heightPercentages: RegisterScreen._heightPercentages,
            ),
            backgroundColor: RegisterScreen._backgroundColor,
            size: Size(double.infinity, 200.0),
            waveAmplitude: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Register",
                  // style: Style.getBlackTextStyle(
                  //     fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                // Text(
                //   "Masukkan Email dan Password yang sudah terdaftar",
                //   // style: Style.getBlackTextStyle(),
                // ),
                // Container(
                //   width: 200.0,
                //   height: 200.0,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: AssetImage('assets/finger.png'))),
                // ),
                TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: Style.getInputDecoration(
                        icons: Icon(Icons.email),
                        hintText: "Masukkan Alamat Email Anda")),
                TextField(
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: Style.getInputDecoration(
                        icons: Icon(Icons.person),
                        hintText: "Masukkan Nama  Anda")),
                SizedBox(height: 20),
                  TextFormField(
                controller: birthDayController,
                onTap: () => _selectDate(context),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Birthday',
                  icon: Icon(Icons.calendar_today),
                ),
              ),
                SizedBox(height: 20),
                TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: Style.getInputDecoration(
                        icons: Icon(Icons.key),
                        hintText: "Masukkan Password Anda"),),

                SizedBox(height: 20),
                ElevatedButton(
                  style: Style.getButtonStyle(),
                  onPressed: () {
                    _login(context);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  },
                  child: Text(
                    "Sudah Punya Akun? Login di sini",
                    // style: Style.getBlackTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    bool isValidate = true;
  
    if(emailController.text.isNotEmpty && !emailController.text.contains('@')){
      isValidate = false;
         Style.getCustomToast(
          context: context,
          text: "Email yang anda masukkan tidak valid",
          type: ToastificationType.error);
      return;
    }else if(nameController.text.isEmpty || nameController.text == ""){
        isValidate = false;
         Style.getCustomToast(
          context: context,
          text: "Nama yang anda masukkan tidak boleh kosong",
          type: ToastificationType.error);
        return;

    }else if(birthDayController.text.isEmpty || birthDayController.text == ""){
        isValidate = false;
       Style.getCustomToast(
          context: context,
          text: "Ulang tahun perlu diisi",
          type: ToastificationType.error);
        return;

    }else if(passwordController.text.isEmpty || passwordController.text == ""){
        isValidate = false;
       Style.getCustomToast(
          context: context,
          text: "Password anda tidak boleh kosong",
          type: ToastificationType.error);
        return;
    }


    if(isValidate) {
      await  _prefs!.setString('user', User(email: emailController.text, name: nameController.text, birthday: birthDayController.text, password: passwordController.text).toJson());
              // _prefs!.setString('password', "dulzfa");
          User user = User.fromJson(_prefs!.getString("user").toString());
           Style.getCustomToast(
          context: context,
          text: "Berhasil mendaftar",
          type: ToastificationType.success);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }

    
  }
}