import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:location/location.dart' as lo;
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class DataProvider with ChangeNotifier {
  final tinyDB = Hive.box('usr');
  String? country;
  DataProvider({this.country = 'IN'});
  List<Placemark>? data;
  String error = '';
  lo.LocationData? locationData;
  final tran = Xml2Json();
  Map? countrydata;

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      error = 'Location services are disabled.';
      notifyListeners();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        error = 'Location permissions are denied';
        notifyListeners();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      error =
          'Location permissions are permanently denied, we cannot request permissions.';
      notifyListeners();
    }
    locationData = await lo.Location.instance.getLocation();
    data = await placemarkFromCoordinates(
        locationData!.latitude!, locationData!.longitude!);
    tinyDB.put('Country', '${data![0].isoCountryCode}');
    tinyDB.put('lat', '${locationData!.latitude!}');
    tinyDB.put('lng', '${locationData!.longitude!}');
    notifyListeners();
    getcountryinfo('${data![0].isoCountryCode}');
    // getcountry('${locationData!.latitude!}', '${locationData!.longitude!}');
  }

  // Get Country
  /*  getcountry(String lat, String lng) async {
    final client = http.Client();
    final body = {'lat': lat, 'lng': lng};
    final url = Uri.http('api.geonames.org', 'countryCode');
    final response = await client.post(url, body: body);
    print(response.body);
  }  */

  // Get Country Info
  getcountryinfo(String cntry) async {
    try {
      final client = http.Client();
      final url = Uri.http('api.geonames.org', 'countryInfo');
      final body = {'country': cntry, 'username': 'medcollapp'};
      final response = await client.post(url, body: body);
      tran.parse(response.body);
      final json = tran.toParker();
      countrydata = jsonDecode(json) as Map;
      error = 'no';
      notifyListeners();
    } catch (e) {
      error = 'Somthing went wrong!';
      notifyListeners();
    }
  }
}
