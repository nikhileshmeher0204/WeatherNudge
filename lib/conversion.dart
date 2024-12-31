import 'package:intl/intl.dart';

String unixToITCTime(num? unix, num? timezoneOffset) {
  if (unix == null) {
    return "N/A"; // Return a default value if unix is null
  }
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(unix.toInt() * 1000, isUtc: true)
          .add(Duration(seconds: timezoneOffset!.toInt()));
  return DateFormat.jm().format(dateTime);
}

String unixToITCDay(num? unix) {
  if (unix == null) {
    return "N/A"; // Return a default value if unix is null
  }
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unix.toInt() * 1000);
  return DateFormat('EEEE').format(dateTime);
}

String uvIndex(num? uv) {
  if (uv == null) {
    return "N/A"; // Return a default value if uv is null
  }
  if (uv <= 2)
    return "Low";
  else if (uv > 2 && uv <= 5)
    return "Moderate";
  else if (uv > 5 && uv <= 7)
    return "High";
  else if (uv > 8 && uv <= 10)
    return "Very High";
  else
    return "Extreme";
}
