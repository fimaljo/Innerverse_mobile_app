import 'package:dartz/dartz.dart';
import 'package:innerverse/features/cloud_storage/domain/entities/sync_status.dart';
import 'package:innerverse/features/cloud_storage/domain/failures/cloud_storage_failure.dart';

abstract class CloudStorageRepository {
  /// Authenticate user with Google Drive
  Future<Either<CloudStorageFailure, bool>> authenticate();

  /// Check if user is authenticated
  Future<Either<CloudStorageFailure, bool>> isAuthenticated();

  /// Sign out from Google Drive
  Future<Either<CloudStorageFailure, bool>> signOut();

  /// Upload Hive box data to Google Drive
  Future<Either<CloudStorageFailure, String>> uploadHiveBox(
    String boxName,
    List<int> data,
  );

  /// Download Hive box data from Google Drive
  Future<Either<CloudStorageFailure, List<int>>> downloadHiveBox(
    String boxName,
  );

  /// Upload image to Google Drive
  Future<Either<CloudStorageFailure, String>> uploadImage(
    String localPath,
    String fileName,
  );

  /// Download image from Google Drive
  Future<Either<CloudStorageFailure, String>> downloadImage(
    String cloudFileId,
    String localPath,
  );

  /// Get sync status
  Future<Either<CloudStorageFailure, SyncStatus>> getSyncStatus();

  /// Perform full sync (upload and download)
  Future<Either<CloudStorageFailure, SyncStatus>> performFullSync();

  /// Upload only new/changed data
  Future<Either<CloudStorageFailure, SyncStatus>> performUploadSync();

  /// Download only new/changed data
  Future<Either<CloudStorageFailure, SyncStatus>> performDownloadSync();

  /// Get sync metadata
  Future<Either<CloudStorageFailure, SyncMetadata>> getSyncMetadata();

  /// Save sync metadata
  Future<Either<CloudStorageFailure, bool>> saveSyncMetadata(
    SyncMetadata metadata,
  );

  /// Check if file exists in cloud
  Future<Either<CloudStorageFailure, bool>> fileExists(String fileName);

  /// Delete file from cloud
  Future<Either<CloudStorageFailure, bool>> deleteFile(String fileId);
}
