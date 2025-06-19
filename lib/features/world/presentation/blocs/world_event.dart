import 'package:equatable/equatable.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';

abstract class WorldEvent extends Equatable {
  const WorldEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorlds extends WorldEvent {
  const LoadWorlds();
}

class AddWorld extends WorldEvent {
  const AddWorld(this.world);
  final World world;

  @override
  List<Object?> get props => [world];
}

class UpdateWorld extends WorldEvent {
  const UpdateWorld(this.world);
  final World world;

  @override
  List<Object?> get props => [world];
}

class DeleteWorld extends WorldEvent {
  const DeleteWorld(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}
