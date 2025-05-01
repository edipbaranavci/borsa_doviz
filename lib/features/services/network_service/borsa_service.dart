import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../core/models/crypto_model/crypto_model.dart';
import '../../../core/models/currency/currency_model.dart';
import '../../../core/models/error_model.dart';
import '../../../core/models/gold/gold_model.dart';

class BorsaService {
  final String _baseUrl = 'https://finans.truncgil.com/v4/today.json';
  final _headers = {'Content-Type': 'application/json; charset=utf-8'};

  Future<http.Response> _fetchResponse() async {
    return await http.get(Uri.parse(_baseUrl), headers: _headers);
  }

  Map<String, dynamic> _fetchMap(List<int> codeUnits) {
    final jsonString = utf8.decode(codeUnits);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    jsonData.remove('Update_Date');
    return jsonData;
  }

  Future<Either<ErrorModel, List<CryptoModel>>> fetchCrypto() async {
    final response = await _fetchResponse();
    if (response.statusCode == 200) {
      final jsonData = _fetchMap(response.bodyBytes);
      final List<CryptoModel> list = [];
      jsonData.forEach((key, value) {
        final element = value as Map<String, dynamic>;
        if (element['Type'] == 'CryptoCurrency') {
          element['Code'] = key;
          element['USD_Price'] = _safeABDollarLiraFormat(element['USD_Price']);
          element['TRY_Price'] = _safeTurkishLiraFormat(element['TRY_Price']);
          list.add(CryptoModel.fromJson(element));
        }
      });
      return Right(list);
    } else {
      Logger().e(response.body);
      return Left(ErrorModel(response.body));
    }
  }

  Future<Either<ErrorModel, List<CurrencyModel>>> fetchCurrency() async {
    final response = await _fetchResponse();
    if (response.statusCode == 200) {
      final jsonData = _fetchMap(response.bodyBytes);
      final List<CurrencyModel> list = [];
      jsonData.forEach((key, value) {
        final element = value as Map<String, dynamic>;
        if (element['Type'] == 'Currency') {
          element['Code'] = key;
          element['Buying'] = _safeTurkishLiraFormat(element['Buying']);
          element['Selling'] = _safeTurkishLiraFormat(element['Selling']);
          list.add(CurrencyModel.fromJson(element));
        }
      });
      return Right(list);
    } else {
      Logger().e(response.body);
      return Left(ErrorModel(response.body));
    }
  }

  Future<Either<ErrorModel, List<GoldModel>>> fetchGold() async {
    final response = await _fetchResponse();
    if (response.statusCode == 200) {
      final jsonData = _fetchMap(response.bodyBytes);
      final List<GoldModel> list = [];
      jsonData.forEach((key, value) {
        final element = value as Map<String, dynamic>;
        if ((element['Type'] == 'Gold') ||
            (element['Type'] == 'Palladium') ||
            (element['Type'] == 'Platinum')) {
          element['Code'] = key;
          element['Buying'] = _safeTurkishLiraFormat(element['Buying']);
          element['Selling'] = _safeTurkishLiraFormat(element['Selling']);
          list.add(GoldModel.fromJson(element));
        }
      });
      return Right(list);
    } else {
      Logger().e(response.body);
      return Left(ErrorModel(response.body));
    }
  }

  Future<Either<ErrorModel, String>> getLastUpdateDate() async {
    final response = await _fetchResponse();

    if (response.statusCode == 200) {
      final jsonString = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final String lastUptadeDate = _formatTurkishDateTime(
        jsonData['Update_Date'],
      );
      return Right(lastUptadeDate);
    } else {
      Logger().e(response.body);
      return Left(ErrorModel(response.body));
    }
  }

  String _safeTurkishLiraFormat(num? amount) {
    // Türkçe lokalizasyonu başlat
    initializeDateFormatting('tr_TR', null);
    if (amount == null) return '0,00₺';
    return NumberFormat.currency(
      locale: 'tr_TR',
      symbol: '₺',
      decimalDigits: 2,
    ).format(amount);
  }

  String _safeABDollarLiraFormat(num? amount) {
    if (amount == null) return r'$0.00';
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 2,
    ).format(amount);
  }

  String _formatTurkishDateTime(String apiDate) {
    // Türkçe lokalizasyonu başlat
    initializeDateFormatting('tr_TR', null);

    final dateTime = DateTime.parse(apiDate);

    final dateFormat = DateFormat('d MMMM yyyy', 'tr_TR');
    final timeFormat = DateFormat('HH:mm', 'tr_TR');

    return '${dateFormat.format(dateTime)} Saat: ${timeFormat.format(dateTime)}';
  }
}
