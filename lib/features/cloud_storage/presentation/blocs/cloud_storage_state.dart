import 'package:equatable/equatable.dart';
import 'package:innerverse/features/cloud_storage/domain/entities/sync_status.dart';

class CloudStorageState extends Equatable {
  const CloudStorageState({
    required this.isLoading,
    required this.isAuthenticated,
    required this.error,
    required this.syncStatus,
    required this.lastUploadedFileId,
  });

  factory CloudStorageState.initial() => const CloudStorageState(
        isLoading: false,
        isAuthenticated: false,
        error: null,
        syncStatus: null,
        lastUploadedFileId: null,
      );

  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final SyncStatus? syncStatus;
  final String? lastUploadedFileId;

  CloudStorageState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    SyncStatus? syncStatus,
    String? lastUploadedFileId,
  }) {
    return CloudStorageState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
      syncStatus: syncStatus ?? this.syncStatus,
      lastUploadedFileId: lastUploadedFileId ?? this.lastUploadedFileId,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        error,
        syncStatus,
        lastUploadedFileId,
      ];
}
