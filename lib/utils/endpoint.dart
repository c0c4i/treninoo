const String URL = "www.viaggiatreno.it";

const bool isProd = false;
const String BASE_URL =
    isProd ? "cityhelper.app" : "520d-128-116-164-128.eu.ngrok.io";

class Endpoint {
  static const String AUTOCOMPLETE =
      (isProd ? '/treninoo' : '') + '/autocomplete/';
  static const String FOLLOWTRAIN_STATIONS =
      (isProd ? '/treninoo' : '') + '/followtrain';
}

/// ... + trainCode
const String GET_STATION_CODE =
    '/viaggiatrenonew/resteasy/viaggiatreno/cercaNumeroTrenoTrenoAutocomplete/';

// ... + stationCode/trainCode
const String GET_TRAIN_INFO =
    '/viaggiatrenonew/resteasy/viaggiatreno/andamentoTreno/';

const String GET_STATION =
    '/viaggiatrenonew/resteasy/viaggiatreno/autocompletaStazione/';

// ... + departureStationCode/arrivalStationCode/date
const String GET_SOLUTIONS =
    '/viaggiatrenonew/resteasy/viaggiatreno/soluzioniViaggioNew/';

// ... + stationCode/date
const String GET_DEPARTURE_TRAINS =
    '/viaggiatrenonew/resteasy/viaggiatreno/partenze/';

// ... + stationCode/date
const String GET_ARRIVAL_TRAINS =
    '/viaggiatrenonew/resteasy/viaggiatreno/arrivi/';
