import 'package:flutter/material.dart';
import 'package:weatherapp/screen/home_screen.dart';
import 'package:weatherapp/utils/utils.dart';

class WeeklyData extends StatelessWidget {
  WeeklyData({
    super.key,
    required String? country,
    required List<DailyDataModel> daily,
  }) : _country = country,
       _daily = daily;

  final String? _country;
  final List<DailyDataModel> _daily;
  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Card(
        elevation: 4,
        color: Colors.tealAccent.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Next 7 days",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _daily.length,
                itemBuilder: (context, index) {
                  double progress =
                      (_daily[index].tempMax - _daily[index].tempMin) / 20;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text(
                            index == 0
                                ? "Today"
                                : days[_daily[index].time.weekday - 1],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Text("Today"),
                        SizedBox(width: 15),
                        Utils.weatherCodeToIcon(_daily[index].code),
                        SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerRight,
                              widthFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(_daily[index].tempMin.toInt().toString() + "°C"),
                        SizedBox(width: 15),
                        Text(_daily[index].tempMax.toInt().toString() + "°C"),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
