// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncStatus {
  bool get isSyncing => throw _privateConstructorUsedError;
  DateTime? get lastSyncTime => throw _privateConstructorUsedError;
  String? get lastSyncError => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  int get syncedItems => throw _privateConstructorUsedError;
  SyncType get syncType => throw _privateConstructorUsedError;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncStatusCopyWith<SyncStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
          SyncStatus value, $Res Function(SyncStatus) then) =
      _$SyncStatusCopyWithImpl<$Res, SyncStatus>;
  @useResult
  $Res call(
      {bool isSyncing,
      DateTime? lastSyncTime,
      String? lastSyncError,
      int totalItems,
      int syncedItems,
      SyncType syncType});
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res, $Val extends SyncStatus>
    implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSyncing = null,
    Object? lastSyncTime = freezed,
    Object? lastSyncError = freezed,
    Object? totalItems = null,
    Object? syncedItems = null,
    Object? syncType = null,
  }) {
    return _then(_value.copyWith(
      isSyncing: null == isSyncing
          ? _value.isSyncing
          : isSyncing // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncTime: freezed == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncError: freezed == lastSyncError
          ? _value.lastSyncError
          : lastSyncError // ignore: cast_nullable_to_non_nullable
              as String?,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      syncedItems: null == syncedItems
          ? _value.syncedItems
          : syncedItems // ignore: cast_nullable_to_non_nullable
              as int,
      syncType: null == syncType
          ? _value.syncType
          : syncType // ignore: cast_nullable_to_non_nullable
              as SyncType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncStatusImplCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$$SyncStatusImplCopyWith(
          _$SyncStatusImpl value, $Res Function(_$SyncStatusImpl) then) =
      __$$SyncStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isSyncing,
      DateTime? lastSyncTime,
      String? lastSyncError,
      int totalItems,
      int syncedItems,
      SyncType syncType});
}

/// @nodoc
class __$$SyncStatusImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncStatusImpl>
    implements _$$SyncStatusImplCopyWith<$Res> {
  __$$SyncStatusImplCopyWithImpl(
      _$SyncStatusImpl _value, $Res Function(_$SyncStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSyncing = null,
    Object? lastSyncTime = freezed,
    Object? lastSyncError = freezed,
    Object? totalItems = null,
    Object? syncedItems = null,
    Object? syncType = null,
  }) {
    return _then(_$SyncStatusImpl(
      isSyncing: null == isSyncing
          ? _value.isSyncing
          : isSyncing // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncTime: freezed == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncError: freezed == lastSyncError
          ? _value.lastSyncError
          : lastSyncError // ignore: cast_nullable_to_non_nullable
              as String?,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      syncedItems: null == syncedItems
          ? _value.syncedItems
          : syncedItems // ignore: cast_nullable_to_non_nullable
              as int,
      syncType: null == syncType
          ? _value.syncType
          : syncType // ignore: cast_nullable_to_non_nullable
              as SyncType,
    ));
  }
}

/// @nodoc

class _$SyncStatusImpl implements _SyncStatus {
  const _$SyncStatusImpl(
      {required this.isSyncing,
      required this.lastSyncTime,
      required this.lastSyncError,
      required this.totalItems,
      required this.syncedItems,
      required this.syncType});

  @override
  final bool isSyncing;
  @override
  final DateTime? lastSyncTime;
  @override
  final String? lastSyncError;
  @override
  final int totalItems;
  @override
  final int syncedItems;
  @override
  final SyncType syncType;

  @override
  String toString() {
    return 'SyncStatus(isSyncing: $isSyncing, lastSyncTime: $lastSyncTime, lastSyncError: $lastSyncError, totalItems: $totalItems, syncedItems: $syncedItems, syncType: $syncType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatusImpl &&
            (identical(other.isSyncing, isSyncing) ||
                other.isSyncing == isSyncing) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.lastSyncError, lastSyncError) ||
                other.lastSyncError == lastSyncError) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.syncedItems, syncedItems) ||
                other.syncedItems == syncedItems) &&
            (identical(other.syncType, syncType) ||
                other.syncType == syncType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSyncing, lastSyncTime,
      lastSyncError, totalItems, syncedItems, syncType);

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatusImplCopyWith<_$SyncStatusImpl> get copyWith =>
      __$$SyncStatusImplCopyWithImpl<_$SyncStatusImpl>(this, _$identity);
}

abstract class _SyncStatus implements SyncStatus {
  const factory _SyncStatus(
      {required final bool isSyncing,
      required final DateTime? lastSyncTime,
      required final String? lastSyncError,
      required final int totalItems,
      required final int syncedItems,
      required final SyncType syncType}) = _$SyncStatusImpl;

  @override
  bool get isSyncing;
  @override
  DateTime? get lastSyncTime;
  @override
  String? get lastSyncError;
  @override
  int get totalItems;
  @override
  int get syncedItems;
  @override
  SyncType get syncType;

