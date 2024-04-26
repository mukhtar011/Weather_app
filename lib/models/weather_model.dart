class Weather {

  final String cityName;
  final double tempearture;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.tempearture,
    required this.mainCondition,
});

  factory Weather.fromjson(Map<String, dynamic>json){
    return Weather(
        cityName: json['name'],
        tempearture: json['main']['temp'],
        mainCondition: json['weather'][0]['main'],
    );
  }

}