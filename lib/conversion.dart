import 'package:intl/intl.dart';

String unixToITC(num? unix) {
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(unix!.toInt()! * 1000);
  return DateFormat.jm().format(dateTime);
}

String uvIndex(num? uv) {
  if (uv! <= 2)
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