  /// Create a copy of SyncStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncStatusImplCopyWith<_$SyncStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CloudFile {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  DateTime get createdTime => throw _privateConstructorUsedError;
  DateTime get modifiedTime => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String? get parentFolderId => throw _privateConstructorUsedError;

  /// Create a copy of CloudFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloudFileCopyWith<CloudFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudFileCopyWith<$Res> {
  factory $CloudFileCopyWith(CloudFile value, $Res Function(CloudFile) then) =
      _$CloudFileCopyWithImpl<$Res, CloudFile>;
  @useResult
  $Res call(
      {String id,
      String name,
      String mimeType,
      DateTime createdTime,
      DateTime modifiedTime,
      int size,
      String? parentFolderId});
}

/// @nodoc
class _$CloudFileCopyWithImpl<$Res, $Val extends CloudFile>
    implements $CloudFileCopyWith<$Res> {
  _$CloudFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloudFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? mimeType = null,
    Object? createdTime = null,
    Object? modifiedTime = null,
    Object? size = null,
    Object? parentFolderId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modifiedTime: null == modifiedTime
          ? _value.modifiedTime
          : modifiedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      parentFolderId: freezed == parentFolderId
          ? _value.parentFolderId
          : parentFolderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CloudFileImplCopyWith<$Res>
    implements $CloudFileCopyWith<$Res> {
  factory _$$CloudFileImplCopyWith(
          _$CloudFileImpl value, $Res Function(_$CloudFileImpl) then) =
      __$$CloudFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String mimeType,
      DateTime createdTime,
      DateTime modifiedTime,
      int size,
      String? parentFolderId});
}

