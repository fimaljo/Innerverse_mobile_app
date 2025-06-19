import 'package:innerverse/features/cloud_storage/data/models/sync_metadata_model.dart';

abstract class CloudStorageLocalDataSource {
  /// Save sync metadata
  Future<void> saveSyncMetadata(SyncMetadataModel metadata);

  /// Get sync metadata
  Future<SyncMetadataModel?> getSyncMetadata();

  /// Save authentication token
  Future<void> saveAuthToken(String token);

  /// Get authentication token
  Future<String?> getAuthToken();

  /// Clear authentication token
  Future<void> clearAuthToken();

  /// Save file ID mapping
  Future<void> saveFileIdMapping(String localPath, String cloudFileId);

  /// Get file ID mapping
  Future<String?> getFileIdMapping(String localPath);

  /// Get all file ID mappings
  Future<Map<String, String>> getAllFileIdMappings();

  /// Clear all sync data
  Future<void> clearAllSyncData();
}
