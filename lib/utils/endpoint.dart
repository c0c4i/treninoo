const String URL = "www.viaggiatreno.it";

const bool isProd = false;
const String BASE_URL = isProd ? "api.treninoo.it" : "api.treninoo.it";

const String prefix = isProd ? '/v1' : '/test';

class Endpoint {
  static const String AUTOCOMPLETE_VIAGGIOTRENO = '$prefix/autocomplete/';
  static const String AUTOCOMPLETE_LEFRECCE = '$prefix/lefrecce/autocomplete/';
  static const String FOLLOWTRAIN_STATIONS = '$prefix/followtrain';
  static const String FEEDBACK = '$prefix/feedback';
  static const String DEPARTURE_STATION = '$prefix/departurestation';
  static const String SOLUTIONS_LEFRECCE = '$prefix/lefrecce/solutions';
  static const String STATION_DETAILS_VIAGGIOTRENO = '$prefix/stations';
}

class ViaggioTreno {
  /// ... + trainCode
  static const String GET_STATION_CODE =
      '/infomobilita/resteasy/viaggiatreno/cercaNumeroTrenoTrenoAutocomplete/';

  // ... + stationCode/trainCode
  static const String GET_TRAIN_INFO =
      '/infomobilita/resteasy/viaggiatreno/andamentoTreno/';

  static const String GET_STATION =
      '/infomobilita/resteasy/viaggiatreno/autocompletaStazione/';

  // ... + departureStationCode/arrivalStationCode/date
  static const String GET_SOLUTIONS =
      '/infomobilita/resteasy/viaggiatreno/soluzioniViaggioNew/';

  // ... + stationCode/date
  static const String GET_DEPARTURE_TRAINS =
      '/infomobilita/resteasy/viaggiatreno/partenze/';

  // ... + stationCode/date
  static const String GET_ARRIVAL_TRAINS =
      '/infomobilita/resteasy/viaggiatreno/arrivi/';
}
