

import 'package:intl/intl.dart';

class LocalTimeZoneHelper{

  static String convertToLocalTZ(String createdAt) {
    final date = DateTime.parse(createdAt).toLocal();

    final formattedDate = DateFormat("HH:mm, dd/mm/yyyy").format(date);

    return formattedDate;

  }
}