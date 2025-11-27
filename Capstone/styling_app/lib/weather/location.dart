import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude2;
  late double longitude2;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission =
          await Geolocator.requestPermission(); //위치 접근 허용 여부

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;

    } catch (e) {
      print('There was a problem with the internet connection.');
    }
  }
}
