import 'scores.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

String url = 'https://script.google.com/macros/s/AKfycbyfcvjVtgSESZAABIF08CMicmO4IaUK2ufgfvLMqn3bZaag_zQ/exec?key=rockandroll&blad=Scores';

Future<String> getScores() async{
  final response = await http.get(url);
  return response.body;
}

class ScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<String>(
          future: getScores(),
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
          }
        )
      )
    ); 
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Scores> lijst = scoresFromJson(snapshot.data);
    var kop =
      new Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: 
          new Column(
            children: 
              <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    createHeader('Naam', 4, CrossAxisAlignment.start),
                    createHeader('Goals', 2, CrossAxisAlignment.center),
                    createHeader('Assists', 2, CrossAxisAlignment.center),
                    createHeader('Totaal', 2, CrossAxisAlignment.center)
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
          padding: EdgeInsets.fromLTRB(15,5, 15, 0),
            child: 
              new Column(
                children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          createField(
                            (index+1).toString() +
                            '. ' + 
                            lijst[index].name, CrossAxisAlignment.start, 4),
                          createField(
                            lijst[index].goals.toString(), CrossAxisAlignment.center, 2),
                          createField(
                            lijst[index].assists.toString(), CrossAxisAlignment.center, 2),
                          createField(
                            lijst[index].total.toString(), CrossAxisAlignment.center, 2)
                        ]
                      )
                  ]
                )
        );
      }
    );
  }

  Widget createHeader(field, width, align) {
    return createField(field, align, width, true);
  }
  
  Widget createField(field, align, width, [header = false]) {
    var ts = (header) ? 
                new TextStyle(fontWeight: FontWeight.bold) :
                new TextStyle(fontWeight: FontWeight.normal);
    return new Expanded(
        flex: width,
        child: new Column(
          crossAxisAlignment: align,
          children: <Widget>[
            new Text(field, style: ts)
          ],
        ),
      );
  }
}