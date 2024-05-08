import 'package:rickandmorty/character.dart';
import 'package:rickandmorty/global.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Character charachter;

  DetailPage({Key? key, required this.charachter});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        title: Text(widget.charachter.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {
                    launchUrl(Uri.parse(widget.charachter.url));
                  },
                  child: Image.network(
                    widget.charachter.image,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Gender'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Species'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Episode'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Location'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(':${widget.charachter.status}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(':${widget.charachter.gender}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(':${widget.charachter.species}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(':${widget.charachter.episode.length}'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(':${(widget.charachter.location as Location).name}'),
                  SizedBox(
                    height: 10,
                  ),
                 
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ],
            ),
     
          ],
        ),
      ),
    );
  }

 
}