/// @nodoc
class __$$CloudFileImplCopyWithImpl<$Res>
    extends _$CloudFileCopyWithImpl<$Res, _$CloudFileImpl>
    implements _$$CloudFileImplCopyWith<$Res> {
  __$$CloudFileImplCopyWithImpl(
      _$CloudFileImpl _value, $Res Function(_$CloudFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? mimeType = null,
    Object? createdTime = null,
    Object? modifiedTime = null,
    Object? size = null,
    Object? parentFolderId = freezed,
  }) {
    return _then(_$CloudFileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modifiedTime: null == modifiedTime
          ? _value.modifiedTime
          : modifiedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      parentFolderId: freezed == parentFolderId
          ? _value.parentFolderId
          : parentFolderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CloudFileImpl implements _CloudFile {
  const _$CloudFileImpl(
      {required this.id,
      required this.name,
      required this.mimeType,
      required this.createdTime,
      required this.modifiedTime,
      required this.size,
      required this.parentFolderId});

  @override
  final String id;
  @override
  final String name;
  @override
  final String mimeType;
  @override
  final DateTime createdTime;
  @override
  final DateTime modifiedTime;
  @override
  final int size;
  @override
  final String? parentFolderId;

  @override
  String toString() {
    return 'CloudFile(id: $id, name: $name, mimeType: $mimeType, createdTime: $createdTime, modifiedTime: $modifiedTime, size: $size, parentFolderId: $parentFolderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloudFileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.modifiedTime, modifiedTime) ||
                other.modifiedTime == modifiedTime) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.parentFolderId, parentFolderId) ||
                other.parentFolderId == parentFolderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, mimeType, createdTime,
      modifiedTime, size, parentFolderId);

  /// Create a copy of CloudFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloudFileImplCopyWith<_$CloudFileImpl> get copyWith =>
      __$$CloudFileImplCopyWithImpl<_$CloudFileImpl>(this, _$identity);
}

abstract class _CloudFile implements CloudFile {
  const factory _CloudFile(
      {required final String id,
      required final String name,
      required final String mimeType,
      required final DateTime createdTime,
      required final DateTime modifiedTime,
      required final int size,
      required final String? parentFolderId}) = _$CloudFileImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get mimeType;
  @override
  DateTime get createdTime;
  @override
  DateTime get modifiedTime;
  @override
  int get size;
  @override
  String? get parentFolderId;

  /// Create a copy of CloudFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloudFileImplCopyWith<_$CloudFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SyncMetadata {
  DateTime get lastSyncTime => throw _privateConstructorUsedError;
  Map<String, String> get fileIdMapping =>
      throw _privateConstructorUsedError; // localPath -> cloudFileId
  Map<String, DateTime> get lastModifiedTimes =>
      throw _privateConstructorUsedError;
  String get appVersion => throw _privateConstructorUsedError;

  /// Create a copy of SyncMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncMetadataCopyWith<SyncMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncMetadataCopyWith<$Res> {
  factory $SyncMetadataCopyWith(
          SyncMetadata value, $Res Function(SyncMetadata) then) =
      _$SyncMetadataCopyWithImpl<$Res, SyncMetadata>;
  @useResult
  $Res call(
      {DateTime lastSyncTime,
      Map<String, String> fileIdMapping,
      Map<String, DateTime> lastModifiedTimes,
      String appVersion});
}

/// @nodoc
class _$SyncMetadataCopyWithImpl<$Res, $Val extends SyncMetadata>
    implements $SyncMetadataCopyWith<$Res> {
  _$SyncMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncTime = null,
    Object? fileIdMapping = null,
    Object? lastModifiedTimes = null,
    Object? appVersion = null,
  }) {
    return _then(_value.copyWith(
      lastSyncTime: null == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fileIdMapping: null == fileIdMapping
          ? _value.fileIdMapping
          : fileIdMapping // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      lastModifiedTimes: null == lastModifiedTimes
          ? _value.lastModifiedTimes
          : lastModifiedTimes // ignore: cast_nullable_to_non_nullable
              as Map<String, DateTime>,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncMetadataImplCopyWith<$Res>
    implements $SyncMetadataCopyWith<$Res> {
  factory _$$SyncMetadataImplCopyWith(
          _$SyncMetadataImpl value, $Res Function(_$SyncMetadataImpl) then) =
      __$$SyncMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime lastSyncTime,
      Map<String, String> fileIdMapping,
      Map<String, DateTime> lastModifiedTimes,
      String appVersion});
}

/// @nodoc
class __$$SyncMetadataImplCopyWithImpl<$Res>
    extends _$SyncMetadataCopyWithImpl<$Res, _$SyncMetadataImpl>
    implements _$$SyncMetadataImplCopyWith<$Res> {
  __$$SyncMetadataImplCopyWithImpl(
      _$SyncMetadataImpl _value, $Res Function(_$SyncMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncTime = null,
    Object? fileIdMapping = null,
    Object? lastModifiedTimes = null,
    Object? appVersion = null,
  }) {
    return _then(_$SyncMetadataImpl(
      lastSyncTime: null == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fileIdMapping: null == fileIdMapping
          ? _value._fileIdMapping
          : fileIdMapping // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      lastModifiedTimes: null == lastModifiedTimes
          ? _value._lastModifiedTimes
          : lastModifiedTimes // ignore: cast_nullable_to_non_nullable
              as Map<String, DateTime>,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SyncMetadataImpl implements _SyncMetadata {
  const _$SyncMetadataImpl(
      {required this.lastSyncTime,
      required final Map<String, String> fileIdMapping,
      required final Map<String, DateTime> lastModifiedTimes,
      required this.appVersion})
      : _fileIdMapping = fileIdMapping,
        _lastModifiedTimes = lastModifiedTimes;

  @override
  final DateTime lastSyncTime;
  final Map<String, String> _fileIdMapping;
  @override
  Map<String, String> get fileIdMapping {
    if (_fileIdMapping is EqualUnmodifiableMapView) return _fileIdMapping;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fileIdMapping);
  }

// localPath -> cloudFileId
  final Map<String, DateTime> _lastModifiedTimes;
// localPath -> cloudFileId
  @override
  Map<String, DateTime> get lastModifiedTimes {
    if (_lastModifiedTimes is EqualUnmodifiableMapView)
      return _lastModifiedTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastModifiedTimes);
  }

  @override
  final String appVersion;

  @override
  String toString() {
    return 'SyncMetadata(lastSyncTime: $lastSyncTime, fileIdMapping: $fileIdMapping, lastModifiedTimes: $lastModifiedTimes, appVersion: $appVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncMetadataImpl &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            const DeepCollectionEquality()
                .equals(other._fileIdMapping, _fileIdMapping) &&
            const DeepCollectionEquality()
                .equals(other._lastModifiedTimes, _lastModifiedTimes) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastSyncTime,
      const DeepCollectionEquality().hash(_fileIdMapping),
      const DeepCollectionEquality().hash(_lastModifiedTimes),
      appVersion);

  /// Create a copy of SyncMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncMetadataImplCopyWith<_$SyncMetadataImpl> get copyWith =>
      __$$SyncMetadataImplCopyWithImpl<_$SyncMetadataImpl>(this, _$identity);
}

abstract class _SyncMetadata implements SyncMetadata {
  const factory _SyncMetadata(
      {required final DateTime lastSyncTime,
      required final Map<String, String> fileIdMapping,
      required final Map<String, DateTime> lastModifiedTimes,
      required final String appVersion}) = _$SyncMetadataImpl;

  @override
  DateTime get lastSyncTime;
  @override
  Map<String, String> get fileIdMapping; // localPath -> cloudFileId
  @override
  Map<String, DateTime> get lastModifiedTimes;
  @override
  String get appVersion;

  /// Create a copy of SyncMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncMetadataImplCopyWith<_$SyncMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
