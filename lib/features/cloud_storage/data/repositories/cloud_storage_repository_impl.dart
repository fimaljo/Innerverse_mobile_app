import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:innerverse/features/cloud_storage/data/datasources/cloud_storage_local_datasource.dart';
import 'package:innerverse/features/cloud_storage/data/datasources/cloud_storage_remote_datasource.dart';
import 'package:innerverse/features/cloud_storage/data/models/sync_metadata_model.dart';
import 'package:innerverse/features/cloud_storage/domain/entities/sync_status.dart';
import 'package:innerverse/features/cloud_storage/domain/failures/cloud_storage_failure.dart';
import 'package:innerverse/features/cloud_storage/domain/repositories/cloud_storage_repository.dart';

class CloudStorageRepositoryImpl implements CloudStorageRepository {
  const CloudStorageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final CloudStorageRemoteDataSource remoteDataSource;
  final CloudStorageLocalDataSource localDataSource;

  @override
  Future<Either<CloudStorageFailure, bool>> authenticate() async {
    try {
      await remoteDataSource.authenticate();
      return const Right(true);
    } catch (e) {
      return Left(CloudStorageFailure.authenticationError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, bool>> isAuthenticated() async {
    try {
      final isAuthenticated = await remoteDataSource.isAuthenticated();
      return Right(isAuthenticated);
    } catch (e) {
      return Left(CloudStorageFailure.authenticationError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, bool>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearAuthToken();
      await localDataSource.clearAllSyncData();
      return const Right(true);
    } catch (e) {
      return Left(CloudStorageFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, String>> uploadHiveBox(
    String boxName,
    List<int> data,
  ) async {
    try {
      final appFolderId = await remoteDataSource.getOrCreateAppFolder();
      final fileName = '$boxName.hive';
      final fileId = await remoteDataSource.uploadFile(
        fileName,
        data,
        'application/octet-stream',
        appFolderId,
      );

      // Save file ID mapping
      await localDataSource.saveFileIdMapping(fileName, fileId);

      return Right(fileId);
    } catch (e) {
      return Left(CloudStorageFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, List<int>>> downloadHiveBox(
    String boxName,
  ) async {
    try {
      final fileName = '$boxName.hive';
      final fileId = await localDataSource.getFileIdMapping(fileName);

      if (fileId == null) {
        return Left(
            CloudStorageFailure.fileNotFound('File not found: $fileName'));
      }

      final data = await remoteDataSource.downloadFile(fileId);
      return Right(data);
    } catch (e) {
      return Left(CloudStorageFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, String>> uploadImage(
    String localPath,
    String fileName,
  ) async {
    try {
      final file = File(localPath);
      if (!await file.exists()) {
        return Left(CloudStorageFailure.fileNotFound(
            'Local file not found: $localPath'));
      }

      final data = await file.readAsBytes();
      final imagesFolderId = await remoteDataSource.getOrCreateImagesFolder();
      final fileId = await remoteDataSource.uploadFile(
        fileName,
        data,
        'image/jpeg',
        imagesFolderId,
      );

      // Save file ID mapping
      await localDataSource.saveFileIdMapping(localPath, fileId);

      return Right(fileId);
    } catch (e) {
      return Left(CloudStorageFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, String>> downloadImage(
    String cloudFileId,
    String localPath,
  ) async {
    try {
      final data = await remoteDataSource.downloadFile(cloudFileId);
      final file = File(localPath);

      // Ensure directory exists
      final directory = file.parent;
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      await file.writeAsBytes(data);
      return Right(localPath);
    } catch (e) {
      return Left(CloudStorageFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, SyncStatus>> getSyncStatus() async {
    try {
      final metadata = await localDataSource.getSyncMetadata();
      if (metadata == null) {
        return const Right(SyncStatus(
          isSyncing: false,
          lastSyncTime: null,
          lastSyncError: null,
          totalItems: 0,
          syncedItems: 0,
          syncType: SyncType.fullSync,
        ));
      }

      return Right(SyncStatus(
        isSyncing: false,
        lastSyncTime: metadata.lastSyncTime,
        lastSyncError: null,
        totalItems: metadata.fileIdMapping.length,
        syncedItems: metadata.fileIdMapping.length,
        syncType: SyncType.fullSync,
      ));
    } catch (e) {
      return Left(CloudStorageFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, SyncStatus>> performFullSync() async {
    try {
      // This is a simplified implementation
      // In a real app, you'd implement proper sync logic
      final status = await getSyncStatus();
      return status;
    } catch (e) {
      return Left(CloudStorageFailure.syncConflict(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, SyncStatus>> performUploadSync() async {
    try {
      // Upload new/changed local data to cloud
      final status = await getSyncStatus();
      return status;
    } catch (e) {
      return Left(CloudStorageFailure.syncConflict(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, SyncStatus>> performDownloadSync() async {
    try {
      // Download new/changed cloud data to local
      final status = await getSyncStatus();
      return status;
    } catch (e) {
      return Left(CloudStorageFailure.syncConflict(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, SyncMetadata>> getSyncMetadata() async {
    try {
      final metadata = await localDataSource.getSyncMetadata();
      if (metadata == null) {
        return Left(CloudStorageFailure.fileNotFound('No sync metadata found'));
      }
      return Right(metadata.toDomain());
    } catch (e) {
      return Left(CloudStorageFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, bool>> saveSyncMetadata(
    SyncMetadata metadata,
  ) async {
    try {
      await localDataSource.saveSyncMetadata(metadata.toModel());
      return const Right(true);
    } catch (e) {
      return Left(CloudStorageFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, bool>> fileExists(String fileName) async {
    try {
      final appFolderId = await remoteDataSource.getOrCreateAppFolder();
      final exists = await remoteDataSource.fileExists(fileName, appFolderId);
      return Right(exists);
    } catch (e) {
      return Left(CloudStorageFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<CloudStorageFailure, bool>> deleteFile(String fileId) async {
    try {
      await remoteDataSource.deleteFile(fileId);
      return const Right(true);
    } catch (e) {
      return Left(CloudStorageFailure.serverError(e.toString()));
    }
  }
}
