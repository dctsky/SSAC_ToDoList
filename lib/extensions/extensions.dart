import 'package:intl/intl.dart';

extension MyString on String {
  DateTime stringToDate() {
    return DateTime.parse(this);
  }
}
extension MyDate on DateTime {
  String dateToString(String dateFormat) {
    return DateFormat(dateFormat).format(this);
  }
}