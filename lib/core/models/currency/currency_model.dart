// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class CurrencyModel with EquatableMixin {
  String? name;
  String? buying;
  String? type;
  String? code;
  String? selling;
  num? change;

  CurrencyModel({
    this.name,
    this.buying,
    this.type,
    this.selling,
    this.change,
    this.code,
  });

  @override
  List<Object?> get props => [name, code, buying, type, selling, change];

  CurrencyModel copyWith({
    String? name,
    String? buying,
    String? type,
    String? code,
    String? selling,
    num? change,
  }) {
    return CurrencyModel(
      name: name ?? this.name,
      buying: buying ?? this.buying,
      type: type ?? this.type,
      selling: selling ?? this.selling,
      change: change ?? this.change,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Buying': buying,
      'Type': type,
      'Selling': selling,
      'Change': change,
      'Code': code,
    };
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      name: json['Name'] as String?,
      buying: json['Buying'] as String?,
      type: json['Type'] as String?,
      code: json['Code'] as String?,
      selling: json['Selling'] as String?,
      change: json['Change'] as num?,
    );
  }
}
