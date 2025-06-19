import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_status.freezed.dart';

@freezed
class SyncStatus with _$SyncStatus {
  const factory SyncStatus({
    required bool isSyncing,
    required DateTime? lastSyncTime,
    required String? lastSyncError,
    required int totalItems,
    required int syncedItems,
    required SyncType syncType,
  }) = _SyncStatus;
}

enum SyncType {
  upload,
  download,
  fullSync,
}

@freezed
class CloudFile with _$CloudFile {
  const factory CloudFile({
    required String id,
    required String name,
    required String mimeType,
    required DateTime createdTime,
    required DateTime modifiedTime,
    required int size,
    required String? parentFolderId,
  }) = _CloudFile;
}

@freezed
class SyncMetadata with _$SyncMetadata {
  const factory SyncMetadata({
    required DateTime lastSyncTime,
    required Map<String, String> fileIdMapping, // localPath -> cloudFileId
    required Map<String, DateTime> lastModifiedTimes,
    required String appVersion,
  }) = _SyncMetadata;
}
