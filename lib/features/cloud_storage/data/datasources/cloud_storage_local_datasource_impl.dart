import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:innerverse/features/cloud_storage/data/datasources/cloud_storage_local_datasource.dart';
import 'package:innerverse/features/cloud_storage/data/models/sync_metadata_model.dart';

class CloudStorageLocalDataSourceImpl implements CloudStorageLocalDataSource {
  CloudStorageLocalDataSourceImpl();

  static const String _syncMetadataKey = 'sync_metadata';
  static const String _authTokenKey = 'auth_token';
  static const String _fileIdMappingKey = 'file_id_mapping';

  @override
  Future<void> saveSyncMetadata(SyncMetadataModel metadata) async {
    final box = await Hive.openBox<String>('cloud_storage');
    final json = metadata.toJson();
    await box.put(_syncMetadataKey, jsonEncode(json));
  }

  @override
  Future<SyncMetadataModel?> getSyncMetadata() async {
    try {
      final box = await Hive.openBox<String>('cloud_storage');
      final jsonString = box.get(_syncMetadataKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return SyncMetadataModel.fromJson(json);
      }
      return null;
    } on FormatException {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveAuthToken(String token) async {
    final box = await Hive.openBox<String>('cloud_storage');
    await box.put(_authTokenKey, token);
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      final box = await Hive.openBox<String>('cloud_storage');
      return box.get(_authTokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearAuthToken() async {
    final box = await Hive.openBox<String>('cloud_storage');
    await box.delete(_authTokenKey);
  }

  @override
  Future<void> saveFileIdMapping(String localPath, String cloudFileId) async {
    final box = await Hive.openBox<String>('cloud_storage');
    final mappings = await getAllFileIdMappings();
    mappings[localPath] = cloudFileId;
    await box.put(_fileIdMappingKey, jsonEncode(mappings));
  }

  @override
  Future<String?> getFileIdMapping(String localPath) async {
    try {
      final mappings = await getAllFileIdMappings();
      return mappings[localPath];
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Map<String, String>> getAllFileIdMappings() async {
    try {
      final box = await Hive.openBox<String>('cloud_storage');
      final jsonString = box.get(_fileIdMappingKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return Map<String, String>.from(json);
      }
      return {};
    } on FormatException {
      return {};
    } catch (_) {
      return {};
    }
  }

  @override
  Future<void> clearAllSyncData() async {
    final box = await Hive.openBox<String>('cloud_storage');
    await box.clear();
  }
}
