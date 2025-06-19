import 'package:equatable/equatable.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';

class MemoryState extends Equatable {
  const MemoryState({
    this.memories = const [],
    this.filteredMemories = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Memory> memories;
  final List<Memory> filteredMemories;
  final bool isLoading;
  final String? error;

  MemoryState copyWith({
    List<Memory>? memories,
    List<Memory>? filteredMemories,
    bool? isLoading,
    String? error,
  }) {
    return MemoryState(
      memories: memories ?? this.memories,
      filteredMemories: filteredMemories ?? this.filteredMemories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [memories, filteredMemories, isLoading, error];
}
