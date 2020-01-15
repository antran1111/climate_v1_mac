import 'package:climate_v1_mac/services/location.dart';
import 'package:climate_v1_mac/services/networking.dart';

//refactor some of loading screen code into weather.dart
const apiKey = "d4e56fccca9313967f79eb1b87191202";
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";
const oldURL = "https://samples.openweathermap.org/data/2.5/weather";


class WeatherModel {
//datatype of futre is same type as weatherData, hold window/cmd hoover over weather data to find out datatype
  Future <dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();


    // &units=metric //metric is not working
    NetworkHelper networkHelper = NetworkHelper('$oldURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }




  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
