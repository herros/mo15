import 'uitslag.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

String url = 'https://script.google.com/macros/s/AKfycbyfcvjVtgSESZAABIF08CMicmO4IaUK2ufgfvLMqn3bZaag_zQ/exec?key=rockandroll&blad=CompVJ';

Future<String> getResults() async{
  final response = await http.get(url);
  return response.body;
}

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<String>(
          future: getResults(),
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
    List<Uitslag> lijst = uitslagFromJson(snapshot.data);

    return new ListView.builder(
      itemCount: lijst.length,
      itemBuilder: (BuildContext context, int index) {
        return 
        new Column(
          children: <Widget>[
            new ListTile(
              subtitle: new Text(lijst[index].datum, textScaleFactor: 0.8,),
              title:
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  createField(lijst[index].home),
                  createField(lijst[index].away),
                  createField(lijst[index].uitslag)
                ]
              )
            ),
              new Divider(height: 2.0,)
            ]
          );
      }
    );
  }

  Widget createField(field) {
    return new Expanded(
        flex: 3,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(field, textScaleFactor: .8,)
          ],
        ),
      );
  }
}