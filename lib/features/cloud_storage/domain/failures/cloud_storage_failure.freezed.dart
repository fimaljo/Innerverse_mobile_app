// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cloud_storage_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CloudStorageFailure {
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloudStorageFailureCopyWith<CloudStorageFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudStorageFailureCopyWith<$Res> {
  factory $CloudStorageFailureCopyWith(
          CloudStorageFailure value, $Res Function(CloudStorageFailure) then) =
      _$CloudStorageFailureCopyWithImpl<$Res, CloudStorageFailure>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$CloudStorageFailureCopyWithImpl<$Res, $Val extends CloudStorageFailure>
    implements $CloudStorageFailureCopyWith<$Res> {
  _$CloudStorageFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res>
    implements $CloudStorageFailureCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
          _$ServerErrorImpl value, $Res Function(_$ServerErrorImpl) then) =
      __$$ServerErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$CloudStorageFailureCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
      _$ServerErrorImpl _value, $Res Function(_$ServerErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ServerErrorImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServerErrorImpl implements ServerError {
  const _$ServerErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'CloudStorageFailure.serverError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      __$$ServerErrorImplCopyWithImpl<_$ServerErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) {
    return serverError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) {
    return serverError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ServerError implements CloudStorageFailure {
  const factory ServerError([final String? message]) = _$ServerErrorImpl;

  @override
  String? get message;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res>
    implements $CloudStorageFailureCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
          _$NetworkErrorImpl value, $Res Function(_$NetworkErrorImpl) then) =
      __$$NetworkErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$CloudStorageFailureCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
      _$NetworkErrorImpl _value, $Res Function(_$NetworkErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NetworkErrorImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NetworkErrorImpl implements NetworkError {
  const _$NetworkErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'CloudStorageFailure.networkError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      __$$NetworkErrorImplCopyWithImpl<_$NetworkErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) {
    return networkError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) {
    return networkError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class NetworkError implements CloudStorageFailure {
  const factory NetworkError([final String? message]) = _$NetworkErrorImpl;

  @override
  String? get message;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationErrorImplCopyWith<$Res>
    implements $CloudStorageFailureCopyWith<$Res> {
  factory _$$AuthenticationErrorImplCopyWith(_$AuthenticationErrorImpl value,
          $Res Function(_$AuthenticationErrorImpl) then) =
      __$$AuthenticationErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AuthenticationErrorImplCopyWithImpl<$Res>
    extends _$CloudStorageFailureCopyWithImpl<$Res, _$AuthenticationErrorImpl>
    implements _$$AuthenticationErrorImplCopyWith<$Res> {
  __$$AuthenticationErrorImplCopyWithImpl(_$AuthenticationErrorImpl _value,
      $Res Function(_$AuthenticationErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AuthenticationErrorImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthenticationErrorImpl implements AuthenticationError {
  const _$AuthenticationErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'CloudStorageFailure.authenticationError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationErrorImplCopyWith<_$AuthenticationErrorImpl> get copyWith =>
      __$$AuthenticationErrorImplCopyWithImpl<_$AuthenticationErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) {
    return authenticationError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) {
    return authenticationError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) {
    if (authenticationError != null) {
      return authenticationError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) {
    return authenticationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) {
    return authenticationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (authenticationError != null) {
      return authenticationError(this);
    }
    return orElse();
  }
}

abstract class AuthenticationError implements CloudStorageFailure {
  const factory AuthenticationError([final String? message]) =
      _$AuthenticationErrorImpl;

  @override
  String? get message;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationErrorImplCopyWith<_$AuthenticationErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionErrorImplCopyWith<$Res>
    implements $CloudStorageFailureCopyWith<$Res> {
  factory _$$PermissionErrorImplCopyWith(_$PermissionErrorImpl value,
          $Res Function(_$PermissionErrorImpl) then) =
      __$$PermissionErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$PermissionErrorImplCopyWithImpl<$Res>
    extends _$CloudStorageFailureCopyWithImpl<$Res, _$PermissionErrorImpl>
    implements _$$PermissionErrorImplCopyWith<$Res> {
  __$$PermissionErrorImplCopyWithImpl(
      _$PermissionErrorImpl _value, $Res Function(_$PermissionErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$PermissionErrorImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PermissionErrorImpl implements PermissionError {
  const _$PermissionErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'CloudStorageFailure.permissionError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionErrorImplCopyWith<_$PermissionErrorImpl> get copyWith =>
      __$$PermissionErrorImplCopyWithImpl<_$PermissionErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) {
    return permissionError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) {
    return permissionError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) {
    if (permissionError != null) {
      return permissionError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) {
    return permissionError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) {
    return permissionError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (permissionError != null) {
      return permissionError(this);
    }
    return orElse();
  }
}

abstract class PermissionError implements CloudStorageFailure {
  const factory PermissionError([final String? message]) =
      _$PermissionErrorImpl;

  @override
  String? get message;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionErrorImplCopyWith<_$PermissionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuotaExceededImplCopyWith<$Res>
    implements $CloudStorageFailureCopyWith<$Res> {
  factory _$$QuotaExceededImplCopyWith(
          _$QuotaExceededImpl value, $Res Function(_$QuotaExceededImpl) then) =
      __$$QuotaExceededImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$QuotaExceededImplCopyWithImpl<$Res>
    extends _$CloudStorageFailureCopyWithImpl<$Res, _$QuotaExceededImpl>
    implements _$$QuotaExceededImplCopyWith<$Res> {
  __$$QuotaExceededImplCopyWithImpl(
      _$QuotaExceededImpl _value, $Res Function(_$QuotaExceededImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$QuotaExceededImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$QuotaExceededImpl implements QuotaExceeded {
  const _$QuotaExceededImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'CloudStorageFailure.quotaExceeded(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuotaExceededImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuotaExceededImplCopyWith<_$QuotaExceededImpl> get copyWith =>
      __$$QuotaExceededImplCopyWithImpl<_$QuotaExceededImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) {
    return quotaExceeded(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) {
    return quotaExceeded?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) {
    if (quotaExceeded != null) {
      return quotaExceeded(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) {
    return quotaExceeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) {
    return quotaExceeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (quotaExceeded != null) {
      return quotaExceeded(this);
    }
    return orElse();
  }
}

abstract class QuotaExceeded implements CloudStorageFailure {
  const factory QuotaExceeded([final String? message]) = _$QuotaExceededImpl;

  @override
  String? get message;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuotaExceededImplCopyWith<_$QuotaExceededImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileNotFoundImplCopyWith<$Res>
    implements $CloudStorageFailureCopyWith<$Res> {
  factory _$$FileNotFoundImplCopyWith(
          _$FileNotFoundImpl value, $Res Function(_$FileNotFoundImpl) then) =
      __$$FileNotFoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$FileNotFoundImplCopyWithImpl<$Res>
    extends _$CloudStorageFailureCopyWithImpl<$Res, _$FileNotFoundImpl>
    implements _$$FileNotFoundImplCopyWith<$Res> {
  __$$FileNotFoundImplCopyWithImpl(
      _$FileNotFoundImpl _value, $Res Function(_$FileNotFoundImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$FileNotFoundImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FileNotFoundImpl implements FileNotFound {
  const _$FileNotFoundImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'CloudStorageFailure.fileNotFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileNotFoundImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileNotFoundImplCopyWith<_$FileNotFoundImpl> get copyWith =>
      __$$FileNotFoundImplCopyWithImpl<_$FileNotFoundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) {
    return fileNotFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) {
    return fileNotFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) {
    if (fileNotFound != null) {
      return fileNotFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) {
    return fileNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) {
    return fileNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (fileNotFound != null) {
      return fileNotFound(this);
    }
    return orElse();
  }
}

abstract class FileNotFound implements CloudStorageFailure {
  const factory FileNotFound([final String? message]) = _$FileNotFoundImpl;

  @override
  String? get message;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileNotFoundImplCopyWith<_$FileNotFoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncConflictImplCopyWith<$Res>
    implements $CloudStorageFailureCopyWith<$Res> {
  factory _$$SyncConflictImplCopyWith(
          _$SyncConflictImpl value, $Res Function(_$SyncConflictImpl) then) =
      __$$SyncConflictImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SyncConflictImplCopyWithImpl<$Res>
    extends _$CloudStorageFailureCopyWithImpl<$Res, _$SyncConflictImpl>
    implements _$$SyncConflictImplCopyWith<$Res> {
  __$$SyncConflictImplCopyWithImpl(
      _$SyncConflictImpl _value, $Res Function(_$SyncConflictImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SyncConflictImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SyncConflictImpl implements SyncConflict {
  const _$SyncConflictImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'CloudStorageFailure.syncConflict(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncConflictImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncConflictImplCopyWith<_$SyncConflictImpl> get copyWith =>
      __$$SyncConflictImplCopyWithImpl<_$SyncConflictImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) {
    return syncConflict(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) {
    return syncConflict?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) {
    if (syncConflict != null) {
      return syncConflict(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) {
    return syncConflict(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) {
    return syncConflict?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (syncConflict != null) {
      return syncConflict(this);
    }
    return orElse();
  }
}

abstract class SyncConflict implements CloudStorageFailure {
  const factory SyncConflict([final String? message]) = _$SyncConflictImpl;

  @override
  String? get message;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncConflictImplCopyWith<_$SyncConflictImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownErrorImplCopyWith<$Res>
    implements $CloudStorageFailureCopyWith<$Res> {
  factory _$$UnknownErrorImplCopyWith(
          _$UnknownErrorImpl value, $Res Function(_$UnknownErrorImpl) then) =
      __$$UnknownErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UnknownErrorImplCopyWithImpl<$Res>
    extends _$CloudStorageFailureCopyWithImpl<$Res, _$UnknownErrorImpl>
    implements _$$UnknownErrorImplCopyWith<$Res> {
  __$$UnknownErrorImplCopyWithImpl(
      _$UnknownErrorImpl _value, $Res Function(_$UnknownErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UnknownErrorImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownErrorImpl implements UnknownError {
  const _$UnknownErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'CloudStorageFailure.unknownError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      __$$UnknownErrorImplCopyWithImpl<_$UnknownErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) serverError,
    required TResult Function(String? message) networkError,
    required TResult Function(String? message) authenticationError,
    required TResult Function(String? message) permissionError,
    required TResult Function(String? message) quotaExceeded,
    required TResult Function(String? message) fileNotFound,
    required TResult Function(String? message) syncConflict,
    required TResult Function(String? message) unknownError,
  }) {
    return unknownError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? serverError,
    TResult? Function(String? message)? networkError,
    TResult? Function(String? message)? authenticationError,
    TResult? Function(String? message)? permissionError,
    TResult? Function(String? message)? quotaExceeded,
    TResult? Function(String? message)? fileNotFound,
    TResult? Function(String? message)? syncConflict,
    TResult? Function(String? message)? unknownError,
  }) {
    return unknownError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? serverError,
    TResult Function(String? message)? networkError,
    TResult Function(String? message)? authenticationError,
    TResult Function(String? message)? permissionError,
    TResult Function(String? message)? quotaExceeded,
    TResult Function(String? message)? fileNotFound,
    TResult Function(String? message)? syncConflict,
    TResult Function(String? message)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerError value) serverError,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(AuthenticationError value) authenticationError,
    required TResult Function(PermissionError value) permissionError,
    required TResult Function(QuotaExceeded value) quotaExceeded,
    required TResult Function(FileNotFound value) fileNotFound,
    required TResult Function(SyncConflict value) syncConflict,
    required TResult Function(UnknownError value) unknownError,
  }) {
    return unknownError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerError value)? serverError,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(AuthenticationError value)? authenticationError,
    TResult? Function(PermissionError value)? permissionError,
    TResult? Function(QuotaExceeded value)? quotaExceeded,
    TResult? Function(FileNotFound value)? fileNotFound,
    TResult? Function(SyncConflict value)? syncConflict,
    TResult? Function(UnknownError value)? unknownError,
  }) {
    return unknownError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerError value)? serverError,
    TResult Function(NetworkError value)? networkError,
    TResult Function(AuthenticationError value)? authenticationError,
    TResult Function(PermissionError value)? permissionError,
    TResult Function(QuotaExceeded value)? quotaExceeded,
    TResult Function(FileNotFound value)? fileNotFound,
    TResult Function(SyncConflict value)? syncConflict,
    TResult Function(UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(this);
    }
    return orElse();
  }
}

abstract class UnknownError implements CloudStorageFailure {
  const factory UnknownError([final String? message]) = _$UnknownErrorImpl;

  @override
  String? get message;

  /// Create a copy of CloudStorageFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
