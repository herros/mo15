import 'dart:convert';

List<Nieuws> nieuwsFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Nieuws>.from(jsonData.map((x) => Nieuws.fromJson(x)));
}

class Nieuws {
    String datum;
    String text;

    Nieuws({
        this.datum,
        this.text,
    });

    factory Nieuws.fromJson(Map<String, dynamic> json) => new Nieuws(
        datum: json["datum"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "datum": datum,
        "text": text,
    };
}