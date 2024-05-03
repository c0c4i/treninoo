const bool isProd = true;
const String BASE_URL =
    isProd ? "https://api.treninoo.it" : "https://api.treninoo.it";

const String prefix = isProd ? '/v1' : '/test';

class Endpoint {
  static const String AUTOCOMPLETE_VIAGGIOTRENO = '$prefix/autocomplete/';
  static const String AUTOCOMPLETE_LEFRECCE = '$prefix/lefrecce/autocomplete/';
  static const String FOLLOWTRAIN_STATIONS = '$prefix/followtrain';
  static const String FEEDBACK = '$prefix/feedback';
  static const String DEPARTURE_STATION = '$prefix/departurestation';
  static const String SOLUTIONS_LEFRECCE = '$prefix/lefrecce/solutions';
  static const String STATION_DETAILS_VIAGGIOTRENO = '$prefix/stations';
  static const String TRAIN_INFO_VIAGGIOTRENO = '$prefix/details';
}
