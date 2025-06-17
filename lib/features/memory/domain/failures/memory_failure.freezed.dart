// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MemoryFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function() notFound,
    required TResult Function() invalidData,
    required TResult Function() storageError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function()? notFound,
    TResult? Function()? invalidData,
    TResult? Function()? storageError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function()? notFound,
    TResult Function()? invalidData,
    TResult Function()? storageError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidData value) invalidData,
    required TResult Function(_StorageError value) storageError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidData value)? invalidData,
    TResult? Function(_StorageError value)? storageError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidData value)? invalidData,
    TResult Function(_StorageError value)? storageError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryFailureCopyWith<$Res> {
  factory $MemoryFailureCopyWith(
          MemoryFailure value, $Res Function(MemoryFailure) then) =
      _$MemoryFailureCopyWithImpl<$Res, MemoryFailure>;
}

/// @nodoc
class _$MemoryFailureCopyWithImpl<$Res, $Val extends MemoryFailure>
    implements $MemoryFailureCopyWith<$Res> {
  _$MemoryFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoryFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UnexpectedImplCopyWith<$Res> {
  factory _$$UnexpectedImplCopyWith(
          _$UnexpectedImpl value, $Res Function(_$UnexpectedImpl) then) =
      __$$UnexpectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnexpectedImplCopyWithImpl<$Res>
    extends _$MemoryFailureCopyWithImpl<$Res, _$UnexpectedImpl>
    implements _$$UnexpectedImplCopyWith<$Res> {
  __$$UnexpectedImplCopyWithImpl(
      _$UnexpectedImpl _value, $Res Function(_$UnexpectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoryFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnexpectedImpl implements _Unexpected {
  const _$UnexpectedImpl();

  @override
  String toString() {
    return 'MemoryFailure.unexpected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnexpectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function() notFound,
    required TResult Function() invalidData,
    required TResult Function() storageError,
  }) {
    return unexpected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function()? notFound,
    TResult? Function()? invalidData,
    TResult? Function()? storageError,
  }) {
    return unexpected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function()? notFound,
    TResult Function()? invalidData,
    TResult Function()? storageError,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidData value) invalidData,
    required TResult Function(_StorageError value) storageError,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidData value)? invalidData,
    TResult? Function(_StorageError value)? storageError,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidData value)? invalidData,
    TResult Function(_StorageError value)? storageError,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class _Unexpected implements MemoryFailure {
  const factory _Unexpected() = _$UnexpectedImpl;
}

/// @nodoc
abstract class _$$NotFoundImplCopyWith<$Res> {
  factory _$$NotFoundImplCopyWith(
          _$NotFoundImpl value, $Res Function(_$NotFoundImpl) then) =
      __$$NotFoundImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotFoundImplCopyWithImpl<$Res>
    extends _$MemoryFailureCopyWithImpl<$Res, _$NotFoundImpl>
    implements _$$NotFoundImplCopyWith<$Res> {
  __$$NotFoundImplCopyWithImpl(
      _$NotFoundImpl _value, $Res Function(_$NotFoundImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoryFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotFoundImpl implements _NotFound {
  const _$NotFoundImpl();

  @override
  String toString() {
    return 'MemoryFailure.notFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotFoundImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function() notFound,
    required TResult Function() invalidData,
    required TResult Function() storageError,
  }) {
    return notFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function()? notFound,
    TResult? Function()? invalidData,
    TResult? Function()? storageError,
  }) {
    return notFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function()? notFound,
    TResult Function()? invalidData,
    TResult Function()? storageError,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidData value) invalidData,
    required TResult Function(_StorageError value) storageError,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidData value)? invalidData,
    TResult? Function(_StorageError value)? storageError,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidData value)? invalidData,
    TResult Function(_StorageError value)? storageError,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class _NotFound implements MemoryFailure {
  const factory _NotFound() = _$NotFoundImpl;
}

/// @nodoc
abstract class _$$InvalidDataImplCopyWith<$Res> {
  factory _$$InvalidDataImplCopyWith(
          _$InvalidDataImpl value, $Res Function(_$InvalidDataImpl) then) =
      __$$InvalidDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidDataImplCopyWithImpl<$Res>
    extends _$MemoryFailureCopyWithImpl<$Res, _$InvalidDataImpl>
    implements _$$InvalidDataImplCopyWith<$Res> {
  __$$InvalidDataImplCopyWithImpl(
      _$InvalidDataImpl _value, $Res Function(_$InvalidDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoryFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvalidDataImpl implements _InvalidData {
  const _$InvalidDataImpl();

  @override
  String toString() {
    return 'MemoryFailure.invalidData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function() notFound,
    required TResult Function() invalidData,
    required TResult Function() storageError,
  }) {
    return invalidData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function()? notFound,
    TResult? Function()? invalidData,
    TResult? Function()? storageError,
  }) {
    return invalidData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function()? notFound,
    TResult Function()? invalidData,
    TResult Function()? storageError,
    required TResult orElse(),
  }) {
    if (invalidData != null) {
      return invalidData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidData value) invalidData,
    required TResult Function(_StorageError value) storageError,
  }) {
    return invalidData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidData value)? invalidData,
    TResult? Function(_StorageError value)? storageError,
  }) {
    return invalidData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidData value)? invalidData,
    TResult Function(_StorageError value)? storageError,
    required TResult orElse(),
  }) {
    if (invalidData != null) {
      return invalidData(this);
    }
    return orElse();
  }
}

abstract class _InvalidData implements MemoryFailure {
  const factory _InvalidData() = _$InvalidDataImpl;
}

/// @nodoc
abstract class _$$StorageErrorImplCopyWith<$Res> {
  factory _$$StorageErrorImplCopyWith(
          _$StorageErrorImpl value, $Res Function(_$StorageErrorImpl) then) =
      __$$StorageErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StorageErrorImplCopyWithImpl<$Res>
    extends _$MemoryFailureCopyWithImpl<$Res, _$StorageErrorImpl>
    implements _$$StorageErrorImplCopyWith<$Res> {
  __$$StorageErrorImplCopyWithImpl(
      _$StorageErrorImpl _value, $Res Function(_$StorageErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoryFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StorageErrorImpl implements _StorageError {
  const _$StorageErrorImpl();

  @override
  String toString() {
    return 'MemoryFailure.storageError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StorageErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unexpected,
    required TResult Function() notFound,
    required TResult Function() invalidData,
    required TResult Function() storageError,
  }) {
    return storageError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unexpected,
    TResult? Function()? notFound,
    TResult? Function()? invalidData,
    TResult? Function()? storageError,
  }) {
    return storageError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unexpected,
    TResult Function()? notFound,
    TResult Function()? invalidData,
    TResult Function()? storageError,
    required TResult orElse(),
  }) {
    if (storageError != null) {
      return storageError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unexpected value) unexpected,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidData value) invalidData,
    required TResult Function(_StorageError value) storageError,
  }) {
    return storageError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unexpected value)? unexpected,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidData value)? invalidData,
    TResult? Function(_StorageError value)? storageError,
  }) {
    return storageError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unexpected value)? unexpected,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidData value)? invalidData,
    TResult Function(_StorageError value)? storageError,
    required TResult orElse(),
  }) {
    if (storageError != null) {
      return storageError(this);
    }
    return orElse();
  }
}

abstract class _StorageError implements MemoryFailure {
  const factory _StorageError() = _$StorageErrorImpl;
}
