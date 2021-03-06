import 'index.dart';

// API key burtoliverco@gmail.com
const apikey = '79606421b40eac4780d23b69202b4a56';
const openMapUrl = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityname) async {
    NetworkHelper helper =
        NetworkHelper("$openMapUrl?q=$cityname&appid=$apikey&units=Metric");

    var weatherData = await helper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper helper = NetworkHelper(
        "$openMapUrl?lat=${location.lat}&lon=${location.long}&appid=$apikey&units=metric");

    // ! Hard Coded sample
    //NetworkHelper helper = NetworkHelper("http://api.openweathermap.org/data/2.5/weather?lat=37.4219983&lon=-122.084&appid=cb38a55db72eaa80ba69e7a8fe4e358e&units=Metric");
    var weatherData = await helper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
