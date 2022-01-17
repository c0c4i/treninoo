import 'package:http/http.dart' as http;

void main() async {
  for (var i = 0; i < 100; i++) {
    var url = Uri.parse(
        'http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/cercaNumeroTrenoTrenoAutocomplete/$i');
    var response = await http.get(url);
    if (response.body.split('\n').length > 1) {
      print(response.body + "\n\n");
    }
  }
}
