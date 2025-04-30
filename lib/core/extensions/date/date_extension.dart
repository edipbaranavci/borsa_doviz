import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateExtension on DateTime? {
  String formatTurkishDateTime() {
    // Türkçe lokalizasyonu başlat
    initializeDateFormatting('tr_TR', null);
    final dateFormat = DateFormat('d MMMM yyyy', 'tr_TR');
    final timeFormat = DateFormat('HH:mm', 'tr_TR');
    final date = this;
    if (date != null) {
      return '${dateFormat.format(date)} Saat: ${timeFormat.format(date)}';
    } else {
      return 'hatalı tarih formatı!';
    }
  }
}
