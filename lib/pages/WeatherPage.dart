import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/Api_key.dart';
import 'package:weatherapp/models/Weathermodel.dart';
import 'package:weatherapp/services/Weatherservice.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {

  //api key
  final _weatherService = Weatherservice(API_KEY);
  //weather object
  Weather? weather;

  //fetch weather method
  fetchWeather() async{

  //fetch city name  
  final cityName = await _weatherService.getCurrentCity();

  try{
    final fetchedWeather = await _weatherService.getWeather(cityName);

    setState(() {
      weather = fetchedWeather;
    });
  }
  catch(e){
    print(e);
  }
  }




  @override
  @override
  void initState() {
    super.initState();

    fetchWeather();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weather?.cityName ?? "Loading City..."),

            //Animation
            Lottie.asset('assets/Sunny-Animation.json'),
        
            Text("${weather?.temperature.round()}°C")
          ],
        ),
      ),
    );
  }
}