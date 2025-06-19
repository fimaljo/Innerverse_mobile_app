import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/memory/domain/usecases/add_memory_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/clear_all_memories_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/delete_memory_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/get_all_memories_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/get_memories_by_date_range_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/update_memory_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/save_memory_draft_usecase.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_event.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_state.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  MemoryBloc({
    required GetAllMemoriesUseCase getAllMemoriesUseCase,
    required AddMemoryUseCase addMemoryUseCase,
    required UpdateMemoryUseCase updateMemoryUseCase,
    required DeleteMemoryUseCase deleteMemoryUseCase,
    required GetMemoriesByDateRangeUseCase getMemoriesByDateRangeUseCase,
    required ClearAllMemoriesUseCase clearAllMemoriesUseCase,
    required SaveMemoryDraftUseCase saveMemoryDraftUseCase,
  })  : _getAllMemoriesUseCase = getAllMemoriesUseCase,
        _addMemoryUseCase = addMemoryUseCase,
        _updateMemoryUseCase = updateMemoryUseCase,
        _deleteMemoryUseCase = deleteMemoryUseCase,
        _getMemoriesByDateRangeUseCase = getMemoriesByDateRangeUseCase,
        _clearAllMemoriesUseCase = clearAllMemoriesUseCase,
        _saveMemoryDraftUseCase = saveMemoryDraftUseCase,
        super(const MemoryState()) {
    on<LoadMemories>(_onLoadMemories);
    on<AddMemory>(_onAddMemory);
    on<UpdateMemory>(_onUpdateMemory);
    on<DeleteMemory>(_onDeleteMemory);
    on<GetMemoriesByDateRange>(_onGetMemoriesByDateRange);
    on<ClearAllMemories>(_onClearAllMemories);
    on<InitializeMemoryCreation>(_onInitializeMemoryCreation);
    on<UpdateMemoryCreationData>(_onUpdateMemoryCreationData);
    on<SaveMemoryDraft>(_onSaveMemoryDraft);
    on<CreateMemoryFromData>(_onCreateMemoryFromData);
  }

  final GetAllMemoriesUseCase _getAllMemoriesUseCase;
  final AddMemoryUseCase _addMemoryUseCase;
  final UpdateMemoryUseCase _updateMemoryUseCase;
  final DeleteMemoryUseCase _deleteMemoryUseCase;
  final GetMemoriesByDateRangeUseCase _getMemoriesByDateRangeUseCase;
  final ClearAllMemoriesUseCase _clearAllMemoriesUseCase;
  final SaveMemoryDraftUseCase _saveMemoryDraftUseCase;

  Future<void> _onLoadMemories(
    LoadMemories event,
    Emitter<MemoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final memoriesResult = await _getAllMemoriesUseCase(const NoParams());
      if (!emit.isDone) {
        memoriesResult.fold(
          (failure) => emit(
            state.copyWith(
              error: failure.toString(),
              isLoading: false,
            ),
          ),
          (memories) => emit(
            state.copyWith(
              memories: memories,
              filteredMemories: memories,
              isLoading: false,
            ),
          ),
        );
      }
    } on Exception catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            error: e.toString(),
            isLoading: false,
          ),
        );
      }
    }
  }

  Future<void> _onAddMemory(
    AddMemory event,
    Emitter<MemoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final addResult = await _addMemoryUseCase(event.memory);
      if (!emit.isDone) {
        await addResult.fold(
          (failure) async {
            emit(
              state.copyWith(
                error: failure.toString(),
                isLoading: false,
              ),
            );
          },
          (_) async {
            final memoriesResult = await _getAllMemoriesUseCase(
              const NoParams(),
            );
            if (!emit.isDone) {
              memoriesResult.fold(
                (failure) => emit(
                  state.copyWith(
                    error: failure.toString(),
                    isLoading: false,
                  ),
                ),
                (memories) => emit(
                  state.copyWith(
                    memories: memories,
                    filteredMemories: memories,
                    isLoading: false,
                  ),
                ),
              );
            }
          },
        );
      }
    } on Exception catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            error: e.toString(),
            isLoading: false,
          ),
        );
      }
    }
  }

  Future<void> _onUpdateMemory(
    UpdateMemory event,
    Emitter<MemoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final updateResult = await _updateMemoryUseCase(event.memory);
      if (!emit.isDone) {
        await updateResult.fold(
          (failure) async {
            emit(
              state.copyWith(
                error: failure.toString(),
                isLoading: false,
              ),
            );
          },
          (_) async {
            final memoriesResult = await _getAllMemoriesUseCase(
              const NoParams(),
            );
            if (!emit.isDone) {
              memoriesResult.fold(
                (failure) => emit(
                  state.copyWith(
                    error: failure.toString(),
                    isLoading: false,
                  ),
                ),
                (memories) => emit(
                  state.copyWith(
                    memories: memories,
                    filteredMemories: memories,
                    isLoading: false,
                  ),
                ),
              );
            }
          },
        );
      }
    } on Exception catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            error: e.toString(),
            isLoading: false,
          ),
        );
      }
    }
  }

  Future<void> _onDeleteMemory(
    DeleteMemory event,
    Emitter<MemoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final deleteResult = await _deleteMemoryUseCase(event.id);
      if (!emit.isDone) {
        await deleteResult.fold(
          (failure) async {
            emit(
              state.copyWith(
                error: failure.toString(),
                isLoading: false,
              ),
            );
          },
          (_) async {
            final memoriesResult = await _getAllMemoriesUseCase(
              const NoParams(),
            );
            if (!emit.isDone) {
              memoriesResult.fold(
                (failure) => emit(
                  state.copyWith(
                    error: failure.toString(),
                    isLoading: false,
                  ),
                ),
                (memories) => emit(
                  state.copyWith(
                    memories: memories,
                    filteredMemories: memories,
                    isLoading: false,
                  ),
                ),
              );
            }
          },
        );
      }
    } on Exception catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            error: e.toString(),
            isLoading: false,
          ),
        );
      }
    }
  }

  Future<void> _onGetMemoriesByDateRange(
    GetMemoriesByDateRange event,
    Emitter<MemoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final filteredMemoriesResult = await _getMemoriesByDateRangeUseCase(
        DateRangeParams(
          start: event.startDate,
          end: event.endDate,
        ),
      );
      if (!emit.isDone) {
        filteredMemoriesResult.fold(
          (failure) => emit(
            state.copyWith(
              error: failure.toString(),
              isLoading: false,
            ),
          ),
          (filteredMemories) => emit(
            state.copyWith(
              filteredMemories: filteredMemories,
              isLoading: false,
            ),
          ),
        );
      }
    } on Exception catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            error: e.toString(),
            isLoading: false,
          ),
        );
      }
    }
  }

  Future<void> _onClearAllMemories(
    ClearAllMemories event,
    Emitter<MemoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final clearResult = await _clearAllMemoriesUseCase(const NoParams());
      if (!emit.isDone) {
        clearResult.fold(
          (failure) => emit(
            state.copyWith(
              error: failure.toString(),
              isLoading: false,
            ),
          ),
          (_) => emit(
            state.copyWith(
              memories: const [],
              filteredMemories: const [],
              isLoading: false,
            ),
          ),
        );
      }
    } on Exception catch (e) {
      if (!emit.isDone) {
        emit(
          state.copyWith(
            error: e.toString(),
            isLoading: false,
          ),
        );
      }
    }
  }

  // Memory Creation Handlers
  void _onInitializeMemoryCreation(
    InitializeMemoryCreation event,
    Emitter<MemoryState> emit,
  ) {
    emit(state.copyWith(
      memoryCreationData: event.initialData,
      isCreating: true,
    ));
  }

  void _onUpdateMemoryCreationData(
    UpdateMemoryCreationData event,
    Emitter<MemoryState> emit,
  ) {
    emit(state.copyWith(
      memoryCreationData: event.memoryData,
    ));
  }

  Future<void> _onSaveMemoryDraft(
    SaveMemoryDraft event,
    Emitter<MemoryState> emit,
  ) async {
    if (state.memoryCreationData == null) return;

    try {
      final result = await _saveMemoryDraftUseCase(state.memoryCreationData!);
      result.fold(
        (failure) => emit(state.copyWith(error: failure.toString())),
        (_) => emit(state.copyWith(isDraftSaved: true)),
      );
    } on Exception catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onCreateMemoryFromData(
    CreateMemoryFromData event,
    Emitter<MemoryState> emit,
  ) async {
    if (state.memoryCreationData == null) return;

    emit(state.copyWith(isCreating: true));
    try {
      final memory = state.memoryCreationData!.toMemory();
      final result = await _addMemoryUseCase(memory);

      result.fold(
        (failure) => emit(state.copyWith(
          error: failure.toString(),
          isCreating: false,
        )),
        (_) async {
          // Reload memories after creating new one
          final memoriesResult = await _getAllMemoriesUseCase(const NoParams());
          memoriesResult.fold(
            (failure) => emit(state.copyWith(
              error: failure.toString(),
              isCreating: false,
            )),
            (memories) => emit(state.copyWith(
              memories: memories,
              filteredMemories: memories,
              isCreating: false,
              memoryCreationData: null, // Clear creation data
            )),
          );
        },
      );
    } on Exception catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isCreating: false,
      ));
    }
  }
}
