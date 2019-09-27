// To parse this JSON data, do
//
//     final verslag = verslagFromJson(jsonString);

import 'dart:convert';

Verslag verslagFromJson(String str) {
    final jsonData = json.decode(str);
    return Verslag.fromJson(jsonData);
}

String verslagToJson(Verslag data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class Verslag {
    String url;
    String name;

    Verslag({
        this.url,
        this.name,
    });

    factory Verslag.fromJson(Map<String, dynamic> json) => new Verslag(
        url: json["url"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
    };
}
