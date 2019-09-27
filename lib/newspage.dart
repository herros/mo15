import 'nieuws.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

String url = 'https://script.google.com/macros/s/AKfycbyfcvjVtgSESZAABIF08CMicmO4IaUK2ufgfvLMqn3bZaag_zQ/exec?key=rockandroll&blad=Nieuws';

Future<String> getPost() async{
  final response = await http.get(url);
  return response.body;
}

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<String>(
          future: getPost(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return createListView(context, snapshot);
            }
          })
        )
      );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Nieuws> lijst = nieuwsFromJson(snapshot.data);
    return new ListView.builder(
      itemCount: lijst.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              subtitle: new Text(lijst[index].datum),
              title: new Text(lijst[index].text),
            ),
            new Divider(height: 2.0,),
            ],
          );
        },
    );
  }
}