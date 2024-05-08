import 'package:rickandmorty/dasboard.dart';
import 'package:rickandmorty/register.dart';
import 'package:rickandmorty/user.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _form = GlobalKey<FormState>();


  TextEditingController usernameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();
  User? user;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user = User.fromJson(prefs.getString("user").toString());
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        children: [
          SizedBox(
            height: 20,
          ),
          Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Harap isi email";
                      }
                      return null;
                    },
                    controller: usernameC,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        labelText: "Email",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Harap isi password";
                      }
                      return null;
                    },
                    controller: passwordC,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        labelText: "Password",
                        border: OutlineInputBorder()),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    if (usernameC.text == user?.email &&
                        passwordC.text == user?.password) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) {
                          return DashboardScreen();
                        },
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Ops harap masukan data yang benar"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text("Login")),
          ),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ));
            },
            child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                "Belum punya akun? Daftar di sini",
                // style: Style.getBlackTextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
