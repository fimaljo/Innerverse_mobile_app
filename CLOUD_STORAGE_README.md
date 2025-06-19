# Cloud Storage Implementation

This document describes the Google Drive cloud storage implementation for the Innerverse app.

## Overview

The cloud storage feature allows users to:
- Backup their memories, world icons, and images to Google Drive
- Sync data across multiple devices
- Restore data when switching devices
- Access their data from any device with internet connection

## Architecture

The implementation follows Clean Architecture principles with the following layers:

### Domain Layer
- **Entities**: `SyncStatus`, `CloudFile`, `SyncMetadata`
- **Failures**: `CloudStorageFailure`
- **Repositories**: `CloudStorageRepository`
- **Use Cases**: `AuthenticateUseCase`, `PerformFullSyncUseCase`, `UploadHiveBoxUseCase`

### Data Layer
- **Data Sources**: 
  - `CloudStorageRemoteDataSource` (Google Drive API)
  - `CloudStorageLocalDataSource` (Local Hive storage)
- **Models**: `SyncMetadataModel`
- **Repository Implementation**: `CloudStorageRepositoryImpl`

### Presentation Layer
- **BLoC**: `CloudStorageBloc`
- **Events**: `AuthenticateRequested`, `SignOutRequested`, `PerformFullSyncRequested`
- **State**: `CloudStorageState`
- **Pages**: `CloudStorageSettingsPage`

## Features

### 1. Google Drive Authentication
- OAuth 2.0 authentication flow
- Secure token storage using `flutter_secure_storage`
- Automatic token refresh

### 2. Data Synchronization
- **Hive Boxes**: Upload/download complete Hive box data
- **Images**: Sync images associated with memories
- **Metadata**: Track sync status and file mappings

### 3. File Structure in Google Drive
```
Google Drive/Innerverse/
├── memories.hive          # Memory data
├── worlds.hive           # World icons data
├── sync_metadata.json    # Sync tracking
└── images/              # Memory images
    ├── memory_1_img_1.jpg
    ├── memory_1_img_2.jpg
    └── ...
```

### 4. Sync Operations
- **Full Sync**: Upload and download all data
- **Upload Sync**: Upload only new/changed local data
- **Download Sync**: Download only new/changed cloud data
- **Incremental Sync**: Only sync changed files

## Usage

### Accessing Cloud Storage Settings
1. Open the app
2. Navigate to the Memories tab
3. Tap the settings icon in the app bar
4. This opens the Cloud Storage Settings page

### Connecting to Google Drive
1. Tap "Connect to Google Drive"
2. Sign in with your Google account
3. Grant permissions for Drive access
4. Your data will be ready for sync

### Syncing Data
1. Tap "Sync Now" to perform a full sync
2. Monitor sync progress and status
3. View last sync time and item count

## Security & Privacy

- **Data Encryption**: All data is encrypted before upload
- **User Control**: Only the user has access to their data
- **Secure Storage**: Tokens stored using Flutter Secure Storage
- **Privacy**: No data is shared with third parties

## Implementation Status

### ✅ Completed
- Clean Architecture setup
- Domain layer (entities, failures, repositories, use cases)
- Data layer (data sources, models, repository implementation)
- Presentation layer (BLoC, events, state, UI)
- Navigation integration
- Basic authentication flow

### 🔄 In Progress
- Google Drive API integration
- Actual file upload/download implementation
- Image compression and optimization
- Conflict resolution logic

### 📋 Planned
- Background sync
- Offline queue management
- Sync conflict resolution
- Data deduplication
- Progressive image loading

## Dependencies

```yaml
dependencies:
  googleapis: ^11.0.0
  googleapis_auth: ^1.4.0
  google_sign_in: ^6.1.0
  crypto: ^3.0.0
  flutter_secure_storage: ^9.0.0
```

## Setup Instructions

### 1. Google Cloud Console Setup
1. Create a new project in Google Cloud Console
2. Enable Google Drive API
3. Create OAuth 2.0 credentials
4. Add your app's package name to authorized origins

### 2. Android Configuration
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### 3. iOS Configuration
Add to `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLName</key>
    <string>com.example.innerverse</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>com.example.innerverse</string>
    </array>
  </dict>
</array>
```

## Testing

### Unit Tests
- Repository tests
- Use case tests
- BLoC tests

### Integration Tests
- Authentication flow
- File upload/download
- Sync operations

### Manual Testing
1. Test authentication flow
2. Test data upload
3. Test data download
4. Test sync operations
5. Test error handling

## Error Handling

The implementation includes comprehensive error handling for:
- Network connectivity issues
- Authentication failures
- File upload/download errors
- Storage quota limits
- Sync conflicts

## Future Enhancements

1. **Real-time Sync**: Implement real-time synchronization
2. **Selective Sync**: Allow users to choose what to sync
3. **Version History**: Track file versions and allow rollback
4. **Bandwidth Optimization**: Implement smart sync scheduling
5. **Multi-cloud Support**: Support other cloud providers

## Contributing

When contributing to the cloud storage feature:
1. Follow Clean Architecture principles
2. Add comprehensive tests
3. Handle errors gracefully
4. Document new features
5. Consider security implications 