// import 'package:http/http.dart' as http;

// int main() {
//   print("Hello word");

//   String name = "vero";
//   getSolutions(name).then((l) {
//     print(l);
//   });

//   return 0;
// }

// String URL_LISTA_STAZIONI =
//     "http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno/autocompletaStazione/";

// Future<String> getSolutions(String name) async {
//   http.Response responseStationCode = await http.get(URL_LISTA_STAZIONI + name);
//   String text = responseStationCode.body;
//   return text;
// }
