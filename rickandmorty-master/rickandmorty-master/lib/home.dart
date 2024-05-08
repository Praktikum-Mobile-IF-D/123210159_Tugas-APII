import 'dart:convert';

import 'package:rickandmorty/character.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/detail.dart';
// import 'package:rickandmorty/data_buku.dart';
import 'package:http/http.dart' as http;
import 'global.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  List<dynamic> allCharachter = []; 

class _HomePageState extends State<HomePage> {
  Future _getAllCharachterRickAndMorty() async{
    var response = await http.get(
    Uri.parse("https://rickandmortyapi.com/api/character"),
    headers: {
    "Content-Type": "application/json",
    },
    );
    Map obj = jsonDecode(response.body);
    debugPrint(response.body);
    setState(() {
        allCharachter = obj["results"];
      debugPrint(allCharachter.length.toString());
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllCharachterRickAndMorty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text(
          "The Rick and Morty API",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: (allCharachter.isEmpty) ? Center(
        child: CircularProgressIndicator(),
      ) : ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: allCharachter.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            print("hallo");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DetailPage(charachter: Character.fromJson(allCharachter[index]));
                },
              ),
            );
          },
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    allCharachter[index]["image"],
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allCharachter[index]["name"],
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        Text(
                          "penulis :${allCharachter[index]["name"]}",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.insert_page_break_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${(allCharachter[index]["episode"] as List).length} episode')
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
