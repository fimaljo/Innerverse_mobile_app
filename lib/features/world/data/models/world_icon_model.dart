import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'world_icon_model.g.dart';
part 'world_icon_model.freezed.dart';

@freezed
@HiveType(typeId: 3)
class WorldIconModel with _$WorldIconModel {
  // Private constructor required by freezed

  const factory WorldIconModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required IconData icon,
  }) = _WorldIconModel;
  const WorldIconModel._();
}
