const String URL = "www.viaggiatreno.it";

const bool isProd = true;
const String BASE_URL =
    isProd ? "cityhelper.app" : "cityhelper.wesellbrain.com";

class Endpoint {
  static const String AUTOCOMPLETE =
      (isProd ? '/treninoo' : '/treninoo') + '/autocomplete/';
  static const String FOLLOWTRAIN_STATIONS =
      (isProd ? '/treninoo' : '/treninoo') + '/followtrain';
}

/// ... + trainCode
const String GET_STATION_CODE =
    '/infomobilita/resteasy/viaggiatreno/cercaNumeroTrenoTrenoAutocomplete/';

// ... + stationCode/trainCode
const String GET_TRAIN_INFO =
    '/infomobilita/resteasy/viaggiatreno/andamentoTreno/';

const String GET_STATION =
    '/infomobilita/resteasy/viaggiatreno/autocompletaStazione/';

// ... + departureStationCode/arrivalStationCode/date
const String GET_SOLUTIONS =
    '/infomobilita/resteasy/viaggiatreno/soluzioniViaggioNew/';

// ... + stationCode/date
const String GET_DEPARTURE_TRAINS =
    '/infomobilita/resteasy/viaggiatreno/partenze/';

// ... + stationCode/date
const String GET_ARRIVAL_TRAINS = '/infomobilita/resteasy/viaggiatreno/arrivi/';
