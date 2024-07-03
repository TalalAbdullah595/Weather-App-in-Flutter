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

  //Weather animations
  String getWeatherAnimations(String? mainCondition){
    if (mainCondition == null){
      return "assets/Sunny-Animation.json";
    }

    switch(mainCondition.toLowerCase()){
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/Cloudy-Animation.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/Rainy-Animation.json";
      case "thunderstorm":
        return "assets/Thunderstorm-Animation.json";
      case "clear":
        return "assets/Sunny-Animation.json";
      default:
        return "assets/Sunny-Animation.json";
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
      backgroundColor: Colors.grey[350],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_pin, color: Colors.grey,),
              Text(weather?.cityName ?? "Loading City...", style: TextStyle(fontSize: 20, color: Colors.grey[600], fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 50,),
          //Animation
          Lottie.asset(getWeatherAnimations(weather?.mainCondition)),
      
          Text("${weather?.temperature.round()}°C",style: TextStyle(fontSize: 20, color: Colors.grey[600], fontWeight: FontWeight.bold),),
      
          Text(weather?.mainCondition ?? "",style: TextStyle(fontSize: 20, color: Colors.grey[600], fontWeight: FontWeight.bold),),
      
          SizedBox(height: 20,),
      
          Text("Feels Like: ${weather?.feelsLike.round()}°C",style: TextStyle(fontSize: 18, color: Colors.grey,),),
          
        ],
      ),
    );
  }
}