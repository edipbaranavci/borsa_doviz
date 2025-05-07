import 'package:hive_flutter/hive_flutter.dart';
part 'tab_index_model.g.dart';

@HiveType(typeId: 5)
class TabIndexModel {
  @HiveField(0)
  final int? index;
  TabIndexModel({this.index});
}
