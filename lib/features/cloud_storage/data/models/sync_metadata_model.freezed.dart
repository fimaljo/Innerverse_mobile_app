// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_metadata_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncMetadataModel _$SyncMetadataModelFromJson(Map<String, dynamic> json) {
  return _SyncMetadataModel.fromJson(json);
}

/// @nodoc
mixin _$SyncMetadataModel {
  DateTime get lastSyncTime => throw _privateConstructorUsedError;
  Map<String, String> get fileIdMapping => throw _privateConstructorUsedError;
  Map<String, DateTime> get lastModifiedTimes =>
      throw _privateConstructorUsedError;
  String get appVersion => throw _privateConstructorUsedError;

  /// Serializes this SyncMetadataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncMetadataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncMetadataModelCopyWith<SyncMetadataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncMetadataModelCopyWith<$Res> {
  factory $SyncMetadataModelCopyWith(
          SyncMetadataModel value, $Res Function(SyncMetadataModel) then) =
      _$SyncMetadataModelCopyWithImpl<$Res, SyncMetadataModel>;
  @useResult
  $Res call(
      {DateTime lastSyncTime,
      Map<String, String> fileIdMapping,
      Map<String, DateTime> lastModifiedTimes,
      String appVersion});
}

/// @nodoc
class _$SyncMetadataModelCopyWithImpl<$Res, $Val extends SyncMetadataModel>
    implements $SyncMetadataModelCopyWith<$Res> {
  _$SyncMetadataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncMetadataModel
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
abstract class _$$SyncMetadataModelImplCopyWith<$Res>
    implements $SyncMetadataModelCopyWith<$Res> {
  factory _$$SyncMetadataModelImplCopyWith(_$SyncMetadataModelImpl value,
          $Res Function(_$SyncMetadataModelImpl) then) =
      __$$SyncMetadataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime lastSyncTime,
      Map<String, String> fileIdMapping,
      Map<String, DateTime> lastModifiedTimes,
      String appVersion});
}

/// @nodoc
class __$$SyncMetadataModelImplCopyWithImpl<$Res>
    extends _$SyncMetadataModelCopyWithImpl<$Res, _$SyncMetadataModelImpl>
    implements _$$SyncMetadataModelImplCopyWith<$Res> {
  __$$SyncMetadataModelImplCopyWithImpl(_$SyncMetadataModelImpl _value,
      $Res Function(_$SyncMetadataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncMetadataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncTime = null,
    Object? fileIdMapping = null,
    Object? lastModifiedTimes = null,
    Object? appVersion = null,
  }) {
    return _then(_$SyncMetadataModelImpl(
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
@JsonSerializable()
class _$SyncMetadataModelImpl implements _SyncMetadataModel {
  const _$SyncMetadataModelImpl(
      {required this.lastSyncTime,
      required final Map<String, String> fileIdMapping,
      required final Map<String, DateTime> lastModifiedTimes,
      required this.appVersion})
      : _fileIdMapping = fileIdMapping,
        _lastModifiedTimes = lastModifiedTimes;

  factory _$SyncMetadataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncMetadataModelImplFromJson(json);

  @override
  final DateTime lastSyncTime;
  final Map<String, String> _fileIdMapping;
  @override
  Map<String, String> get fileIdMapping {
    if (_fileIdMapping is EqualUnmodifiableMapView) return _fileIdMapping;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fileIdMapping);
  }

  final Map<String, DateTime> _lastModifiedTimes;
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
    return 'SyncMetadataModel(lastSyncTime: $lastSyncTime, fileIdMapping: $fileIdMapping, lastModifiedTimes: $lastModifiedTimes, appVersion: $appVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncMetadataModelImpl &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            const DeepCollectionEquality()
                .equals(other._fileIdMapping, _fileIdMapping) &&
            const DeepCollectionEquality()
                .equals(other._lastModifiedTimes, _lastModifiedTimes) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastSyncTime,
      const DeepCollectionEquality().hash(_fileIdMapping),
      const DeepCollectionEquality().hash(_lastModifiedTimes),
      appVersion);

  /// Create a copy of SyncMetadataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncMetadataModelImplCopyWith<_$SyncMetadataModelImpl> get copyWith =>
      __$$SyncMetadataModelImplCopyWithImpl<_$SyncMetadataModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncMetadataModelImplToJson(
      this,
    );
  }
}

abstract class _SyncMetadataModel implements SyncMetadataModel {
  const factory _SyncMetadataModel(
      {required final DateTime lastSyncTime,
      required final Map<String, String> fileIdMapping,
      required final Map<String, DateTime> lastModifiedTimes,
      required final String appVersion}) = _$SyncMetadataModelImpl;

  factory _SyncMetadataModel.fromJson(Map<String, dynamic> json) =
      _$SyncMetadataModelImpl.fromJson;

  @override
  DateTime get lastSyncTime;
  @override
  Map<String, String> get fileIdMapping;
  @override
  Map<String, DateTime> get lastModifiedTimes;
  @override
  String get appVersion;

  /// Create a copy of SyncMetadataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncMetadataModelImplCopyWith<_$SyncMetadataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
