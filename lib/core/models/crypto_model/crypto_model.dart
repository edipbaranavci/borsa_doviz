// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class CryptoModel with EquatableMixin {
  String? name;
  String? uSDPrice;
  String? tRYPrice;
  num? selling;
  num? change;
  String? type;
  String? code;

  CryptoModel({
    this.name,
    this.uSDPrice,
    this.tRYPrice,
    this.selling,
    this.change,
    this.type,
    this.code,
  });

  @override
  List<Object?> get props => [
    name,
    uSDPrice,
    tRYPrice,
    selling,
    code,
    change,
    type,
  ];

  CryptoModel copyWith({
    String? name,
    String? uSDPrice,
    String? tRYPrice,
    num? selling,
    num? change,
    String? type,
    String? code,
  }) {
    return CryptoModel(
      name: name ?? this.name,
      uSDPrice: uSDPrice ?? this.uSDPrice,
      tRYPrice: tRYPrice ?? this.tRYPrice,
      selling: selling ?? this.selling,
      change: change ?? this.change,
      type: type ?? this.type,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'USD_Price': uSDPrice,
      'TRY_Price': tRYPrice,
      'Selling': selling,
      'Change': change,
      'Type': type,
      'Code': code,
    };
  }

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['Name'] as String?,
      uSDPrice: json['USD_Price'] as String?,
      tRYPrice: json['TRY_Price'] as String?,
      selling: json['Selling'] as num?,
      change: json['Change'] as num?,
      type: json['Type'] as String?,
      code: json['Code'] as String?,
    );
  }
}
