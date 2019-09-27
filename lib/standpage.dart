import 'stand.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

String url = 'https://script.google.com/macros/s/AKfycbyfcvjVtgSESZAABIF08CMicmO4IaUK2ufgfvLMqn3bZaag_zQ/exec?key=rockandroll&blad=StandVJ';

Future<String> getStanden() async{
  final response = await http.get(url);
  return response.body;
}

class StandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<String>(
          future: getStanden(),
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
    List<Stand> lijst = standFromJson(snapshot.data);
    var kop =
      new Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: 
          new Column(
            children: 
              <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    createHeader('Team', 6, CrossAxisAlignment.start),
                    createHeader('Punten', 2, CrossAxisAlignment.center),
                    createHeader('Doelsaldo', 2, CrossAxisAlignment.center)
                    ]
                  )
                ]
            )
      ); 

    return new ListView.builder(
      itemCount: lijst.length+1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) return kop;
        index -= 1;
        return 
          new Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: 
              new Column(
                children: <Widget>[
                    new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      createField(
                        (index+1).toString() +
                        '. ' + 
                        lijst[index].team, 6, CrossAxisAlignment.start),
                      createField(
                        lijst[index].g.toString() + 
                        '-' + 
                        lijst[index].p.toString(), 2, CrossAxisAlignment.center),
                      createField(
                        lijst[index].dv.toString() +
                        '-' +
                        lijst[index].dt.toString(), 2, CrossAxisAlignment.center),
                    ]
                  )
                ]
              )
            );
      }
    );
  }

  Widget createHeader(field, width, align) {
    return createField(field, width, align, true);
  }

  Widget createField(field, width, align, [header = false]) {
    var ts = (header) ? 
            new TextStyle(fontWeight: FontWeight.bold) :
            new TextStyle(fontWeight: FontWeight.normal);
    return new Expanded(
        flex: width,
        child: new Column(
          crossAxisAlignment: align,
          children: <Widget>[
            new Text(field, textScaleFactor: 1.0, style: ts)
          ],
        ),
      );
  }
}