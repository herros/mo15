// To parse this JSON data, do
//
//     final stand = standFromJson(jsonString);

import 'dart:convert';

List<Stand> standFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<Stand>.from(jsonData.map((x) => Stand.fromJson(x)));
}

String standToJson(List<Stand> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class Stand {
    String team;
    int g;
    int w;
    int gl;
    int v;
    int p;
    int dv;
    int dt;
    int s;

    Stand({
        this.team,
        this.g,
        this.w,
        this.gl,
        this.v,
        this.p,
        this.dv,
        this.dt,
        this.s,
    });

    factory Stand.fromJson(Map<String, dynamic> json) => new Stand(
        team: json["Team"],
        g: json["G"],
        w: json["W"],
        gl: json["GL"],
        v: json["V"],
        p: json["P"],
        dv: json["DV"],
        dt: json["DT"],
        s: json["S"],
    );

    Map<String, dynamic> toJson() => {
        "Team": team,
        "G": g,
        "W": w,
        "GL": gl,
        "V": v,
        "P": p,
        "DV": dv,
        "DT": dt,
        "S": s,
    };
}