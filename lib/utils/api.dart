import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/utils/endpoint.dart';

// ... + trainCode
const String URL_STATION_CODE =
    'http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno/cercaNumeroTrenoTrenoAutocomplete/';

// ... + stationCode/trainCode
const String URL_TRAIN_INFO =
    'http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno/andamentoTreno/';

const String URL_STATION_NAME =
    'http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno/autocompletaStazione/';

// ... + departureStationCode/arrivalStationCode/date
const String URL_SOLUTIONS =
    'http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno/soluzioniViaggioNew/';

final RegExp rgxTrainCode = RegExp(r"\|.+-(\S+)$");

// Ritorna il numero di treni con il numero cercato
// Future<int> getAvailableNumberOfTrain(String trainCode) async {
//   if (trainCode.length == 0) throw new ArgumentError();
//   http.Response responseStationCode =
//       await http.get(URL_STATION_CODE + trainCode);
//   if (responseStationCode.statusCode != 200) throw new Error();

//   return responseStationCode.body.split('\n').length - 1;
// }

// Ritorna il codice della stazione di partenza del treno
// Future<String> getSpecificStationCode(String trainCode) async {
//   http.Response responseStationCode =
//       await http.get(URL_STATION_CODE + trainCode);
//   var text = responseStationCode.body;
//   if (text.isEmpty) return null;

//   var lines = text.split('\n');
//   var details = lines[0].split("|")[1].split("-");

//   return details[1];
// }

// converte tempo unix in stringa oo:mm
String timeStampToString(int timeStampMillisecond) {
  if (timeStampMillisecond == null) return null;

  var dateTime = new DateTime.fromMillisecondsSinceEpoch(timeStampMillisecond);

  if (dateTime.minute < 10) return "${dateTime.hour}:0${dateTime.minute}";
  return "${dateTime.hour}:${dateTime.minute}";
}

// ritorna una mappa <stationCode, trainType>
// Future<Map<String, String>> getMultipleTrainsType(String trainCode) async {
//   LinkedHashMap<String, String> multipleStation =
//       new LinkedHashMap<String, String>();

//   Uri uri = Uri.parse(URL_STATION_CODE + trainCode);
//   http.Response responseStationCode = await http.get(uri);
//   if (responseStationCode.statusCode != 200) throw new Error();

//   var lines = responseStationCode.body.split('\n');

//   String trainType;
//   String stationCode;

//   for (var i = 0; i < lines.length - 1; i++) {
//     stationCode = rgxTrainCode.firstMatch(lines[i]).group(1);
//     trainType = await getTrainType(stationCode, trainCode);
//     multipleStation.putIfAbsent(stationCode, () => trainType);
//   }
//   return multipleStation;
// }

// ritorna il tipo di treno cercato
// Future<String> getTrainType(String stationCode, String trainCode) async {
//   Uri uri = Uri.parse(URL_TRAIN_INFO + stationCode + '/' + trainCode);
//   final http.Response responseTypeTrain = await http.get(uri);
//   var text = responseTypeTrain.body;
//   if (responseTypeTrain.statusCode == 200)
//     return json.decode(text)['categoria'];
//   else
//     return "NaN";
// }

// DEPRECATED
// Controlla se un treno esiste o no
// Future<bool> verifyIfTrainExist(String stationCode, String trainCode) async {
//   if (trainCode.length == 0 || stationCode.length == 0)
//     throw new ArgumentError();

//   DateTime now = new DateTime.now();
//   DateTime date = new DateTime(now.year, now.month, now.day);
//   String timestamp = date.millisecondsSinceEpoch.toString();

//   String urlStationCode =
//       URL_TRAIN_INFO + stationCode + '/' + trainCode + '/' + timestamp;
//   print(urlStationCode);
//   http.Response responseStationCode = await http.get(urlStationCode);

//   if (responseStationCode.body.isEmpty) return false;

//   if (responseStationCode.statusCode == 204) return false;

//   if (responseStationCode.statusCode != 200) throw new Error();

//   return true;
// }

// Future<List<Station>> getStationListStartWith(String searched) async {
//   List<Station> stationList = [];

//   http.Response responseStationCode =
//       await http.get(URL_STATION_NAME + searched);
//   if (responseStationCode.statusCode != 200) throw new Error();

//   var lines = responseStationCode.body.split('\n');

//   for (var i = 0; i < lines.length - 1; i++) {
//     String stationCode = lines[i].split("|")[1].replaceAll("\n", "");
//     String stationName = lines[i].split("|")[0].split("\n")[0];
//     stationList
//         .add(new Station(stationName: stationName, stationCode: stationCode));
//   }
//   return stationList;
// }

// NEW API - AUTOCOMPLETE
Future<List<Station>> getStationListStartWith(String searched) async {
  var uri = Uri.http(BASE_URL, Endpoint.AUTOCOMPLETE + searched);
  var response = await http.get(uri);
  var body = jsonDecode(response.body);

  return List<Station>.from(
      body['stations'].map((station) => Station.fromJson(station)));
}

// DEPRECATED
// String getStationCodeByStationName(String name, List<Station> l) {
//   for (var element in l) {
//     if (element.stationName == name) {
//       return element.stationCode;
//     }
//   }
//   return null;
// }


// DEPRECATED
// Future<String> getStationCodeFromStationName(String stationName) async {
//   http.Response responseStationCode =
//       await http.get(URL_STATION_NAME + stationName);
//   if (responseStationCode.statusCode != 200) throw new Error();

//   String stationCode =
//       responseStationCode.body.split("|")[1].substring(2).replaceAll("\n", "");

//   return stationCode;
// }
