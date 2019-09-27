// To parse this JSON data, do
//
//     final uitslag = uitslagFromJson(jsonString);

import 'dart:convert';

List<Uitslag> uitslagFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Uitslag>.from(jsonData.map((x) => Uitslag.fromJson(x)));
}

String uitslagToJson(List<Uitslag> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class Uitslag {
    String datum;
    String home;
    String away;
    String uitslag;

    Uitslag({
        this.datum,
        this.home,
        this.away,
        this.uitslag,
    });

    factory Uitslag.fromJson(Map<String, dynamic> json) => new Uitslag(
        datum: json["datum"],
        home: json["home"],
        away: json["away"],
        uitslag: json["uitslag"],
    );

    Map<String, dynamic> toJson() => {
        "datum": datum,
        "home": home,
        "away": away,
        "uitslag": uitslag,
    };
}
