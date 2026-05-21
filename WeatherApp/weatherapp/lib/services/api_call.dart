import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/screen/home_screen.dart';

class ApiCall {
  static Future<
    ({String name, String country, double latitude, double longitude})
  >
  geoCode(String location) async {
    final url = Uri.parse(
      "https://geocoding-api.open-meteo.com/v1/search?name=$location&count=1&language=en&format=json",
    );
    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception("Failed to load data");
    final data = response.body;
    final deCodedData = jsonDecode(data) as Map<String, dynamic>;
    final result = deCodedData["results"] as List<dynamic>;
    if (result == null || result.isEmpty) throw Exception("City Not Found");
    final city = result.first as Map<String, dynamic>;
    final name = city["name"] as String;
    final country = city["country"] as String;
    final latitude = city["latitude"] as double;
    final longitude = city["longitude"] as double;
    // print(
    //   "Name: $name, Country: $country, Latitude: $latitude, Longitude: $longitude",
    // );
    // print(response.body);
    return (
      name: name,
      country: country,
      latitude: latitude,
      longitude: longitude,
    );
  }

  static Future<Map<String, dynamic>> fetchData(String city) async {
    final location = await geoCode(city);
    final url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast"
      "?latitude=${location.latitude}"
      "&longitude=${location.longitude}"
      "&daily=temperature_2m_max,weather_code,sunrise,sunset,temperature_2m_min"
      "&hourly=temperature_2m,weather_code,wind_speed_10m"
      "&current=temperature_2m,weather_code,wind_speed_10m",
    );
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
    final decodedData = jsonDecode(response.body) as Map<String, dynamic>;
    return {"location": location, "data": decodedData};
  }

  static List<DataModel> hourlyData(Map<String, dynamic> data) {
    //hourly
    final hourly = data["hourly"] as Map<String, dynamic>;
    final timeHourly = hourly["time"] as List<dynamic>;
    final temperatureHourly = hourly["temperature_2m"] as List<dynamic>;
    final weatherCodeHourly = hourly["weather_code"] as List<dynamic>;

    final hourlyData = <DataModel>[];
    for (int i = 0; i < timeHourly.length; i++) {
      hourlyData.add(
        DataModel(
          time: DateTime.parse(timeHourly[i]),
          temp: (temperatureHourly[i] as num).toDouble(),
          code: (weatherCodeHourly[i] as num).toInt(),
        ),
      );
    }
    return hourlyData;
  }

  static List<DailyDataModel> dailyData(Map<String, dynamic> data) {
    //daily
    final daily = data["daily"] as Map<String, dynamic>;
    final timeDaily = daily["time"] as List<dynamic>;
    final senrise = daily["sunrise"] as List<dynamic>;
    final sunset = daily["sunset"] as List<dynamic>;
    final temperatureMaxDaily = daily["temperature_2m_max"] as List<dynamic>;
    final temperatureMinDaily = daily["temperature_2m_min"] as List<dynamic>;
    final weatherCodeDaily = daily["weather_code"] as List<dynamic>;

    final dailyData = <DailyDataModel>[];
    for (int i = 0; i < timeDaily.length; i++) {
      dailyData.add(
        DailyDataModel(
          time: DateTime.parse(timeDaily[i]),
          sunrise: DateTime.parse(senrise[i]),
          sunset: DateTime.parse(sunset[i]),
          tempMax: (temperatureMaxDaily[i] as num).toDouble(),
          tempMin: (temperatureMinDaily[i] as num).toDouble(),
          code: (weatherCodeDaily[i] as num).toInt(),
        ),
      );
    }
    return dailyData;
  }
}
