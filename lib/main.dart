import 'package:flutter/material.dart';
import 'weather.dart';
import 'map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<Weather> _futureWeather;
  TextEditingController _cityController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _futureWeather = _fetchWeather('Busan');
  }

  Future<Weather> _fetchWeather(String city) async {
    try {
      final apiKey = '5bd1a3729e749f14a197101c8b90c5b7';
      return await Weather.fetch(apiKey, city);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load weather data';
      });
      rethrow;
    }
  }

  void _updateWeather() {
    final city = _cityController.text;
    if (city.isNotEmpty) {
      setState(() {
        _errorMessage = '';
        _futureWeather = _fetchWeather(city);
      });
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('날씨 어플'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '도시 이름을 입력하세요:',
              style: TextStyle(fontSize: 16.0),
            ),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: '도시 입력',
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _updateWeather,
              child: Text('날씨 업데이트'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<Weather>(
                future: _futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final weather = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${weather.temperature}°C',
                          style: TextStyle(fontSize: 48),
                        ),
                        Image.network(weather.iconUrl),
                        Text(
                          weather.description,
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          weather.locationName,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('$_errorMessage ${snapshot.error}');
                  }
                  return Container();
                },
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Map()),
                  );
                },
                child: Text('지도')),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CityNamesPage()),
            );
          },
          child: Text('도시명 보기'),
            ),
          ],
        ),
      ),
    );
  }
}
class CityNamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주요 도시'),
      ),
      body: ListView(
        children: [
          ListTile(title: Text('Seoul')),
          ListTile(title: Text('Busan')),
          ListTile(title: Text('Incheon')),
          ListTile(title: Text('Daegu')),
          ListTile(title: Text('Daejeon')),
          ListTile(title: Text('Gwangju')),
          ListTile(title: Text('Suwon')),
          ListTile(title: Text('Tokyo')),
          ListTile(title: Text('New York')),
          ListTile(title: Text('London')),
          ListTile(title: Text('Paris')),
          ListTile(title: Text('Berlin')),
          ListTile(title: Text('Sydney')),
          ListTile(title: Text('Los Angeles')),
        ],
      ),
    );
  }
}