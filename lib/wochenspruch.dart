abstract class WochenSpruch {
  var tagName;

  WochenSpruch(tagName) {
    this.tagName = tagName;
  }

  bool istTagesSpruch() {
    return false;
  }

  bool gilt(DateTime date) {
    return sameDay(giltAb(date), date) ||
        (date.isAfter(giltAb(date)) && date.isBefore(giltBis(date)));
  }

  DateTime giltAb(DateTime date) {
    return date;
  }

  DateTime giltBis(DateTime date) {
    if (istTagesSpruch()) {
      return giltAb(date);
    } else {
      return giltAb(date).add(new Duration(days: 7));
    }
  }

  static bool sameDay(DateTime a, DateTime b) {
    return a != null &&
        b != null &&
        a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  String toString() {
    return tagName;
  }

  static List<WochenSpruch> getAllEinzelFestTage() {
    List<WochenSpruch> ret = [];
    ret.add(new FestTag("Lichtmess", 02, 02));
    ret.add(new FestTag("Verkündigung", 03, 25));
    ret.add(new FestTag("Christvesper", 12, 24));
    ret.add(new FestTag("Christfest", 12, 25));
    ret.add(new FestTag("Christfest", 12, 26));
    ret.add(new FestTag("Altjahresabend", 12, 31));
    ret.add(new FestTag("Tag der Beschneidung und Namensgebung Christi, Neujahr", 01, 01));
    ret.add(new FestTag("Epiphanias", 01, 06));
    ret.add(new FestTag("Berufung des Apostels Paulus", 01, 25));
    ret.add(new FestTag("Gedenken an die Opfer des Nationalsozialismus", 01, 27));
    ret.add(new FestTag("Tag es Apostels Matthias", 02, 24));
    ret.add(new FestTag("Tag es Evangelisten Markus", 04, 25));
    ret.add(new FestTag("Tag der Apostel Philippus und Jakobus des Jüngeren", 05, 03));
    ret.add(new FestTag("Johannis", 06, 24));
    ret.add(new FestTag("Gedenktag des Augsburger Bekenntnisses", 06, 25));
    ret.add(new FestTag("Peter und Paul", 06, 29));
    ret.add(new FestTag("Heimsuchung", 07, 02));
    ret.add(new FestTag("Tag es Apostels Thomas", 07, 03));
    ret.add(new FestTag("Tag der Maria Magdalena", 07, 22));
    ret.add(new FestTag("Tag des Apostels Jakobus des Älteren", 07, 25));
    ret.add(new FestTag("Tag des Apostels Bartholomäus", 08, 24));
    ret.add(new FestTag("Tag der Enthauptung Johannes des Täufers", 08, 29));
    ret.add(new FestTag("Tag des Apostels und Evangelisten Markus", 09, 21));
    ret.add(new FestTag("Tag des Evangelisten Lukas", 10, 18));
    ret.add(new FestTag("Michaelis", 09, 29));
    ret.add(new FestTag("Tag der Apostel Simon und Judas", 10, 28));
    ret.add(new FestTag("Reformationstag", 10, 31));
    ret.add(new FestTag("Allerheiligen", 11, 01));
    ret.add(new FestTag("Gedenktag der Novemberpogrome", 11, 09));
    ret.add(new FestTag("St. Martin", 11, 11));
    ret.add(new FestTag("Tag des Apostels Andreas", 11, 30));
    ret.add(new FestTag("Nikolaus", 12, 06));
    ret.add(new FestTag("Stephanus", 12, 26));
    ret.add(new FestTag("Tag des Apostels und Evangelisten Johannes", 12, 27));
    ret.add(new FestTag("Tag der unschuldigen Kinder", 12, 28));
    ret.add(new AscherMittwoch());
    ret.add(new GruenDonnerstag());
    ret.add(new GruenDonnerstag());
    ret.add(new KarFreitag());
    ret.add(new Himmelfahrt());
    ret.add(new BussUndBettag());
    ret.add(new ErnteDank());
    return ret;
  }

  static List<WochenSpruch> getAllSonntage() {
    List<WochenSpruch> ret = [];
    for (var num = 1; num <= 4; num++) {
      ret.add(new Advent(num));
    }
    ret.add(new ErsterSoNachChristFest());
    ret.add(new ZweiterSoNachChristFest());
    for (var num = 1; num <= 5; num++) {
      ret.add(new EpiphaniasSonntag(num));
    }
    for (var num = 10; num >= 1; num--) {
      ret.add(new VorfastenUndFastenSonntag(num));
    }
    for (var num = 1; num <= 6; num++) {
      ret.add(new OsterZeit(num));
    }
    ret.add(new OsterFest());
    ret.add(new PfingstFest());
    ret.add(new TrinitatisSonntag());
    for (var num = 1; num <= 24; num++) {
      ret.add(new TrinitatisZeit(num));
    }
    ret.add(new LetzteWochen(2));
    ret.add(new LetzteWochen(3));
    ret.add(new EwigkeitsSonntag());
    return ret;
  }
}

class EwigkeitsSonntag extends WochenSpruch {
  EwigkeitsSonntag() : super("Letzter Sonntag des Kirchenjahres");

  @override
  DateTime giltAb(DateTime date) {
    DateTime ersterAdvent = ersterAdventSonntag(date.year);
    DateTime ret = ersterAdvent.add(new Duration(days: -7));
    return ret;
  }
}

class LetzteWochen extends WochenSpruch {
  late int wochenBisEnde;

  LetzteWochen(int wocheBisOster) : super("") {
    this.wochenBisEnde = wocheBisOster;
    this.tagName = sonntagsName();
  }

  String sonntagsName() {
    switch (wochenBisEnde) {
      case 2:
        return "Vorletzter Sonntag des Kirchenjahres";
      case 3:
        return "Drittletzter Sonntag des Kirchenjahres";
    }
    return "Unbekannte Letzte Woche: " + wochenBisEnde.toString();
  }

  DateTime giltAb(DateTime date) {
    DateTime ersterAdvent = ersterAdventSonntag(date.year);
    return ersterAdvent.add(Duration(days: -7 * wochenBisEnde));
  }
}

class ErnteDank extends WochenSpruch {
  ErnteDank() : super("Erntedank");

  @override
  bool istTagesSpruch() {
    return true;
  }

  @override
  DateTime giltAb(DateTime date) {
    //so nach Michaelis
    DateTime michaelisTag = new TagMittag(date.year, 09, 29);
    DateTime ret = sonntagNach(michaelisTag);
    return ret;
  }
}

class TrinitatisZeit extends WochenSpruch {
  late int nummer;

  TrinitatisZeit(int nummer)
      : super(nummer.toString() + ". Sonntag nach Trinitatis") {
    this.nummer = nummer;
  }

  @override
  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    var duration = new Duration(days: 56 + (7 * nummer));
    DateTime ret = osterSo.add(duration);
    return ret;
  }

  bool gilt(DateTime date) {
    if (super.gilt(date)) {
      DateTime ersterAdvent = ersterAdventSonntag(date.year);
      DateTime letzterTrinitatisSonntag =
      ersterAdvent.add(Duration(days: -(3 * 7)));
      if (WochenSpruch.sameDay(letzterTrinitatisSonntag, date) ||
          date.isAfter(letzterTrinitatisSonntag)) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}

class TrinitatisSonntag extends WochenSpruch {
  TrinitatisSonntag() : super("Trinitatis");

  @override
  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    DateTime ret = osterSo.add(new Duration(days: 56));
    return ret;
  }
}

class PfingstFest extends WochenSpruch {
  PfingstFest() : super("Pfingstfest");

  @override
  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    DateTime ret = osterSo.add(new Duration(days: 49));
    return ret;
  }
}

