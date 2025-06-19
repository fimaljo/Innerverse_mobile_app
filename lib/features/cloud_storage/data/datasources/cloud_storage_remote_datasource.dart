import 'dart:io';
import 'dart:typed_data';
import '../models/sync_metadata_model.dart';

abstract class CloudStorageRemoteDataSource {
  /// Initialize Google Drive API client
  Future<void> initialize();

  /// Authenticate with Google Drive
  Future<void> authenticate();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Sign out from Google Drive
  Future<void> signOut();

  /// Upload file to Google Drive
  Future<String> uploadFile(
    String fileName,
    List<int> data,
    String mimeType,
    String? parentFolderId,
  );

  /// Download file from Google Drive
  Future<List<int>> downloadFile(String fileId);

  /// Get file metadata
  Future<Map<String, dynamic>?> getFileMetadata(String fileId);

  /// List files in folder
  Future<List<Map<String, dynamic>>> listFiles(String? folderId);

  /// Create folder
  Future<String> createFolder(String folderName, String? parentFolderId);

  /// Delete file
  Future<void> deleteFile(String fileId);

  /// Check if file exists
  Future<bool> fileExists(String fileName, String? parentFolderId);

  /// Get or create app folder
  Future<String> getOrCreateAppFolder();

  /// Get or create images folder
  Future<String> getOrCreateImagesFolder();

  /// Upload Hive box to Google Drive
  Future<String> uploadHiveBox(Uint8List data);

  /// Download Hive box from Google Drive
  Future<Uint8List> downloadHiveBox();

  /// Upload image to Google Drive
  Future<String> uploadImage(File imageFile, {String? customName});

  /// Download image from Google Drive
  Future<File> downloadImage(String fileId, String localPath);

  /// Upload sync metadata
  Future<SyncMetadataModel> uploadSyncMetadata(SyncMetadataModel metadata);

  /// Download sync metadata
  Future<SyncMetadataModel?> downloadSyncMetadata();
}
