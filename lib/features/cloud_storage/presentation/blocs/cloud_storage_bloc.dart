import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/cloud_storage/domain/entities/sync_status.dart';
import 'package:innerverse/features/cloud_storage/domain/failures/cloud_storage_failure.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/authenticate_usecase.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/perform_full_sync_usecase.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/upload_hive_box_usecase.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/base_usecase.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_event.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_state.dart';

class CloudStorageBloc extends Bloc<CloudStorageEvent, CloudStorageState> {
  CloudStorageBloc({
    required this.authenticateUseCase,
    required this.performFullSyncUseCase,
    required this.uploadHiveBoxUseCase,
  }) : super(CloudStorageState.initial()) {
    on<AuthenticateRequested>(_onAuthenticateRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<PerformFullSyncRequested>(_onPerformFullSyncRequested);
    on<UploadHiveBoxRequested>(_onUploadHiveBoxRequested);
    on<CheckAuthenticationStatus>(_onCheckAuthenticationStatus);
  }

  final AuthenticateUseCase authenticateUseCase;
  final PerformFullSyncUseCase performFullSyncUseCase;
  final UploadHiveBoxUseCase uploadHiveBoxUseCase;

  Future<void> _onAuthenticateRequested(
    AuthenticateRequested event,
    Emitter<CloudStorageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await authenticateUseCase(const NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message ?? 'Authentication failed',
      )),
      (isAuthenticated) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: isAuthenticated,
      )),
    );
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<CloudStorageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    // For now, just update the state
    // In a real implementation, you'd call the sign out use case
    emit(state.copyWith(
      isLoading: false,
      isAuthenticated: false,
    ));
  }

  Future<void> _onPerformFullSyncRequested(
    PerformFullSyncRequested event,
    Emitter<CloudStorageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await performFullSyncUseCase(const NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message ?? 'Sync failed',
      )),
      (syncStatus) => emit(state.copyWith(
        isLoading: false,
        syncStatus: syncStatus,
      )),
    );
  }

  Future<void> _onUploadHiveBoxRequested(
    UploadHiveBoxRequested event,
    Emitter<CloudStorageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await uploadHiveBoxUseCase(UploadHiveBoxParams(
      boxName: event.boxName,
      data: event.data,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message ?? 'Upload failed',
      )),
      (fileId) => emit(state.copyWith(
        isLoading: false,
        lastUploadedFileId: fileId,
      )),
    );
  }

  Future<void> _onCheckAuthenticationStatus(
    CheckAuthenticationStatus event,
    Emitter<CloudStorageState> emit,
  ) async {
    // For now, just emit the current state
    // In a real implementation, you'd check the actual authentication status
    emit(state.copyWith(isLoading: false));
  }
}