class Himmelfahrt extends WochenSpruch {
  Himmelfahrt() : super("Himmelfahrt");

  @override
  bool istTagesSpruch() {
    return true;
  }

  @override
  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    DateTime ret = osterSo.add(new Duration(days: 39));
    return ret;
  }
}

class OsterZeit extends WochenSpruch {
  late int wocheNachOstern;

  OsterZeit(int wocheBisOster) : super("") {
    this.wocheNachOstern = wocheBisOster;
    this.tagName = sonntagsName();
  }

  String sonntagsName() {
    switch (wocheNachOstern) {
      case 1:
        return "Quasimodogeniti";
      case 2:
        return "Miserikordias Domini";
      case 3:
        return "Jubilate";
      case 4:
        return "Kantate";
      case 5:
        return "Rogate";
      case 6:
        return "Exaudi";
    }
    return "Unbekannter Ostersonntag: " + wocheNachOstern.toString();
  }

  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    return osterSo.add(Duration(days: 7 * wocheNachOstern));
  }
}

class OsterFest extends WochenSpruch {
  OsterFest() : super("Osterfest");

  @override
  DateTime giltAb(DateTime date) {
    return osterSonntag(date.year);
  }
}

class VorfastenUndFastenSonntag extends WochenSpruch {
  late int wocheBisOstern;

