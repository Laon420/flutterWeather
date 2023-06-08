import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  final String locationName;
  final String iconUrl;
  final double temperature;
  final String description;

  Weather({
    required this.locationName,
    required this.iconUrl,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final iconCode = weather['icon'];
    final iconUrl = 'https://openweathermap.org/img/w/$iconCode.png';
    final temperature = main['temp'].toDouble();
    final description = weather['description'];
    final locationName = json['name'];
    return Weather(
      locationName: locationName,
      iconUrl: iconUrl,
      temperature: temperature,
      description: description,
    );
  }

  static Future<Weather> fetch(
      String apiKey, String cityname) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=${cityname}&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}