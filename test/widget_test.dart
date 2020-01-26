import 'package:flutter_test/flutter_test.dart';

import '../lib/wochenspruch.dart';

void main() {
  test('Wochenspruchgültigkeit', () {
    EpiphaniasSonntag ersterNachEpi = new EpiphaniasSonntag(1);
    expect(ersterNachEpi.gilt(new TagMittag(2020, 1, 12)), true);
    expect(ersterNachEpi.gilt(new TagMittag(2020, 1, 13)), true);
    Advent ersterAdvent = new Advent(1);
    expect(ersterAdvent.gilt(new TagMittag(2020, 11, 29)), true);
    expect(ersterAdvent.gilt(new TagMittag(2020, 12, 05)), true);
    Advent zweiterAdvent = new Advent(2);
    expect(zweiterAdvent.gilt(new TagMittag(2020, 12, 05)), false);
    expect(zweiterAdvent.gilt(new TagMittag(2020, 12, 06)), true);
    ChristFest christFest = new ChristFest();
    expect(christFest.gilt(new TagMittag(2019, 12, 26)), true);
    expect(christFest.gilt(new TagMittag(2020, 01, 3)), true);
    expect(christFest.gilt(new TagMittag(2020, 01, 5)), false);
    ZweiterSoNachChristFest zweiterSoNachChristFest =
        new ZweiterSoNachChristFest();
    expect(zweiterSoNachChristFest.gilt(new TagMittag(2020, 01, 5)), true);
    expect(zweiterSoNachChristFest.gilt(new TagMittag(2020, 01, 7)), true);
    expect(zweiterSoNachChristFest.gilt(new TagMittag(2020, 01, 13)), false);
    expect(zweiterSoNachChristFest.gilt(new TagMittag(2020, 01, 12)), false);
    expect(osterSonntag(2020), new TagMittag(2020, 4, 12));
    expect(osterSonntag(2021), new TagMittag(2021, 4, 4));
    expect(osterSonntag(2019), new TagMittag(2019, 4, 21));
    expect(osterSonntag(2024), new TagMittag(2024, 3, 31));
    EpiphaniasSonntag zweiterNachEpi = new EpiphaniasSonntag(2);
    expect(zweiterNachEpi.gilt(new TagMittag(2020, 1, 21)), true);
    EpiphaniasSonntag vierterNachEpi = new EpiphaniasSonntag(4);
    expect(vierterNachEpi.gilt(new TagMittag(2020, 2, 5)), false);
    expect(vierterNachEpi.gilt(new TagMittag(2014, 2, 5)), true);
    EpiphaniasSonntag fuenfterNachEpi = new EpiphaniasSonntag(5);
    expect(fuenfterNachEpi.gilt(new TagMittag(2019, 2, 10)), false);
    VorfastenUndFastenSonntag letzterEpi = new VorfastenUndFastenSonntag(10);
    expect(letzterEpi.gilt(new TagMittag(2019, 2, 10)), true);
    GruenDonnerstag gd = new GruenDonnerstag();
    expect(gd.gilt(new TagMittag(2024, 3, 28)), true);
    VorfastenUndFastenSonntag palmarum = new VorfastenUndFastenSonntag(1);
    expect(palmarum.gilt(new TagMittag(2020, 4, 5)), true);
    Himmelfahrt hf = new Himmelfahrt();
    expect(hf.gilt(new TagMittag(2024, 5, 9)), true);
    expect(hf.gilt(new TagMittag(2025, 5, 29)), true);
    PfingstFest pf = new PfingstFest();
    expect(pf.gilt(new TagMittag(2019, 6, 9)), true);
    expect(pf.gilt(new TagMittag(2024, 5, 22)), true);
    TrinitatisSonntag trini = new TrinitatisSonntag();
    expect(trini.gilt(new TagMittag(2019, 6, 18)), true);
    ErnteDank ed = new ErnteDank();
    expect(ed.gilt(new TagMittag(2019, 09, 29)), true);
    TrinitatisZeit trini19 = new TrinitatisZeit(19);
    expect(trini19.gilt(new TagMittag(2019, 11, 02)), true);
    TrinitatisZeit trini20 = new TrinitatisZeit(20);
    expect(trini20.gilt(new TagMittag(2019, 11, 02)), false);
    VorfastenUndFastenSonntag lastEpi = new VorfastenUndFastenSonntag(10);
    expect(lastEpi.gilt(new TagMittag(2020, 02, 02)), true);
    Advent vierterAdven = new Advent(4);
    expect(vierterAdven.gilt(new TagMittag(2023, 12, 24)), true);
    for (int year = 2019; year <= 2032; year++) {
      //kein Tag mit uneindeutigem Wochenspruch
      DateTime eintag = new TagMittag(year, 1, 1);
      List<WochenSpruch> sonntage = WochenSpruch.getAllSonntage();
      for (int i = 0; i < 365; i++) {
        eintag = eintag.add(new Duration(days: 1));
        WochenSpruch nurEiner = null;
        for (WochenSpruch ws in sonntage) {
          if (ws.gilt(eintag)) {
            if (nurEiner != null) {
              fail("Mehr als ein Sonntag für: " +
                  eintag.toString() +
                  "; einmal: " +
                  nurEiner.toString() +
                  " | sowie: " +
                  ws.toString());
            } else {
              nurEiner = ws;
            }
          }
        }
      }
      //kein Tag ohne  Wochenspruch
      eintag = new TagMittag(year, 1, 1);
      for (int i = 0; i < 365; i++) {
        eintag = eintag.add(new Duration(days: 1));
        WochenSpruch spruchtGilt = null;
        for (WochenSpruch ws in sonntage) {
          if (ws.gilt(eintag)) {
            spruchtGilt = ws;
          }
        }
        if (spruchtGilt == null) {
          fail("Kein gültiger Wochenspruch für: " + eintag.toString());
        }
      }
    }
  });
}
