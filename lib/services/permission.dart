import 'package:geolocator/geolocator.dart';

class PermissionService {
  var status = Geolocator.checkPermission();

  initLocationService() async {
    if (await status == LocationPermission.denied) {
      Geolocator.requestPermission();
    } else if (await status == LocationPermission.unableToDetermine) {
      Geolocator.requestPermission();
    }
  }
}
