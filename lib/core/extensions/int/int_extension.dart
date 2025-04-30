import 'dart:developer';

import 'package:intl/intl.dart';

extension IntegerExtension on int? {
  String formatDate() {
    if (this is int) {
      final date = DateTime.fromMicrosecondsSinceEpoch(this ?? 0);
      final dateString = DateFormat.yMMMMEEEEd('tr_TR').format(date);
      // final dateTime = DateFormat.Hm('tr_TR').format(date);
      return dateString;
    } else {
      log('$this');
      return 'Hatalı Tarih | $this';
    }
  }

  String getFormattedDate() => DateFormat("dd.MM.yyyy").format(DateTime.now());
}
