import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/utils/location_service.dart';
import 'package:treninoo/utils/shared_preference.dart';
import 'package:treninoo/utils/endpoint.dart';

class NearbyStation {
  final Station station;
  final double distanceKm;

  NearbyStation({required this.station, required this.distanceKm});
}

class NearbyStationsService {
  static Dio? _dio;
  static SharedPrefs? _sharedPrefs;
  static List<Map<String, dynamic>>? _stationsCache;

  /// Initializes the service (call once during app init).
  static void initialize(Dio dio, SharedPrefs sharedPrefs) {
    _dio = dio;
    _sharedPrefs = sharedPrefs;
  }

  /// Syncs station data with the server using hash-based validation.
  ///
  /// Sends the locally cached hash to GET /stations/sync?hash=HASH.
  /// - If the server responds { status: 'ok' }, the local data is current.
  /// - If the server responds { status: 'updated', hash, data }, saves
  ///   the new data and hash to SharedPreferences.
  /// - Falls back to local cache or bundled JSON on any error.
  static Future<List<Map<String, dynamic>>> _loadStationDatabase() async {
    if (_stationsCache != null) return _stationsCache!;

    if (_dio == null || _sharedPrefs == null) {
      return _loadFallbackDatabase();
    }

    try {
      final cachedHash = _sharedPrefs!.cachedStationsHash ?? '';

      final response = await _dio!.get(
        Endpoint.STATIONS_SYNC,
        queryParameters: {'hash': cachedHash},
      );

      final data = response.data as Map<String, dynamic>;

      if (data['status'] == 'ok') {
        // Server confirmed our data is current — use local cache
        final cached = _getCachedStations();
        if (cached.isNotEmpty) {
          _stationsCache = cached;
          return cached;
        }
        // Hash exists but no local data — clear stale hash and force re-fetch
        _sharedPrefs!.cachedStationsHash = null;
        final freshResponse = await _dio!.get(
          Endpoint.STATIONS_SYNC,
          queryParameters: {'hash': ''},
        );
        final freshData = freshResponse.data as Map<String, dynamic>;
        if (freshData['status'] == 'updated') {
          final stations = List<Map<String, dynamic>>.from(
            (freshData['data'] as List).map((s) => s as Map<String, dynamic>),
          );
          _updateCache(stations, freshData['hash'] as String);
          _stationsCache = stations;
          return stations;
        }
        return _loadFallbackDatabase();
      }

      if (data['status'] == 'updated') {
        // Server sent new data
        final stations = List<Map<String, dynamic>>.from(
          (data['data'] as List).map((s) => s as Map<String, dynamic>),
        );
        final newHash = data['hash'] as String;
        _updateCache(stations, newHash);
        _stationsCache = stations;
        return stations;
      }

      // Unexpected response
      return _getCachedOrFallback();
    } catch (e) {
      return _getCachedOrFallback();
    }
  }

  /// Loads the bundled fallback JSON for development or offline use.
  static Future<List<Map<String, dynamic>>> _loadFallbackDatabase() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/stations_coordinates.json');
      final List<dynamic> decoded = jsonDecode(jsonString);
      _stationsCache = decoded.cast<Map<String, dynamic>>();
      return _stationsCache!;
    } catch (_) {
      return [];
    }
  }

  /// Returns cached stations from SharedPreferences, or falls back to
  /// the bundled JSON.
  static Future<List<Map<String, dynamic>>> _getCachedOrFallback() async {
    final cached = _getCachedStations();
    if (cached.isNotEmpty) {
      _stationsCache = cached;
      return cached;
    }
    return _loadFallbackDatabase();
  }

  /// Reads cached station JSON from SharedPreferences.
  static List<Map<String, dynamic>> _getCachedStations() {
    final raw = _sharedPrefs?.cachedStationsData;
    if (raw == null) return [];
    try {
      final List<dynamic> decoded = jsonDecode(raw);
      return decoded.cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  /// Persists station data and its hash to SharedPreferences.
  static void _updateCache(List<Map<String, dynamic>> stations, String hash) {
    _sharedPrefs?.cachedStationsData = jsonEncode(stations);
    _sharedPrefs?.cachedStationsHash = hash;
  }

  /// Returns the nearest stations to the user's current GPS position.
  /// All computation is done on-device — no location data is sent anywhere.
  static Future<List<NearbyStation>> getNearbyStations({
    int limit = 5,
  }) async {
    final position = await LocationService.getCurrentPosition();
    if (position == null) return [];

    final stations = await _loadStationDatabase();

    final List<NearbyStation> withDistances = stations.where((s) {
      final name = s['stationName']?.toString().trim();
      return name != null && name.isNotEmpty;
    }).map((s) {
      final distance = _haversineKm(
        position.latitude,
        position.longitude,
        double.parse(s['lat'].toString()),
        double.parse(s['lng'].toString()),
      );
      String capitalizeName(String? text) {
        if (text == null || text.isEmpty) return '';
        return text.split(' ').map((word) {
          if (word.isEmpty) return word;
          return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
        }).join(' ');
      }

      return NearbyStation(
        station: Station(
          stationName: capitalizeName(s['stationName']?.toString()),
          // Use lefrecceStationCode if available (for API compatibility), fallback to stationCode
          stationCode: s['lefrecceStationCode'] ?? s['stationCode'],
        ),
        distanceKm: distance,
      );
    }).toList();

    withDistances.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));

    return withDistances.take(limit).toList();
  }

  /// Haversine formula — computes the great-circle distance in km between
  /// two points given their latitude and longitude in degrees.
  static double _haversineKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadiusKm = 6371.0;

    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusKm * c;
  }

  static double _degToRad(double deg) => deg * (pi / 180);
}
