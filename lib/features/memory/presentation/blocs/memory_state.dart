import 'package:equatable/equatable.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/entities/memory_creation_data.dart';

class MemoryState extends Equatable {
  const MemoryState({
    this.memories = const [],
    this.filteredMemories = const [],
    this.isLoading = false,
    this.error,
    this.memoryCreationData,
    this.isCreating = false,
    this.isDraftSaved = false,
  });

  final List<Memory> memories;
  final List<Memory> filteredMemories;
  final bool isLoading;
  final String? error;
  final MemoryCreationData? memoryCreationData;
  final bool isCreating;
  final bool isDraftSaved;

  MemoryState copyWith({
    List<Memory>? memories,
    List<Memory>? filteredMemories,
    bool? isLoading,
    String? error,
    MemoryCreationData? memoryCreationData,
    bool? isCreating,
    bool? isDraftSaved,
  }) {
    return MemoryState(
      memories: memories ?? this.memories,
      filteredMemories: filteredMemories ?? this.filteredMemories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      memoryCreationData: memoryCreationData ?? this.memoryCreationData,
      isCreating: isCreating ?? this.isCreating,
      isDraftSaved: isDraftSaved ?? this.isDraftSaved,
    );
  }

  @override
  List<Object?> get props => [
        memories,
        filteredMemories,
        isLoading,
        error,
        memoryCreationData,
        isCreating,
        isDraftSaved,
      ];
}
