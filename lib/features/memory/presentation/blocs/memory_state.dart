import 'package:equatable/equatable.dart';

class MemoryState extends Equatable {
  const MemoryState({
    this.memorys = const [],
    this.selected,
    this.isLoading = false,
    this.error,
  });
  final List<String> memorys;
  final String? selected;
  final bool isLoading;
  final String? error;

  MemoryState copyWith({
    List<String>? memorys,
    String? selected,
    bool? isLoading,
    String? error,
  }) {
    return MemoryState(
      memorys: memorys ?? this.memorys,
      selected: selected ?? this.selected,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [memorys, selected, isLoading, error];
}
