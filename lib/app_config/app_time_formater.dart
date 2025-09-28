import 'package:intl/intl.dart';

class AppTimeFormaterUtils {
  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "";
    return DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
  }
}
