import 'package:equatable/equatable.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';

abstract class MemoryEvent extends Equatable {
  const MemoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadMemories extends MemoryEvent {
  const LoadMemories();
}

class AddMemory extends MemoryEvent {
  const AddMemory(this.memory);
  final Memory memory;

  @override
  List<Object?> get props => [memory];
}

class UpdateMemory extends MemoryEvent {
  const UpdateMemory(this.memory);
  final Memory memory;

  @override
  List<Object?> get props => [memory];
}

class DeleteMemory extends MemoryEvent {
  const DeleteMemory(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}

class GetMemoriesByDateRange extends MemoryEvent {
  const GetMemoriesByDateRange({
    required this.startDate,
    required this.endDate,
  });
  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}

class ClearAllMemories extends MemoryEvent {
  const ClearAllMemories();
}
