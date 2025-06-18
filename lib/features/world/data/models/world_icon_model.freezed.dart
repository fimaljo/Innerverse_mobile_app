// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_icon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorldIconModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  IconData get icon => throw _privateConstructorUsedError;

  /// Create a copy of WorldIconModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorldIconModelCopyWith<WorldIconModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldIconModelCopyWith<$Res> {
  factory $WorldIconModelCopyWith(
          WorldIconModel value, $Res Function(WorldIconModel) then) =
      _$WorldIconModelCopyWithImpl<$Res, WorldIconModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) IconData icon});
}

/// @nodoc
class _$WorldIconModelCopyWithImpl<$Res, $Val extends WorldIconModel>
    implements $WorldIconModelCopyWith<$Res> {
  _$WorldIconModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorldIconModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
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
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorldIconModelImplCopyWith<$Res>
    implements $WorldIconModelCopyWith<$Res> {
  factory _$$WorldIconModelImplCopyWith(_$WorldIconModelImpl value,
          $Res Function(_$WorldIconModelImpl) then) =
      __$$WorldIconModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) IconData icon});
}

/// @nodoc
class __$$WorldIconModelImplCopyWithImpl<$Res>
    extends _$WorldIconModelCopyWithImpl<$Res, _$WorldIconModelImpl>
    implements _$$WorldIconModelImplCopyWith<$Res> {
  __$$WorldIconModelImplCopyWithImpl(
      _$WorldIconModelImpl _value, $Res Function(_$WorldIconModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorldIconModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
  }) {
    return _then(_$WorldIconModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
    ));
  }
}

/// @nodoc

class _$WorldIconModelImpl extends _WorldIconModel {
  const _$WorldIconModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.icon})
      : super._();

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final IconData icon;

  @override
  String toString() {
    return 'WorldIconModel(id: $id, name: $name, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldIconModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon);

  /// Create a copy of WorldIconModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldIconModelImplCopyWith<_$WorldIconModelImpl> get copyWith =>
      __$$WorldIconModelImplCopyWithImpl<_$WorldIconModelImpl>(
          this, _$identity);
}

abstract class _WorldIconModel extends WorldIconModel {
  const factory _WorldIconModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final IconData icon}) = _$WorldIconModelImpl;
  const _WorldIconModel._() : super._();

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  IconData get icon;

  /// Create a copy of WorldIconModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorldIconModelImplCopyWith<_$WorldIconModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
