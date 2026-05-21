import 'package:flutter/material.dart';

class Utils {
  static String weatherCodeToText(int? code) {
    if (code == null) return "--";

    switch (code) {
      case 0:
        return "Clear Sky";
      case 1:
      case 2:
      case 3:
        return "Partly Cloudy";
      case 45:
      case 48:
        return "Foggy";
      case 51:
      case 53:
      case 55:
        return "Drizzle";
      case 56:
      case 57:
        return "Freezing Drizzle";
      case 61:
      case 63:
      case 65:
        return "Rain";
      case 66:
      case 67:
        return "Freezing Rain";
      case 71:
      case 73:
      case 75:
        return "Snowfall";
      case 77:
        return "Snow Grains";
      case 80:
      case 81:
      case 82:
        return "Rain Showers";
      case 85:
      case 86:
        return "Snow Showers";
      case 95:
        return "Thunderstorm";
      case 96:
      case 99:
        return "Thunderstorm with Hail";
      default:
        return "Unknown Weather";
    }
  }
  static Icon weatherCodeToIcon(int? code) {
    double sz = 20.0;
    if (code == null) {
      return Icon(Icons.help, color: Colors.grey, size: sz);
    }

    switch (code) {
      case 0:
        return Icon(Icons.wb_sunny, color: Colors.grey, size: sz);

      case 1:
      case 2:
      case 3:
        return Icon(Icons.wb_cloudy, color: Colors.grey, size: sz);

      case 45:
      case 48:
        return Icon(Icons.foggy, color: Colors.grey, size: sz);

      case 51:
      case 53:
      case 55:
        return Icon(
          Icons.water_drop_outlined,
          color: Colors.lightBlue,
          size: sz,
        );

      case 56:
      case 57:
        return Icon(Icons.ac_unit, color: Colors.lightBlueAccent, size: sz);

      case 61:
      case 63:
      case 65:
        return Icon(Icons.umbrella, color: Colors.blue, size: sz);

      case 66:
      case 67:
        return Icon(Icons.ac_unit, color: Colors.cyan, size: sz);

      case 71:
      case 73:
      case 75:
        return Icon(Icons.cloudy_snowing, color: Colors.white70, size: sz);

      case 77:
        return Icon(Icons.ac_unit, color: Colors.white70, size: sz);

      case 80:
      case 81:
      case 82:
        return Icon(Icons.shower, color: Colors.lightBlueAccent, size: sz);

      case 85:
      case 86:
        return Icon(Icons.cloudy_snowing, color: Colors.white70, size: sz);

      case 95:
        return Icon(Icons.flash_on, color: Colors.deepPurpleAccent, size: sz);

      case 96:
      case 99:
        return Icon(Icons.flash_on, color: Colors.deepPurple, size: sz);

      default:
        return Icon(Icons.help_outline, color: Colors.grey, size: sz);
    }
  }


}
