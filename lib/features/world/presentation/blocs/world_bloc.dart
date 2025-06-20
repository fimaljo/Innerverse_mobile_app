import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/world/domain/usecases/add_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/base_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/delete_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/get_all_worlds_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/update_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/calculate_tree_growth_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/calculate_world_tree_growth_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/get_all_worlds_with_tree_growth_usecase.dart';
import 'package:innerverse/features/world/presentation/blocs/world_event.dart';
import 'package:innerverse/features/world/presentation/blocs/world_state.dart';
import 'package:innerverse/core/services/event_bus_service.dart';
import 'package:innerverse/core/events/app_events.dart';
import 'dart:async';

class WorldBloc extends Bloc<WorldEvent, WorldState> {
  final EventBusService _eventBus = EventBusService();
  late final StreamSubscription<MemoryCreatedEvent> _memoryCreatedSubscription;
  late final StreamSubscription<MemoryUpdatedEvent> _memoryUpdatedSubscription;
  late final StreamSubscription<MemoryDeletedEvent> _memoryDeletedSubscription;

  WorldBloc({
    required GetAllWorldsUseCase getAllWorldsUseCase,
    required AddWorldUseCase addWorldUseCase,
    required UpdateWorldUseCase updateWorldUseCase,
    required DeleteWorldUseCase deleteWorldUseCase,
    required CalculateTreeGrowthUseCase calculateTreeGrowthUseCase,
    required CalculateWorldTreeGrowthUseCase calculateWorldTreeGrowthUseCase,
    required GetAllWorldsWithTreeGrowthUseCase
        getAllWorldsWithTreeGrowthUseCase,
  })  : _getAllWorldsUseCase = getAllWorldsUseCase,
        _addWorldUseCase = addWorldUseCase,
        _updateWorldUseCase = updateWorldUseCase,
        _deleteWorldUseCase = deleteWorldUseCase,
        _calculateTreeGrowthUseCase = calculateTreeGrowthUseCase,
        _calculateWorldTreeGrowthUseCase = calculateWorldTreeGrowthUseCase,
        _getAllWorldsWithTreeGrowthUseCase = getAllWorldsWithTreeGrowthUseCase,
        super(const WorldState()) {
    on<LoadWorlds>(_onLoadWorlds);
    on<AddWorld>(_onAddWorld);
    on<UpdateWorld>(_onUpdateWorld);
    on<DeleteWorld>(_onDeleteWorld);
    // Tree growth visualization events
    on<LoadWorldVisualization>(_onLoadWorldVisualization);
    on<RefreshWorldVisualization>(_onRefreshWorldVisualization);
    // World selection and individual tree growth events
    on<LoadWorldsWithTreeGrowth>(_onLoadWorldsWithTreeGrowth);
    on<SelectWorld>(_onSelectWorld);
    on<LoadWorldTreeGrowth>(_onLoadWorldTreeGrowth);

    // Listen to memory events for automatic tree growth updates
    _memoryCreatedSubscription = _eventBus.on<MemoryCreatedEvent>().listen((_) {
      if (!isClosed) {
        add(const RefreshWorldVisualization());
        add(const LoadWorldsWithTreeGrowth());
      }
    });
    _memoryUpdatedSubscription = _eventBus.on<MemoryUpdatedEvent>().listen((_) {
      if (!isClosed) {
        add(const RefreshWorldVisualization());
        add(const LoadWorldsWithTreeGrowth());
      }
    });
    _memoryDeletedSubscription = _eventBus.on<MemoryDeletedEvent>().listen((_) {
      if (!isClosed) {
        add(const RefreshWorldVisualization());
        add(const LoadWorldsWithTreeGrowth());
      }
    });
  }

  @override
  Future<void> close() {
    _memoryCreatedSubscription.cancel();
    _memoryUpdatedSubscription.cancel();
    _memoryDeletedSubscription.cancel();
    return super.close();
  }

  final GetAllWorldsUseCase _getAllWorldsUseCase;
  final AddWorldUseCase _addWorldUseCase;
  final UpdateWorldUseCase _updateWorldUseCase;
  final DeleteWorldUseCase _deleteWorldUseCase;
  final CalculateTreeGrowthUseCase _calculateTreeGrowthUseCase;
  final CalculateWorldTreeGrowthUseCase _calculateWorldTreeGrowthUseCase;
  final GetAllWorldsWithTreeGrowthUseCase _getAllWorldsWithTreeGrowthUseCase;

