import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  //await works on future only, see loadingscreen.dart
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}


/*
double weatherT = decodedData['main']['temp'];
print('Temperature: ' + weatherT.toString());

int weatherC = decodedData['weather'][0]['id'];
print('Condition: $weatherC');

int weatherH = decodedData['main']['humidity'];
print('Humidity: $weatherH');

String weatherL = decodedData['name'];
print('Location: ' + weatherL);*/
