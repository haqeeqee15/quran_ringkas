// To parse this JSON data, do
//
//  Url = https://api.quran.gading.dev/surah
import 'dart:convert';

List<Surah> surahFromJson(String str) =>
    List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

String surahToJson(List<Surah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surah {
  final Name name;
  final int number;
  final int numberOfVerses;
  final Revelation revelation;
  final int sequence;
  final Tafsir tafsir;

  Surah({
    required this.name,
    required this.number,
    required this.numberOfVerses,
    required this.revelation,
    required this.sequence,
    required this.tafsir,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        name: Name.fromJson(json["name"]),
        number: json["number"],
        numberOfVerses: json["numberOfVerses"],
        revelation: Revelation.fromJson(json["revelation"]),
        sequence: json["sequence"],
        tafsir: Tafsir.fromJson(json["tafsir"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "number": number,
        "numberOfVerses": numberOfVerses,
        "revelation": revelation.toJson(),
        "sequence": sequence,
        "tafsir": tafsir.toJson(),
      };
}

class Name {
  final String long;
  final String short;
  final Translation translation;
  final Translation transliteration;

  Name({
    required this.long,
    required this.short,
    required this.translation,
    required this.transliteration,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        long: json["long"],
        short: json["short"],
        translation: Translation.fromJson(json["translation"]),
        transliteration: Translation.fromJson(json["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "long": long,
        "short": short,
        "translation": translation.toJson(),
        "transliteration": transliteration.toJson(),
      };
}

class Translation {
  final String en;
  final String id;

  Translation({
    required this.en,
    required this.id,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        en: json["en"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}

class Revelation {
  final Arab arab;
  final En en;
  final Id id;

  Revelation({
    required this.arab,
    required this.en,
    required this.id,
  });

  factory Revelation.fromJson(Map<String, dynamic> json) => Revelation(
        arab: arabValues.map[json["arab"]]!,
        en: enValues.map[json["en"]]!,
        id: idValues.map[json["id"]]!,
      );

  Map<String, dynamic> toJson() => {
        "arab": arabValues.reverse[arab],
        "en": enValues.reverse[en],
        "id": idValues.reverse[id],
      };
}

enum Arab { ARAB, EMPTY }

final arabValues = EnumValues({"مدينة": Arab.ARAB, "مكة": Arab.EMPTY});

enum En { MECCAN, MEDINAN }

final enValues = EnumValues({"Meccan": En.MECCAN, "Medinan": En.MEDINAN});

enum Id { MADANIYYAH, MAKKIYYAH }

final idValues =
    EnumValues({"Madaniyyah": Id.MADANIYYAH, "Makkiyyah": Id.MAKKIYYAH});

class Tafsir {
  final String id;

  Tafsir({
    required this.id,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
