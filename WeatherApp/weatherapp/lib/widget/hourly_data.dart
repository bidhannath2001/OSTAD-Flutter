import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherapp/screen/home_screen.dart';
import 'package:weatherapp/utils/utils.dart';

class HourlyData extends StatefulWidget {
  const HourlyData({
    super.key,
    required String? country,
    required List<DataModel> hourly,
    required DateTime? sunrise,
    required DateTime? sunset,
  }) : _country = country,
       _hourly = hourly,
       _sunrise = sunrise,
       _sunset = sunset;

  final String? _country;
  final List<DataModel> _hourly;
  final DateTime? _sunrise;
  final DateTime? _sunset;

  @override
  State<HourlyData> createState() => _HourlyDataState();
}

class _HourlyDataState extends State<HourlyData> {
  bool isDaytime(DateTime time) {
    if (widget._sunrise == null || widget._sunset == null) return true;
    return time.isAfter(widget._sunrise!) && time.isBefore(widget._sunset!);
  }

  @override
  initState() {}

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 170,
      child: Card(
        elevation: 4,
        color: Colors.tealAccent.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Hourly Data",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: widget._country != null
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget._hourly.length,
                      itemBuilder: (context, index) {
                        bool day = isDaytime(widget._hourly[index].time);

                        // print(day);
                        // print("time");
                        // print(_hourly[index].time);
                        int hour = widget._hourly[index].time.hour;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget._hourly[index].temp.toInt().toString() +
                                    "°C",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              SizedBox(height: 10),
                              Stack(
                                children: [
                                  Transform.rotate(
                                    angle: day
                                        ? 0
                                        : 3.14 /
                                              1.2, // rotate 150 degrees for night icon
                                    child: Icon(
                                      day
                                          ? Icons.wb_sunny
                                          : Icons.brightness_2_rounded,
                                      size: 35,
                                      color: day
                                          ? Colors.orange
                                          : Colors.blueGrey,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Utils.weatherCodeToIcon(
                                      widget._hourly[index].code,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${hour % 12 == 0 ? 12 : hour % 12} ${hour >= 12 ? "PM" : "AM"}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },

                      separatorBuilder: (context, index) => SizedBox(width: 8),
                    )
                  : Center(
                      child: Text(
                        "City Not Found",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