  VorfastenUndFastenSonntag(int wocheBisOster) : super("") {
    this.wocheBisOstern = wocheBisOster;
    this.tagName = sonntagsName();
  }

  String sonntagsName() {
    switch (wocheBisOstern) {
      case 10:
        return "Letzter Sonntag nach Epiphanias";
      case 9:
        return "Septuagesimä";
      case 8:
        return "Sexagesimä";
      case 7:
        return "Estomihi";
      case 6:
        return "Invokavit";
      case 5:
        return "Reminiszere";
      case 4:
        return "Okuli";
      case 3:
        return "Lätare";
      case 2:
        return "Judika";
      case 1:
        return "Palmarum";
    }
    return "Unbekannter VorfastenSonntag: " + wocheBisOstern.toString();
  }

  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    return osterSo.add(Duration(days: -7 * wocheBisOstern));
  }
}

class FestTag extends WochenSpruch {
  late int month, day;

  FestTag(String tagName, int month, int day) : super(tagName) {
    this.month = month;
    this.day = day;
  }

  @override
  bool istTagesSpruch() {
    return true;
  }

  @override
  DateTime giltAb(DateTime date) {
    return new TagMittag(date.year, month, day);
  }
}



class AscherMittwoch extends WochenSpruch {
  AscherMittwoch() : super("Aschermittwoch");

  @override
  bool istTagesSpruch() {
    return true;
  }

  @override
  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    DateTime ret = osterSo.add(Duration(days: -46));
    return ret;
  }
}

class GruenDonnerstag extends WochenSpruch {
  GruenDonnerstag() : super("Gründonnerstag");

  @override
  bool istTagesSpruch() {
    return true;
  }

  @override
  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    DateTime ret = osterSo.add(Duration(days: -3));
    return ret;
  }
}

class KarFreitag extends WochenSpruch {
  KarFreitag() : super("Karfreitag");

  @override
  bool istTagesSpruch() {
    return true;
  }

  @override
  DateTime giltAb(DateTime date) {
    DateTime osterSo = osterSonntag(date.year);
    DateTime ret = osterSo.add(Duration(days: -2));
    return ret;
  }
}

class BussUndBettag extends WochenSpruch {
  BussUndBettag() : super("Buß- und Bettag");

  @override
  bool istTagesSpruch() {
    return true;
  }

  @override
  DateTime giltAb(DateTime date) {
    DateTime ersterAdvent = ersterAdventSonntag(date.year);
    DateTime ret = ersterAdvent.add(new Duration(days: -11));
    return ret;
  }
}


class Lichtmess extends WochenSpruch {
  Lichtmess() : super("Lichtmess");

  @override
  bool istTagesSpruch() {
    return true;
  }

  @override
  DateTime giltAb(DateTime date) {
    return new TagMittag(date.year, 02, 02);
  }
}

class EpiphaniasSonntag extends WochenSpruch {
  late int nummer;

  EpiphaniasSonntag(int nummer)
      : super(nummer.toString() + ". Sonntag nach Epiphanias") {
    this.nummer = nummer;
  }

  @override
  DateTime giltAb(DateTime date) {
    DateTime epiphanias = new TagMittag(date.year, 01, 06);
    DateTime ersterEpiSonntag = sonntagNach(epiphanias);
    DateTime gesuchterEpiSonntag =
    ersterEpiSonntag.add(new Duration(days: 7 * (nummer - 1)));
    return gesuchterEpiSonntag;
  }

