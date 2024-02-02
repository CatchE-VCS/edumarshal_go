import 'package:intl/intl.dart';

class DateController {
  String onDateChanged(date, locale) {
    return DateFormat.yMMMM(locale).format(date);
  }
}
