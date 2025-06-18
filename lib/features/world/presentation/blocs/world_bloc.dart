import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/world/domain/usecases/add_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/base_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/delete_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/get_all_worlds_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/update_world_usecase.dart';
import 'package:innerverse/features/world/presentation/blocs/world_event.dart';
import 'package:innerverse/features/world/presentation/blocs/world_state.dart';

class WorldBloc extends Bloc<WorldEvent, WorldState> {
  WorldBloc({
    required GetAllWorldsUseCase getAllWorldsUseCase,
    required AddWorldUseCase addWorldUseCase,
    required UpdateWorldUseCase updateWorldUseCase,
    required DeleteWorldUseCase deleteWorldUseCase,
  })  : _getAllWorldsUseCase = getAllWorldsUseCase,
        _addWorldUseCase = addWorldUseCase,
        _updateWorldUseCase = updateWorldUseCase,
        _deleteWorldUseCase = deleteWorldUseCase,
        super(const WorldState()) {
    on<LoadWorlds>(_onLoadWorlds);
    on<AddWorld>(_onAddWorld);
    on<UpdateWorld>(_onUpdateWorld);
    on<DeleteWorld>(_onDeleteWorld);
  }

  final GetAllWorldsUseCase _getAllWorldsUseCase;
  final AddWorldUseCase _addWorldUseCase;
  final UpdateWorldUseCase _updateWorldUseCase;
  final DeleteWorldUseCase _deleteWorldUseCase;

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
}
