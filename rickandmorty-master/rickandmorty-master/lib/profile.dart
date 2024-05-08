import 'package:rickandmorty/login.dart';
import 'package:rickandmorty/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

User? user;

class _ProfileScreenState extends State<ProfileScreen> {
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

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    print('String "user" deleted from SharedPreferences');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  height: 64.0,
                  width: 64.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/woman.png'))),
                ),
                SizedBox(
                  width: 24.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user?.name}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${user?.email}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text("${user?.birthday}"),
                  ],
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Apakah anda yakin akan keluar?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            await _logout()
                                .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    )));
                          },
                          child: Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Batal'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
