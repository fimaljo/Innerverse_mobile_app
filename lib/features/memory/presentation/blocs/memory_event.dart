import 'package:equatable/equatable.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/entities/memory_creation_data.dart';

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

// Memory Creation Events
class InitializeMemoryCreation extends MemoryEvent {
  const InitializeMemoryCreation(this.initialData);

  final MemoryCreationData initialData;

  @override
  List<Object?> get props => [initialData];
}

class UpdateMemoryCreationData extends MemoryEvent {
  const UpdateMemoryCreationData(this.memoryData);

  final MemoryCreationData memoryData;

  @override
  List<Object?> get props => [memoryData];
}

class SaveMemoryDraft extends MemoryEvent {
  const SaveMemoryDraft();
}

class CreateMemoryFromData extends MemoryEvent {
  const CreateMemoryFromData();
}
