import 'package:flutter/material.dart';
import 'package:innerverse/features/world/domain/entities/world_option.dart';

class World {
  World({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory World.fromWorldOption({
    required String id,
    required WorldOption worldOption,
  }) {
    return World(
      id: id,
      name: worldOption.name,
      icon: worldOption.icon,
    );
  }

  final String id;
  final String name;
  final IconData icon;

  WorldOption get worldOption => WorldOption(
        id: id,
        name: name,
        icon: icon,
      );
}
