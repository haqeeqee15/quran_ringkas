// To parse this JSON data, do
//
//  detail per aqyat

import 'package:meta/meta.dart';
import 'dart:convert';

Ayat ayatFromJson(String str) => Ayat.fromJson(json.decode(str));

String ayatToJson(Ayat data) => json.encode(data.toJson());

class Ayat {
  Audio? audio;
  Meta? meta;
  Number? number;
  Tafsir? tafsir;
  Text? text;
  Translation? translation;

  Ayat({
    required this.audio,
    required this.meta,
    required this.number,
    required this.tafsir,
    required this.text,
    required this.translation,
  });

  factory Ayat.fromJson(Map<String, dynamic>? json) => Ayat(
        audio: Audio.fromJson(json?["audio"]),
        meta: Meta.fromJson(json?["meta"]),
        number: Number.fromJson(json?["number"]),
        tafsir: Tafsir.fromJson(json?["tafsir"]),
        text: Text.fromJson(json?["text"]),
        translation: Translation.fromJson(json?["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "audio": audio?.toJson(),
        "meta": meta?.toJson(),
        "number": number?.toJson(),
        "tafsir": tafsir?.toJson(),
        "text": text?.toJson(),
        "translation": translation?.toJson(),
      };
}

class Audio {
  String? primary;
  List<String>? secondary;

  Audio({
    required this.primary,
    required this.secondary,
  });

  factory Audio.fromJson(Map<String, dynamic>? json) => Audio(
        primary: json?["primary"],
        secondary: json?["secondary"] == null ? null : List<String>.from(json!["secondary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary == null ? null :  List<dynamic>.from(secondary!.map((x) => x)),
      };
}

class Meta {
  int? hizbQuarter;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  Sajda? sajda;

  Meta({
    required this.hizbQuarter,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.sajda,
  });

  factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
        hizbQuarter: json?["hizbQuarter"],
        juz: json?["juz"],
        manzil: json?["manzil"],
        page: json?["page"],
        ruku: json?["ruku"],
        sajda: Sajda.fromJson(json?["sajda"]),
      );

  Map<String, dynamic> toJson() => {
        "hizbQuarter": hizbQuarter,
        "juz": juz,
        "manzil": manzil,
        "page": page,
        "ruku": ruku,
        "sajda": sajda?.toJson(),
      };
}

class Sajda {
  bool? obligatory;
  bool? recommended;

  Sajda({
    required this.obligatory,
    required this.recommended,
  });

  factory Sajda.fromJson(Map<String, dynamic>? json) => Sajda(
        obligatory: json?["obligatory"],
        recommended: json?["recommended"],
      );

  Map<String, dynamic> toJson() => {
        "obligatory": obligatory,
        "recommended": recommended,
      };
}

class Number {
  int? inQuran;
  int? inSurah;

  Number({
    required this.inQuran,
    required this.inSurah,
  });

  factory Number.fromJson(Map<String, dynamic>? json) => Number(
        inQuran: json?["inQuran"],
        inSurah: json?["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class Tafsir {
  Id? id;

  Tafsir({
    required this.id,
  });

  factory Tafsir.fromJson(Map<String, dynamic>? json) => Tafsir(
        id: Id.fromJson(json?["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id?.toJson(),
      };
}

class Id {
  String? long;
  String? short;

  Id({
    required this.long,
    required this.short,
  });

  factory Id.fromJson(Map<String, dynamic>? json) => Id(
        long: json?["long"],
        short: json?["short"],
      );

  Map<String, dynamic> toJson() => {
        "long": long,
        "short": short,
      };
}

class Text {
  String? arab;
  Transliteration? transliteration;

  Text({
    required this.arab,
    required this.transliteration,
  });

  factory Text.fromJson(Map<String, dynamic>? json) => Text(
        arab: json?["arab"],
        transliteration: Transliteration.fromJson(json?["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration?.toJson(),
      };
}

class Transliteration {
  String? en;

  Transliteration({
    required this.en,
  });

  factory Transliteration.fromJson(Map<String, dynamic>? json) =>
      Transliteration(
        en: json?["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Translation {
  String? en;
  String? id;

  Translation({
    required this.en,
    required this.id,
  });

  factory Translation.fromJson(Map<String, dynamic>? json) => Translation(
        en: json?["en"],
        id: json?["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}
