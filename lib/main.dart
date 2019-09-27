import 'package:flutter/material.dart';
import 'newspage.dart';
import 'resultspage.dart';
import 'standpage.dart';
import 'scorepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CVV Berkel MO15-1',
      theme : new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: tabControllerPage(),
    );
  }

  DefaultTabController tabControllerPage() {
    
    return new DefaultTabController(
        length : 4,
        child : Scaffold(
          appBar : AppBar(
            title : Text("CVV Berkel MO15-1"),
            bottom : TabBar(
              tabs : [
                Tab(icon : Icon(Icons.view_headline),
                  text : "Nieuws"),
                Tab(icon : Icon(Icons.table_chart),
                  text : "Uitslagen"),
                Tab(icon : Icon(Icons.filter_list),
                  text : "Stand"),
                Tab(icon : Icon(Icons.local_activity),
                  text : "Scores")
                ]
              )
            ),
          body: TabBarView(
            children: [NewsPage(), ResultsPage(), StandPage(), ScorePage()],
            )
          )
        );  
  }
}
