import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'world_icon.g.dart';

@HiveType(typeId: 3)
class WorldIcon {
  WorldIcon({
    required this.name,
    required this.icon,
  });
  @HiveField(0)
  final String name;

  @HiveField(1)
  final IconData icon;
}
