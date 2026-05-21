import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/api_call.dart';
import 'package:weatherapp/utils/utils.dart';
import 'package:weatherapp/widget/hourly_data.dart';
import 'package:weatherapp/widget/weekly_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController(
    text: "Chittagong",
  );
  bool _isloading = false;
  String? _error;
  String? _resolveCity;
  String? _country;
  double? _temperature;
  int? _weatherCode;
  String? _windSpeed;
  DateTime? _sunrise;
  DateTime? _sunset;

  List<DataModel> _hourly = [];
  List<DailyDataModel> _daily = [];

  Future<void> _fetchData() async {
    setState(() {
      _resolveCity = null;
      _country = null;
      _temperature = null;
      _weatherCode = null;
      _isloading = true;
      _error = null;
    });

    try {
      final result = await ApiCall.fetchData(searchController.text);
      final location = result["location"];
      final decodedData = result["data"];

      //current
      final current = decodedData["current"] as Map<String, dynamic>;
      final time = current["time"] as String;
      final temperature = (current["temperature_2m"] as num).toDouble();
      final weatherCode = current["weather_code"] as int;
      final windSpeed = (current["wind_speed_10m"] as num).toDouble();
      final country = location.country;
      // print("Country: $country");

      //hourly
      final hourlyData = ApiCall.hourlyData(decodedData);
      //daily
      final dailyData = ApiCall.dailyData(decodedData);
      final sunriseString = decodedData["daily"]["sunrise"][0];
      final sunsetString = decodedData["daily"]["sunset"][0];
      //sunrise, sunset
      print(sunriseString);
      print(sunsetString);

      setState(() {
        _temperature = temperature;
        _weatherCode = weatherCode;
        _windSpeed = windSpeed.toString();
        _resolveCity = location.name;
        _country = country;
        _hourly = hourlyData;
        _daily = dailyData;
        _sunrise = DateTime.parse(sunriseString);
        _sunset = DateTime.parse(sunsetString);
      });

      // print(_hourly);
      // print(data);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueAccent,
              Colors.blue,
              Colors.lightBlueAccent,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Search City (e.g Chittagong)',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),

                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        // _resolveCity = searchController.text;
                        _fetchData();
                      });
                    },
                    child: Text("Search", style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  _isloading ? LinearProgressIndicator() : SizedBox(),
                  if (_country != null) ...[
                    Text(
                      _resolveCity!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _country!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ] else ...[
                    Text(
                      "City Not Found",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],

                  _temperature != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.sunny, color: Colors.orange),
                                Text(
                                  _sunrise != null
                                      ? "${_sunrise!.hour % 12 == 0 ? 12 : _sunrise!.hour % 12} ${_sunrise!.hour >= 12 ? "PM" : "AM"}"
                                      : "N/A",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              "${_temperature.toString()}°C",

                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons.wb_twilight, color: Colors.red),
                                Text(
                                  _sunset != null
                                      ? "${_sunset!.hour % 12 == 0 ? 12 : _sunset!.hour % 12} ${_sunset!.hour >= 12 ? "PM" : "AM"}"
                                      : "N/A",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Text(
                          "N/A",
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  Text(
                    _country != null
                        ? Utils.weatherCodeToText(_weatherCode ?? 0)
                        : "",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (_country != null) ...[
                Card(
                  elevation: 4,
                  color: Colors.tealAccent.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(Icons.air, size: 30),
                        Text(
                          "Wind Speed: ${_country != null ? "${_windSpeed.toString()} km/h" : "N/A"}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // print("$_sunrise"),
                //hourly data
                HourlyData(
                  country: _country,
                  hourly: _hourly,
                  sunrise: _sunrise,
                  sunset: _sunset,
                ),

                //weekly data
                WeeklyData(country: _country, daily: _daily),
              ],

              //hourly data
            ],
          ),
        ),
      ),
    );
  }
}

class DataModel {
  final DateTime time;
  final double temp;
  final int code;
  DataModel({required this.time, required this.temp, required this.code});
}

class DailyDataModel {
  final DateTime time;
  final DateTime sunrise;
  final DateTime sunset;
  final double tempMax;
  final double tempMin;
  final int code;
  DailyDataModel({
    required this.time,
    required this.tempMax,
    required this.tempMin,
    required this.code,
    required this.sunrise,
    required this.sunset,
  });
}
