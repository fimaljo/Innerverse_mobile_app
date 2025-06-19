import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innerverse/features/cloud_storage/domain/entities/sync_status.dart';

part 'sync_metadata_model.freezed.dart';
part 'sync_metadata_model.g.dart';

@freezed
class SyncMetadataModel with _$SyncMetadataModel {
  const factory SyncMetadataModel({
    required DateTime lastSyncTime,
    required Map<String, String> fileIdMapping,
    required Map<String, DateTime> lastModifiedTimes,
    required String appVersion,
  }) = _SyncMetadataModel;

  factory SyncMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$SyncMetadataModelFromJson(json);
}

extension SyncMetadataModelExtension on SyncMetadataModel {
  SyncMetadata toDomain() {
    return SyncMetadata(
      lastSyncTime: lastSyncTime,
      fileIdMapping: fileIdMapping,
      lastModifiedTimes: lastModifiedTimes,
      appVersion: appVersion,
    );
  }
}

extension SyncMetadataExtension on SyncMetadata {
  SyncMetadataModel toModel() {
    return SyncMetadataModel(
      lastSyncTime: lastSyncTime,
      fileIdMapping: fileIdMapping,
      lastModifiedTimes: lastModifiedTimes,
      appVersion: appVersion,
    );
  }
}
