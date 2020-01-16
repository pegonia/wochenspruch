import 'package:flutter/material.dart';

import 'spruchfactory.dart';
import 'wochenspruch.dart';

void main() => runApp(WochenspruchApp());

class WochenspruchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wochenspruch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Empfang(title: 'Wochenspruch heute'),
    );
  }

}

class Empfang extends StatefulWidget {
  Empfang({Key key, this.title}) : super(key: key);
  String title;

  @override
  EmpfangState createState() => EmpfangState();
}

class EmpfangState extends State<Empfang> with WidgetsBindingObserver {
  WochenspruchFactory spruecheKlopfer = new WochenspruchFactory();
  SpruchRep wochenSpruch;
  SpruchRep tagesSpruch;

  @override
  Widget build(BuildContext context) {
    if (wochenSpruch == null) {
      wochenSpruch = spruecheKlopfer.wochenSpruch(DateTime.now());
      tagesSpruch = spruecheKlopfer.tagesSpruch(DateTime.now());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              wochenSpruch.tagName,
            ),
            Text(
              wochenSpruch.spruchText,
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              "(" + wochenSpruch.bibelStelle + ")",
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            Text(
              tagesSpruch.tagName,
            ),
            Text(
              tagesSpruch.spruchText,
              style: Theme.of(context).textTheme.subtitle,
            ),
            Text(
              tagesSpruch.bibelStelle.toString().isEmpty
                  ? ""
                  : "(" + tagesSpruch.bibelStelle + ")",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickDate,
        tooltip: "Datum wählen",
        child: Icon(Icons.date_range),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      zeigeDatum(DateTime.now());
    });
  }
  Future<void> pickDate() async {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2060),
    );
    DateTime dt = await selectedDate;
    if (dt == null) {
      dt = DateTime.now();
    }
    setState(() {
      zeigeDatum(dt);
    });
  }

  String formatDate(DateTime dt) {
    if (dt == null) {
      return "";
    } else
      return dt.day.toString() +
          ". " +
          zeigeMonat(dt.month) +
          " " +
          dt.year.toString();
  }

  String zeigeMonat(int month) {
    switch (month) {
      case 1:
        return "Januar";
        break;
      case 2:
        return "Februar";
        break;
      case 3:
        return "März";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "Mai";
        break;
      case 6:
        return "Juni";
        break;
      case 7:
        return "Juli";
        break;
      case 8:
        return "August";
        break;
      case 9:
        return "September";
        break;
      case 10:
        return "Oktober";
        break;
      case 11:
        return "November";
        break;
      case 12:
        return "Dezember";
        break;
    }
    return "";
  }

  void zeigeDatum(DateTime dt) {
    wochenSpruch = spruecheKlopfer.wochenSpruch(dt);
    tagesSpruch = spruecheKlopfer.tagesSpruch(dt);
    if (WochenSpruch.sameDay(DateTime.now(), dt)) {
      widget.title = "Wochenspruch heute";
    } else {
      widget.title = formatDate(dt);
    }
  }
}

