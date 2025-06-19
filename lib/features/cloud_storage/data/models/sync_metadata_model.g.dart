// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_metadata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncMetadataModelImpl _$$SyncMetadataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SyncMetadataModelImpl(
      lastSyncTime: DateTime.parse(json['lastSyncTime'] as String),
      fileIdMapping: Map<String, String>.from(json['fileIdMapping'] as Map),
      lastModifiedTimes:
          (json['lastModifiedTimes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, DateTime.parse(e as String)),
      ),
      appVersion: json['appVersion'] as String,
    );

Map<String, dynamic> _$$SyncMetadataModelImplToJson(
        _$SyncMetadataModelImpl instance) =>
    <String, dynamic>{
      'lastSyncTime': instance.lastSyncTime.toIso8601String(),
      'fileIdMapping': instance.fileIdMapping,
      'lastModifiedTimes': instance.lastModifiedTimes
          .map((k, e) => MapEntry(k, e.toIso8601String())),
      'appVersion': instance.appVersion,
    };
