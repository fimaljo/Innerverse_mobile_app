import 'package:equatable/equatable.dart';

abstract class MemoryEvent extends Equatable {
  const MemoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadMemorys extends MemoryEvent {}

class SelectMemory extends MemoryEvent {
  const SelectMemory(this.type);
  final String type;

  @override
  List<Object?> get props => [type];
}
