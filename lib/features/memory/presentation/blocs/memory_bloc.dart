import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_event.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_state.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  MemoryBloc() : super(const MemoryState()) {
    on<LoadMemorys>(_onLoadMemorys);
    on<SelectMemory>(_onSelectMemory);
  }

  Future<void> _onLoadMemorys(
    LoadMemorys event,
    Emitter<MemoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      // Fake data - in real app, fetch from usecase/repo
      await Future.delayed(const Duration(milliseconds: 500));
      final s = ['Joyful', 'Sad', 'Angry', 'Grateful'];

      emit(state.copyWith(memorys: s, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _onSelectMemory(
    SelectMemory event,
    Emitter<MemoryState> emit,
  ) {
    emit(state.copyWith(selected: event.type));
  }
}
