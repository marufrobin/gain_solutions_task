import 'package:intl/intl.dart';

class AppTimeFormaterUtils {
  static String getTimeFormat(DateTime? time) {
    if (time == null) return "";
    return DateFormat('EEE, MMM d, yyyy').format(time);
  }
}
