// To parse this JSON data, do
//
//     final scores = scoresFromJson(jsonString);

import 'dart:convert';

List<Scores> scoresFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Scores>.from(jsonData.map((x) => Scores.fromJson(x)));
}

String scoresToJson(List<Scores> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class Scores {
    String name;
    int goals;
    dynamic assists;
    dynamic total;

    Scores({
        this.name,
        this.goals,
        this.assists,
        this.total,
    });

    factory Scores.fromJson(Map<String, dynamic> json) => new Scores(
        name: json["name"],
        goals: json["goals"],
        assists: json["assists"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "goals": goals,
        "assists": assists,
        "total": total,
    };
}
