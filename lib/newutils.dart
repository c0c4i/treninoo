import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:treninoo/utils.dart';

// // ... + trainCode
// const String URL_STATION_CODE =
//     'https://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/cercaNumeroTrenoTrenoAutocomplete/';

// // ... + stationCode/trainCode
// const String URL_TRAIN_INFO =
//     'https://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/andamentoTreno/';

// const String URL_STATION_NAME =
//     'https://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/autocompletaStazione/';

// // ... + departureStationCode/arrivalStationCode/date
// const String URL_SOLUTIONS =
//     'https://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/soluzioniViaggioNew/';

const LOCALHOST = "http://localhost:3000";
const HOST_ONLINE = "https://c0c4i.herokuapp.com";

// ... + trainCode
const String URL_STATION_CODE = HOST_ONLINE + '/api/treninoo/departurestation/';

// ... + stationCode/trainCode
const String URL_TRAIN_INFO = HOST_ONLINE + '/api/treninoo/details/';

const String URL_STATION_NAME = HOST_ONLINE + '/api/treninoo/autocomplete/';

// ... + departureStationCode/arrivalStationCode/date
const String URL_SOLUTIONS = HOST_ONLINE + '/api/treninoo/solutions/';

const int SEARCH_TRAIN_STATUS = 0;
const int SHOW_TRAIN_STATUS = 1;
const int SEARCH_SOLUTIONS = 0;
const int SHOW_SOLUTIONS = 1;

final RegExp rgxTrainCode = RegExp(r"\|.+-(\S+)$");

// Utilizzato per far scegliere il treno quando hanno lo stesso numero
Map<String, String> trainNames = {
  "REG": "Regionale",
  "EC": "EuroCity",
  "IC": "Intercity",
  "FR": "Frecciarossa"
};

Map<String, String> trainAcronym = {
  "Regionale": "REG",
  "EuroCity": "EC",
  "Intercity": "IC",
  "Frecciarossa": "FR"
};

Map<String, String> trainTypeFromNumber = {
  "246": "FR",
  "235": "RV",
  "197": "REG",
  "196": "REG",
  "205": "EC",
  "214": "IC"
};

// Ritorna il numero di treni con il numero cercato
Future<int> getAvailableNumberOfTrain(String trainCode) async {
  if (trainCode.length == 0) throw new ArgumentError();
  http.Response responseStationCode =
      await http.get(URL_STATION_CODE + trainCode);
  if (responseStationCode.statusCode != 200) throw new Error();

  return responseStationCode.body.split('\n').length - 1;
}

// Ritorna il codice della stazione di partenza del treno
Future<String> getSpecificStationCode(String trainCode) async {
  http.Response responseStationCode =
      await http.get(URL_STATION_CODE + trainCode);
  var text = responseStationCode.body;
  var lines = text.split('\n');
  return rgxTrainCode.firstMatch(lines[0]).group(1);
}

// converte tempo unix in stringa oo:mm
String timeStampToString(int timeStampMillisecond) {
  if (timeStampMillisecond == null) return null;

  var dateTime = new DateTime.fromMillisecondsSinceEpoch(timeStampMillisecond);

  if (dateTime.minute < 10) return "${dateTime.hour}:0${dateTime.minute}";
  return "${dateTime.hour}:${dateTime.minute}";
}

// ritorna una mappa <stationCode, trainType>
Future<Map<String, String>> getMultipleTrainsType(String trainCode) async {
  LinkedHashMap<String, String> multipleStation =
      new LinkedHashMap<String, String>();

  http.Response responseStationCode =
      await http.get(URL_STATION_CODE + trainCode);
  if (responseStationCode.statusCode != 200) throw new Error();

  var lines = responseStationCode.body.split('\n');

  String trainType;
  String stationCode;

  for (var i = 0; i < lines.length - 1; i++) {
    stationCode = rgxTrainCode.firstMatch(lines[i]).group(1);
    trainType = await getTrainType(stationCode, trainCode);
    multipleStation.putIfAbsent(stationCode, () => trainType);
  }
  return multipleStation;
}

// ritorna il tipo di treno cercato
Future<String> getTrainType(String stationCode, String trainCode) async {
  String urlTypeTrain = URL_TRAIN_INFO + stationCode + '/' + trainCode;
  final http.Response responseTypeTrain = await http.get(urlTypeTrain);
  var text = responseTypeTrain.body;
  if (responseTypeTrain.statusCode == 200)
    return json.decode(text)['categoria'];
  else
    return "NaN";
}

// Controlla se un treno esiste o no
Future<bool> verifyIfTrainExist(String stationCode, String trainCode) async {
  if (trainCode.length == 0 || stationCode.length == 0)
    throw new ArgumentError();

  String urlStationCode = URL_TRAIN_INFO + stationCode + '/' + trainCode;
  print(urlStationCode);
  http.Response responseStationCode = await http.get(urlStationCode);

  if (responseStationCode.body.isEmpty) return false;

  if (responseStationCode.statusCode == 204) return false;

  if (responseStationCode.statusCode != 200) throw new Error();

  return true;
}

Future<List<Station>> getStationListStartWith(String searched) async {
  List<Station> stationList = new List<Station>();

  http.Response responseStationCode =
      await http.get(URL_STATION_NAME + searched);
  if (responseStationCode.statusCode != 200) throw new Error();

  var lines = responseStationCode.body.split('\n');

  String stationCode;
  String stationName;

  for (var i = 0; i < lines.length - 1; i++) {
    stationCode = lines[i].split("|")[1].substring(2).replaceAll("\n", "");
    stationName = lines[i].split("|")[0].split("\n")[0];
    stationList
        .add(new Station(stationName: stationName, stationCode: stationCode));
  }
  return stationList;
}

String getStationCodeByStationName(String name, List<Station> l) {
  for (var element in l) {
    if (element.stationName == name) {
      return element.stationCode;
    }
  }
  return null;
}

Future<String> getStationCodeFromStationName(String stationName) async {
  http.Response responseStationCode =
      await http.get(URL_STATION_NAME + stationName);
  if (responseStationCode.statusCode != 200) throw new Error();

  String stationCode =
      responseStationCode.body.split("|")[1].substring(2).replaceAll("\n", "");

  return stationCode;
}

String addZeroToNumberLowerThan10(String n) {
  return (n.length < 2) ? "0$n" : n;
}

String getCustomDate(DateTime d) {
  String day = addZeroToNumberLowerThan10(d.day.toString());
  String month = addZeroToNumberLowerThan10(d.month.toString());
  String year = addZeroToNumberLowerThan10(d.year.toString());

  return "$day/$month/$year";
}

String getCustomTime(DateTime d) {
  String hour = addZeroToNumberLowerThan10(d.hour.toString());
  String minute = addZeroToNumberLowerThan10(d.minute.toString());

  return "$hour:$minute";
}
