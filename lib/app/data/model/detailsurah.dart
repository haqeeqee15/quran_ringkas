// To parse this JSON data, do
//
//     final detailSurah = detailSurahFromJson(jsonString);

import 'dart:convert';

DetailSurah detailSurahFromJson(String str) =>
    DetailSurah.fromJson(json.decode(str));

String detailSurahToJson(DetailSurah data) => json.encode(data.toJson());

class DetailSurah {
  Name? name;
  int? number;
  int? numberOfVerses;
  PreBismillah? preBismillah;
  Revelation? revelation;
  int? sequence;
  DetailSurahTafsir? tafsir;
  List<Verse>? verses;

  DetailSurah({
    required this.name,
    required this.number,
    required this.numberOfVerses,
    required this.preBismillah,
    required this.revelation,
    required this.sequence,
    required this.tafsir,
    required this.verses,
  });

  factory DetailSurah.fromJson(Map<String, dynamic> json) => DetailSurah(
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        number: json["number"],
        numberOfVerses: json["numberOfVerses"],
        preBismillah: json["preBismillah"] == null
            ? null
            : PreBismillah.fromJson(json["preBismillah"]),
        revelation: json["revelation"] == null
            ? null
            : Revelation.fromJson(json["revelation"]),
        sequence: json["sequence"],
        tafsir: json["tafsir"] == null
            ? null
            : DetailSurahTafsir.fromJson(json["tafsir"]),
        verses: json["verses"] == null
            ? []
            : List<Verse>.from(json["verses"].map((x) => Verse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name?.toJson(),
        "number": number,
        "numberOfVerses": numberOfVerses,
        "preBismillah": preBismillah?.toJson(),
        "revelation": revelation?.toJson(),
        "sequence": sequence,
        "tafsir": tafsir?.toJson(),
        "verses": verses == null
            ? null
            : List<dynamic>.from(verses!.map((x) => x.toJson())),
      };
}

class Name {
  String? long;
  String? short;
  Translation? translation;
  Translation? transliteration;

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
        "translation": translation?.toJson(),
        "transliteration": transliteration?.toJson(),
      };
}

class Translation {
  String? en;
  String? id;

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

class PreBismillah {
  Audio? audio;
  Text? text;
  Translation? translation;

  PreBismillah({
    required this.audio,
    required this.text,
    required this.translation,
  });

  factory PreBismillah.fromJson(Map<String, dynamic> json) => PreBismillah(
        audio: Audio.fromJson(json["audio"]),
        text: Text.fromJson(json["text"]),
        translation: Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "audio": audio?.toJson(),
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

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        primary: json["primary"],
        secondary: List<String>.from(json["secondary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary == null
            ? null
            : List<dynamic>.from(secondary!.map((x) => x)),
      };
}

class Text {
  String? arab;
  Transliteration? transliteration;

  Text({
    required this.arab,
    required this.transliteration,
  });

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        arab: json["arab"],
        transliteration: Transliteration.fromJson(json["transliteration"]),
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

  factory Transliteration.fromJson(Map<String, dynamic> json) =>
      Transliteration(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Revelation {
  String? arab;
  String? en;
  String? id;

  Revelation({
    required this.arab,
    required this.en,
    required this.id,
  });

  factory Revelation.fromJson(Map<String, dynamic> json) => Revelation(
        arab: json["arab"],
        en: json["en"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "en": en,
        "id": id,
      };
}

class DetailSurahTafsir {
  String? id;

  DetailSurahTafsir({
    required this.id,
  });

  factory DetailSurahTafsir.fromJson(Map<String, dynamic> json) =>
      DetailSurahTafsir(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Verse {
  String kondisiAudio;
  Audio? audio;
  Meta? meta;
  Number? number;
  VerseTafsir? tafsir;
  Text? text;
  Translation? translation;

  Verse({
    this.kondisiAudio = "stop",
    required this.audio,
    required this.meta,
    required this.number,
    required this.tafsir,
    required this.text,
    required this.translation,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        audio: Audio.fromJson(json["audio"]),
        meta: Meta.fromJson(json["meta"]),
        number: Number.fromJson(json["number"]),
        tafsir: VerseTafsir.fromJson(json["tafsir"]),
        text: Text.fromJson(json["text"]),
        translation: Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "audio": audio?.toJson(),
        "meta": meta?.toJson(),
        "number": number?.toJson(),
        "tafsir": tafsir?.toJson(),
        "text": text?.toJson(),
        "translation": translation?.toJson(),
        "kondisiAudio": kondisiAudio,
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

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        hizbQuarter: json["hizbQuarter"],
        juz: json["juz"],
        manzil: json["manzil"],
        page: json["page"],
        ruku: json["ruku"],
        sajda: Sajda.fromJson(json["sajda"]),
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

  factory Sajda.fromJson(Map<String, dynamic> json) => Sajda(
        obligatory: json["obligatory"],
        recommended: json["recommended"],
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

  factory Number.fromJson(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class VerseTafsir {
  Id? id;

  VerseTafsir({
    required this.id,
  });

  factory VerseTafsir.fromJson(Map<String, dynamic> json) => VerseTafsir(
        id: Id.fromJson(json["id"]),
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

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        long: json["long"],
        short: json["short"],
      );

  Map<String, dynamic> toJson() => {
        "long": long,
        "short": short,
      };
}
