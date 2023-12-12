import 'dart:collection';
import 'dart:math';

import 'spruch_dataset.dart';
import 'wochenspruch.dart';

class WochenspruchFactory {
  HashMap<String, SpruchRep> spruchDaten = new HashMap();
  late String csvRaw;

  WochenspruchFactory() {
    readSprueche();
  }

  SpruchRep zufallsSpruch() {
    var rng = new Random();
    int index = rng.nextInt(spruchDaten.length);
    return spruchDaten.values.toList().elementAt(index);
  }

  SpruchRep wochenSpruch(DateTime dt) {
    if (dt == null) {
      return SpruchRep.EMPTY;
    }
    dt = new TagMittag.forDateTime(dt);
    String tagName="";
    for (WochenSpruch ws in WochenSpruch.getAllSonntage()) {
      if (ws.gilt(dt)) {
        tagName = ws.tagName;
        break;
      }
    }
    if (spruchDaten.containsKey(tagName!)) {
      SpruchRep? ret = spruchDaten[tagName];
      return ret!;
    } else {
      return new SpruchRep(tagName, "--", "Keinen Spruch gefunden");
    }
  }

  SpruchRep tagesSpruch(DateTime dt) {
    if (dt == null) {
      return SpruchRep.EMPTY;
    }
    dt = new TagMittag.forDateTime(dt);
    String tagName = "";
    for (WochenSpruch ws in WochenSpruch.getAllEinzelFestTage()) {
      if (ws.gilt(dt)) {
        tagName = ws.tagName;
        break;
      }
    }
    if (tagName.isNotEmpty  && spruchDaten.containsKey(tagName)) {
      return spruchDaten[tagName]!;
    } else {
      return SpruchRep.EMPTY;
    }
  }

  readSprueche() {
    SpruchDaten wa = new SpruchDaten();
    for (String line in wa.wochenSpruchZeilen) {
      List row = line.split('|');
      SpruchRep es = new SpruchRep(row[0], row[1], row[2]);
      spruchDaten[es.tagName] = es;
    }
  }
}

class SpruchRep {
  static final SpruchRep EMPTY = new SpruchRep("", "", "");
  var tagName;
  var bibelStelle;
  var spruchText;

  SpruchRep(tagName, bibelStelle, spruchText) {
    this.tagName = tagName;
    this.bibelStelle = bibelStelle;
    this.spruchText = spruchText;
  }
}

