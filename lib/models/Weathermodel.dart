class Weather{
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  //Method to decode the data from API
  factory Weather.fromjson(Map<String, dynamic> json){
    return Weather(
      cityName: json["main"],
      temperature: json["main"]["temp"].toDouble(),
      mainCondition: json["main"][0]["main"],
    );
  }
}