  bool gilt(DateTime date) {
    if (super.gilt(date)) {
      //wenn gleich oder nach letztem Sonntag nach Epiphanias in diesem Jahr,
      //dann gibt es ihn dieses Jahr nicht
      DateTime osterSo = osterSonntag(date.year);
      DateTime letzterSonntagNachEpiphanias = osterSo.add(Duration(days: -70));
      if (WochenSpruch.sameDay(date, letzterSonntagNachEpiphanias) ||
          date.isAfter(letzterSonntagNachEpiphanias)) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}

class ZweiterSoNachChristFest extends WochenSpruch {
  ZweiterSoNachChristFest() : super("2. Sonntag nach dem Christfest");

  @override
  bool gilt(DateTime date) {
    int christFestJahr = date.month > 2 ? date.year : date.year - 1;
    DateTime christFest = new TagMittag(christFestJahr, 12, 25);
    DateTime zweiterSonntagDanach =
    sonntagNach(christFest).add(new Duration(days: 7));
    DateTime dritterSoNachChristfest =
    zweiterSonntagDanach.add(new Duration(days: 7));
    DateTime epiphanias = new TagMittag(date.year, 01, 06);
    DateTime soNachEpiphanias = sonntagNach(epiphanias);
    if (WochenSpruch.sameDay(date, soNachEpiphanias) ||
        date.isAfter(soNachEpiphanias)) {
      return false;
    }
    if (WochenSpruch.sameDay(date, zweiterSonntagDanach)) {
      return true;
    }
    return date.isAfter(zweiterSonntagDanach) &&
        date.isBefore(dritterSoNachChristfest) &&
        date.isBefore(soNachEpiphanias);
  }
}

class ErsterSoNachChristFest extends WochenSpruch {
  ErsterSoNachChristFest() : super("1. Sonntag nach dem Christfest");

  @override
  bool gilt(DateTime date) {
    int christFestJahr = date.month > 2 ? date.year : date.year - 1;
    DateTime christFest = new TagMittag(christFestJahr, 12, 25);
    DateTime ersterSonntagDanach = sonntagNach(christFest);
    DateTime zweiterSonntagDanach =
    ersterSonntagDanach.add(new Duration(days: 7));
    return WochenSpruch.sameDay(date, christFest) ||
        (date.isAfter(christFest) && date.isBefore(zweiterSonntagDanach));
  }
}

class Advent extends WochenSpruch {
  late int welcherAdvent;

  Advent(int advent) : super(advent.toString() + ". Advent") {
    welcherAdvent = advent;
  }

  @override
  DateTime giltAb(DateTime date) {
    DateTime ersterAdvent = ersterAdventSonntag(date.year);
    DateTime ret =
    ersterAdvent.add(new Duration(days: 7 * (welcherAdvent - 1)));
    return ret;
  }

  @override
  bool gilt(DateTime date) {
    if (super.gilt(date)) {
      DateTime heiligAbend = new TagMittag(date.year, 12, 24);
      if (date.isAfter(heiligAbend)) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}

DateTime sonntagVor(DateTime einDatum) {
  DateTime ret = einDatum.add(new Duration(days: -1 * einDatum.weekday));
  return ret;
}

DateTime sonntagNach(DateTime einDatum) {
  DateTime ret = einDatum.add(new Duration(days: 7 - einDatum.weekday));
  return ret;
}

DateTime ersterAdventSonntag(int jahr) {
  DateTime heiligAbend = new TagMittag(jahr, 12, 24);
  DateTime vierterAdvent =
  heiligAbend.weekday == 7 ? heiligAbend : sonntagVor(heiligAbend);
  DateTime ersterAdvent = vierterAdvent.add(Duration(days: -21));
  return ersterAdvent;
}

DateTime osterSonntag(int jahr) {
  // Divide y by 19 and call the remainder a. Ignore the quotient.
  int a = jahr % 19;
  // Divide y by 100 to get a quotient b and a remainder c.
  int b = (jahr / 100).floor();
  int c = jahr % 100;
  // Divide b by 4 to get a quotient d and a remainder e.
  int d = (b / 4).floor();
  int e = b % 4;
  // Divide 8 * b + 13 by 25 to get a quotient g. Ignore the remainder.
  int g = ((8 * b + 13) / 25).floor();
  // Divide 19 * a + b - d - g + 15 by 30 to get a remainder h. Ignore the quotient.
  int h = (19 * a + b - d - g + 15) % 30;
  // Divide c by 4 to get a quotient j and a remainder k.
  int j = (c / 4).floor();
  int k = c % 4;
  // Divide a + 11 * h by 319 to get a quotient m. Ignore the remainder.
  int m = ((a + 11 * h) / 319).floor();
  // Divide 2 * e + 2 * j - k - h + m + 32 by 7 to get a remainder r. Ignore the quotient.
  int r = (2 * e + 2 * j - k - h + m + 32) % 7;
  // Divide h - m + r + 90 by 25 to get a quotient n. Ignore the remainder.
  int n = ((h - m + r + 90) / 25).floor();
  // Divide h - m + r + n + 19 by 32 to get a remainder p.
  int p = (h - m + r + n + 19) % 32;

  DateTime ostern = new TagMittag(jahr, n, p);

  return ostern;
}

class FlexiSpruch extends WochenSpruch {
  FlexiSpruch(tagName) : super(tagName);

  @override
  bool gilt(DateTime date) {
    return true;
  }
}

class TagMittag extends DateTime {
  TagMittag(int year, int month, int day) : super(year, month, day, 12);

  TagMittag.forDateTime(DateTime dt) : super(dt.year, dt.month, dt.day, 12);
}

