import 'package:logger/logger.dart';

class ErrorModel {
  final String errorMessage;
  ErrorModel(this.errorMessage);

  @override
  String toString() => 'ErrorModel! => (errorMessage: $errorMessage)';

  void printError() => Logger().e(toString());
}
