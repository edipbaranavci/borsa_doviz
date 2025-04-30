// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class GoldModel with EquatableMixin {
  String? selling;
  String? type;
  String? code;
  String? name;
  num? change;
  String? buying;

  GoldModel({
    this.selling,
    this.type,
    this.name,
    this.change,
    this.code,
    this.buying,
  });

  @override
  List<Object?> get props => [code, selling, type, name, change, buying];

  GoldModel copyWith({
    String? selling,
    String? type,
    String? name,
    String? code,
    num? change,
    String? buying,
  }) {
    return GoldModel(
      selling: selling ?? this.selling,
      type: type ?? this.type,
      name: name ?? this.name,
      change: change ?? this.change,
      buying: buying ?? this.buying,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Selling': selling,
      'Type': type,
      'Name': name,
      'Change': change,
      'Buying': buying,
      'Code': code,
    };
  }

  factory GoldModel.fromJson(Map<String, dynamic> json) {
    return GoldModel(
      selling: json['Selling'] as String?,
      type: json['Type'] as String?,
      name: json['Name'] as String?,
      code: json['Code'] as String?,
      change: json['Change'] as num?,
      buying: json['Buying'] as String?,
    );
  }
}
