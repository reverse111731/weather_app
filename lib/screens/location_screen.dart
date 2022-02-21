import 'package:flutter/material.dart';

import 'index.dart';
import 'package:weather_app/utilities/index.dart';
import 'package:weather_app/services/index.dart';

const String imageLocation = 'images/location_background.jpg';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int? temperature;
  String? wIcon;
  String? wMessage;
  String? name;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        wIcon = 'Error';
        wMessage = 'Unable to get data';
        name = '';
        return;
      } else {
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        name = weatherData['name'];

        wIcon = weatherModel.getWeatherIcon(condition!);
        wMessage = weatherModel.getMessage(temperature!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(imageLocation),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var typeNamed = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const CityScreen();
                        }),
                      );
                      //print(typeNamed);
                      if (typeNamed != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typeNamed);

                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$wIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$wMessage in $name!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
