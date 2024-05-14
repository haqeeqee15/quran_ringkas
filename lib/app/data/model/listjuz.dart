// To parse this JSON data, do
//
//     final listJuz = listJuzFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ListJuz> listJuzFromJson(String str) =>
    List<ListJuz>.from(json.decode(str).map((x) => ListJuz.fromJson(x)));

String listJuzToJson(List<ListJuz> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListJuz {
  int index;
  End start;
  End end;

  ListJuz({
    required this.index,
    required this.start,
    required this.end,
  });

  factory ListJuz.fromJson(Map<String, dynamic> json) => ListJuz(
        index: json["index"],
        start: End.fromJson(json["start"]),
        end: End.fromJson(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "start": start.toJson(),
        "end": end.toJson(),
      };
}

class End {
  String index;
  String verse;
  String name;

  End({
    required this.index,
    required this.verse,
    required this.name,
  });

  factory End.fromJson(Map<String, dynamic> json) => End(
        index: json["index"],
        verse: json["verse"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "verse": verse,
        "name": name,
      };
}
