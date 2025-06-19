import '../../data/models/sync_metadata_model.dart';
import '../../domain/entities/sync_status.dart';

enum ConflictResolutionStrategy {
  localWins,
  remoteWins,
  manual,
  merge,
  timestamp,
}

class ConflictInfo {
  const ConflictInfo({
    required this.localVersion,
    required this.remoteVersion,
    required this.conflictType,
    required this.timestamp,
    this.resolutionStrategy,
  });

  final SyncMetadataModel localVersion;
  final SyncMetadataModel remoteVersion;
  final String conflictType;
  final DateTime timestamp;
  final ConflictResolutionStrategy? resolutionStrategy;

  Map<String, dynamic> toJson() {
    return {
      'localVersion': localVersion.toJson(),
      'remoteVersion': remoteVersion.toJson(),
      'conflictType': conflictType,
      'timestamp': timestamp.toIso8601String(),
      'resolutionStrategy': resolutionStrategy?.name,
    };
  }

  factory ConflictInfo.fromJson(Map<String, dynamic> json) {
    return ConflictInfo(
      localVersion: SyncMetadataModel.fromJson(
        Map<String, dynamic>.from(json['localVersion'] as Map),
      ),
      remoteVersion: SyncMetadataModel.fromJson(
        Map<String, dynamic>.from(json['remoteVersion'] as Map),
      ),
      conflictType: json['conflictType'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      resolutionStrategy: json['resolutionStrategy'] != null
          ? ConflictResolutionStrategy.values.firstWhere(
              (e) => e.name == json['resolutionStrategy'],
            )
          : null,
    );
  }
}

class ConflictResolutionService {
  static SyncMetadataModel resolveConflict(
    SyncMetadataModel local,
    SyncMetadataModel remote,
    ConflictResolutionStrategy strategy,
  ) {
    switch (strategy) {
      case ConflictResolutionStrategy.localWins:
        return local;
      case ConflictResolutionStrategy.remoteWins:
        return remote;
      case ConflictResolutionStrategy.timestamp:
        return _resolveByTimestamp(local, remote);
      case ConflictResolutionStrategy.merge:
        return _mergeMetadata(local, remote);
      case ConflictResolutionStrategy.manual:
        // This should be handled by UI
        throw UnimplementedError('Manual resolution not implemented');
    }
  }

  static SyncMetadataModel _resolveByTimestamp(
    SyncMetadataModel local,
    SyncMetadataModel remote,
  ) {
    final localTime = local.lastSyncTime;
    final remoteTime = remote.lastSyncTime;

    if (localTime.isAfter(remoteTime)) {
      return local;
    } else {
      return remote;
    }
  }

  static SyncMetadataModel _mergeMetadata(
    SyncMetadataModel local,
    SyncMetadataModel remote,
  ) {
    // Merge strategy: combine file mappings and take the most recent times
    final mergedLastSyncTime = local.lastSyncTime.isAfter(remote.lastSyncTime)
        ? local.lastSyncTime
        : remote.lastSyncTime;

    final mergedFileIdMapping = <String, String>{};
    mergedFileIdMapping.addAll(local.fileIdMapping);
    mergedFileIdMapping.addAll(remote.fileIdMapping);

    final mergedLastModifiedTimes = <String, DateTime>{};
    mergedLastModifiedTimes.addAll(local.lastModifiedTimes);

    // For overlapping keys, take the most recent time
    for (final entry in remote.lastModifiedTimes.entries) {
      if (mergedLastModifiedTimes.containsKey(entry.key)) {
        final localTime = mergedLastModifiedTimes[entry.key]!;
        if (entry.value.isAfter(localTime)) {
          mergedLastModifiedTimes[entry.key] = entry.value;
        }
      } else {
        mergedLastModifiedTimes[entry.key] = entry.value;
      }
    }

    // Use the more recent app version
    final mergedAppVersion = local.lastSyncTime.isAfter(remote.lastSyncTime)
        ? local.appVersion
        : remote.appVersion;

    return SyncMetadataModel(
      lastSyncTime: mergedLastSyncTime,
      fileIdMapping: mergedFileIdMapping,
      lastModifiedTimes: mergedLastModifiedTimes,
      appVersion: mergedAppVersion,
    );
  }

  static bool hasConflict(
    SyncMetadataModel local,
    SyncMetadataModel remote,
  ) {
    // Check if both versions have been modified since last sync
    if (local.lastSyncTime == remote.lastSyncTime) {
      return false; // No conflict, same sync time
    }

    // Check if both have been modified independently
    final localModified = local.lastSyncTime;
    final remoteModified = remote.lastSyncTime;
    final timeDifference = localModified.difference(remoteModified).abs();

    // If modifications are within 1 second, consider it a conflict
    if (timeDifference.inSeconds < 1) {
      return true;
    }

    // Check if file mappings are different
    return !_mapsEqual(local.fileIdMapping, remote.fileIdMapping) ||
        !_mapsEqual(local.lastModifiedTimes, remote.lastModifiedTimes);
  }

  static bool _mapsEqual<K, V>(Map<K, V> map1, Map<K, V> map2) {
    if (map1.length != map2.length) return false;
    for (final key in map1.keys) {
      if (!map2.containsKey(key) || map1[key] != map2[key]) {
        return false;
      }
    }
    return true;
  }

  static String getConflictType(
    SyncMetadataModel local,
    SyncMetadataModel remote,
  ) {
    // Check if there are different files in the mappings
    final localFiles = local.fileIdMapping.keys.toSet();
    final remoteFiles = remote.fileIdMapping.keys.toSet();

    if (localFiles.difference(remoteFiles).isNotEmpty ||
        remoteFiles.difference(localFiles).isNotEmpty) {
      return 'file_structure_conflict';
    }

    return 'sync_timing_conflict';
  }

  static List<String> getConflictResolutionOptions(
    String conflictType,
  ) {
    switch (conflictType) {
      case 'file_structure_conflict':
        return ['Local Wins', 'Remote Wins', 'Merge', 'Manual'];
      case 'sync_timing_conflict':
        return ['Local Wins', 'Remote Wins', 'Merge', 'Manual'];
      default:
        return ['Local Wins', 'Remote Wins', 'Manual'];
    }
  }

  static ConflictResolutionStrategy strategyFromString(String strategy) {
    switch (strategy.toLowerCase()) {
      case 'local_wins':
      case 'local wins':
        return ConflictResolutionStrategy.localWins;
      case 'remote_wins':
      case 'remote wins':
        return ConflictResolutionStrategy.remoteWins;
      case 'merge':
        return ConflictResolutionStrategy.merge;
      case 'timestamp':
        return ConflictResolutionStrategy.timestamp;
      case 'manual':
        return ConflictResolutionStrategy.manual;
      default:
        return ConflictResolutionStrategy.timestamp;
    }
  }
}