  // Existing world management methods
  Future<void> _onLoadWorlds(
    LoadWorlds event,
    Emitter<WorldState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final worldsResult = await _getAllWorldsUseCase(const NoParams());
      if (!emit.isDone) {
        worldsResult.fold(
          (failure) => emit(
            state.copyWith(
              error: failure.toString(),
              isLoading: false,
            ),
          ),
          (worlds) => emit(
            state.copyWith(
              worlds: worlds,
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

  Future<void> _onAddWorld(
    AddWorld event,
    Emitter<WorldState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final addResult = await _addWorldUseCase(event.world);
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
            final worldsResult = await _getAllWorldsUseCase(const NoParams());
            if (!emit.isDone) {
              worldsResult.fold(
                (failure) => emit(
                  state.copyWith(
                    error: failure.toString(),
                    isLoading: false,
                  ),
                ),
                (worlds) => emit(
                  state.copyWith(
                    worlds: worlds,
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

  Future<void> _onUpdateWorld(
    UpdateWorld event,
    Emitter<WorldState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final updateResult = await _updateWorldUseCase(event.world);
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
            final worldsResult = await _getAllWorldsUseCase(const NoParams());
            if (!emit.isDone) {
              worldsResult.fold(
                (failure) => emit(
                  state.copyWith(
                    error: failure.toString(),
                    isLoading: false,
                  ),
                ),
                (worlds) => emit(
                  state.copyWith(
                    worlds: worlds,
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

  Future<void> _onDeleteWorld(
    DeleteWorld event,
    Emitter<WorldState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final deleteResult = await _deleteWorldUseCase(event.id);
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
            final worldsResult = await _getAllWorldsUseCase(const NoParams());
            if (!emit.isDone) {
              worldsResult.fold(
                (failure) => emit(
                  state.copyWith(
                    error: failure.toString(),
                    isLoading: false,
                  ),
                ),
                (worlds) => emit(
                  state.copyWith(
                    worlds: worlds,
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

  // Tree growth visualization methods
  Future<void> _onLoadWorldVisualization(
    LoadWorldVisualization event,
    Emitter<WorldState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final treeGrowthResult =
          await _calculateTreeGrowthUseCase(const NoParams());
      if (!emit.isDone) {
        treeGrowthResult.fold(
          (failure) => emit(
            state.copyWith(
              error: failure.toString(),
              isLoading: false,
            ),
          ),
          (treeGrowthData) => emit(
            state.copyWith(
              averageEmotionValue: treeGrowthData.averageEmotionValue,
              treeGrowthValue: treeGrowthData.treeGrowthValue,
              isNightMode: treeGrowthData.isNightMode,
              memoryCount: treeGrowthData.memoryCount,
              isRaining: treeGrowthData.isRaining,
              daysSinceLastMemory: treeGrowthData.daysSinceLastMemory,
              currentHour: treeGrowthData.currentHour,
              isTimeBasedNight: treeGrowthData.isTimeBasedNight,
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

  Future<void> _onRefreshWorldVisualization(
    RefreshWorldVisualization event,
    Emitter<WorldState> emit,
  ) async {
    add(const LoadWorldVisualization());
  }

  // World selection and individual tree growth methods
  Future<void> _onLoadWorldsWithTreeGrowth(
    LoadWorldsWithTreeGrowth event,
    Emitter<WorldState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final worldsWithTreeGrowthResult =
          await _getAllWorldsWithTreeGrowthUseCase(const NoParams());
      if (!emit.isDone) {
        worldsWithTreeGrowthResult.fold(
          (failure) => emit(
            state.copyWith(
              error: failure.toString(),
              isLoading: false,
            ),
          ),
          (worldsWithTreeGrowth) => emit(
            state.copyWith(
              worldsWithTreeGrowth: worldsWithTreeGrowth,
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

  Future<void> _onSelectWorld(
    SelectWorld event,
    Emitter<WorldState> emit,
  ) async {
    emit(state.copyWith(selectedWorldId: event.worldId));
    add(LoadWorldTreeGrowth(event.worldId));
  }

  Future<void> _onLoadWorldTreeGrowth(
    LoadWorldTreeGrowth event,
    Emitter<WorldState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final worldTreeGrowthResult =
          await _calculateWorldTreeGrowthUseCase(event.worldId);
      if (!emit.isDone) {
        worldTreeGrowthResult.fold(
          (failure) => emit(
            state.copyWith(
              error: failure.toString(),
              isLoading: false,
            ),
          ),
          (treeGrowthData) => emit(
            state.copyWith(
              averageEmotionValue: treeGrowthData.averageEmotionValue,
              treeGrowthValue: treeGrowthData.treeGrowthValue,
              isNightMode: treeGrowthData.isNightMode,
              memoryCount: treeGrowthData.memoryCount,
              isRaining: treeGrowthData.isRaining,
              daysSinceLastMemory: treeGrowthData.daysSinceLastMemory,
              currentHour: treeGrowthData.currentHour,
              isTimeBasedNight: treeGrowthData.isTimeBasedNight,
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
}
