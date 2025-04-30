// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class FavoriteModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? code;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final DateTime? dateTime;

  @HiveField(3)
  final String? addDateSelling;

  FavoriteModel({this.code, this.name, this.dateTime, this.addDateSelling});

  FavoriteModel copyWith({
    String? code,
    String? name,
    DateTime? dateTime,
    String? addDateSelling,
  }) {
    return FavoriteModel(
      code: code ?? this.code,
      name: name ?? this.name,
      dateTime: dateTime ?? this.dateTime,
      addDateSelling: addDateSelling ?? this.addDateSelling,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'addDateSelling': addDateSelling,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      code: map['code'] != null ? map['code'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      dateTime:
          map['dateTime'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int)
              : null,
      addDateSelling:
          map['addDateSelling'] != null
              ? map['addDateSelling'] as String
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromJson(String source) =>
      FavoriteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [code, name, dateTime, addDateSelling];
}
