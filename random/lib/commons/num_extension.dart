import 'package:intl/intl.dart';

extension IntExt on int? {
  int get value {
    return this ?? 0;
  }
}

extension StringExt on String {
  DateTime? get asDate {
    return DateTime.tryParse(this);
  }

  String? get dateString {
    final date = asDate;
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    }
    return null;
  }
}

extension DateExt on DateTime {
  String? get dateString {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
