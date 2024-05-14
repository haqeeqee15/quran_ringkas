class Juz {
  int? juz;
  String? juzEndInfo;
  int? juzEndSurahNumber;
  String? juzStartInfo;
  int? juzStartSurahNumber;
  int? totalVerses;
  List<Verses>? verses;

  Juz(
      {this.juz,
      this.juzEndInfo,
      this.juzEndSurahNumber,
      this.juzStartInfo,
      this.juzStartSurahNumber,
      this.totalVerses,
      this.verses});

  Juz.fromJson(Map<String, dynamic> json) {
    juz = json['juz'];
    juzEndInfo = json['juzEndInfo'];
    juzEndSurahNumber = json['juzEndSurahNumber'];
    juzStartInfo = json['juzStartInfo'];
    juzStartSurahNumber = json['juzStartSurahNumber'];
    totalVerses = json['totalVerses'];
    if (json['verses'] != null) {
      verses = <Verses>[];
      json['verses'].forEach((v) {
        verses!.add(new Verses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['juz'] = this.juz;
    data['juzEndInfo'] = this.juzEndInfo;
    data['juzEndSurahNumber'] = this.juzEndSurahNumber;
    data['juzStartInfo'] = this.juzStartInfo;
    data['juzStartSurahNumber'] = this.juzStartSurahNumber;
    data['totalVerses'] = this.totalVerses;
    if (this.verses != null) {
      data['verses'] = this.verses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Verses {
  String kondisiAudio;
  Audio? audio;
  Meta? meta;
  Number? number;
  Tafsir? tafsir;
  Text? text;
  Translation? translation;

  Verses({
    this.kondisiAudio = "stop",
    required this.audio,
    required this.meta,
    required this.number,
    required this.tafsir,
    required this.text,
    required this.translation,
  });

  factory Verses.fromJson(Map<String, dynamic> json) => Verses(
        audio: Audio.fromJson(json["audio"]),
        meta: Meta.fromJson(json["meta"]),
        number: Number.fromJson(json["number"]),
        tafsir: Tafsir.fromJson(json["tafsir"]),
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

class Audio {
  String? primary;
  List<String>? secondary;

  Audio({this.primary, this.secondary});

  Audio.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    secondary = json['secondary'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    data['secondary'] = this.secondary;
    return data;
  }
}

class Meta {
  int? hizbQuarter;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  Sajda? sajda;

  Meta(
      {this.hizbQuarter,
      this.juz,
      this.manzil,
      this.page,
      this.ruku,
      this.sajda});

  Meta.fromJson(Map<String, dynamic> json) {
    hizbQuarter = json['hizbQuarter'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    sajda = json['sajda'] != null ? new Sajda.fromJson(json['sajda']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hizbQuarter'] = this.hizbQuarter;
    data['juz'] = this.juz;
    data['manzil'] = this.manzil;
    data['page'] = this.page;
    data['ruku'] = this.ruku;
    if (this.sajda != null) {
      data['sajda'] = this.sajda!.toJson();
    }
    return data;
  }
}

class Sajda {
  bool? obligatory;
  bool? recommended;

  Sajda({this.obligatory, this.recommended});

  Sajda.fromJson(Map<String, dynamic> json) {
    obligatory = json['obligatory'];
    recommended = json['recommended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['obligatory'] = this.obligatory;
    data['recommended'] = this.recommended;
    return data;
  }
}

class Number {
  int? inQuran;
  int? inSurah;

  Number({this.inQuran, this.inSurah});

  Number.fromJson(Map<String, dynamic> json) {
    inQuran = json['inQuran'];
    inSurah = json['inSurah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inQuran'] = this.inQuran;
    data['inSurah'] = this.inSurah;
    return data;
  }
}

class Tafsir {
  Id? id;

  Tafsir({this.id});

  Tafsir.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    return data;
  }
}

class Id {
  String? long;
  String? short;

  Id({this.long, this.short});

  Id.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    short = json['short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long'] = this.long;
    data['short'] = this.short;
    return data;
  }
}

class Text {
  String? arab;
  Transliteration? transliteration;

  Text({this.arab, this.transliteration});

  Text.fromJson(Map<String, dynamic> json) {
    arab = json['arab'];
    transliteration = json['transliteration'] != null
        ? new Transliteration.fromJson(json['transliteration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arab'] = this.arab;
    if (this.transliteration != null) {
      data['transliteration'] = this.transliteration!.toJson();
    }
    return data;
  }
}

class Transliteration {
  String? en;

  Transliteration({this.en});

  Transliteration.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    return data;
  }
}

class Translation {
  String? en;
  String? id;

  Translation({this.en, this.id});

  Translation.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['id'] = this.id;
    return data;
  }
}
