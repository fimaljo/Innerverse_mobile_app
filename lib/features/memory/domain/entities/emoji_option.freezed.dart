// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emoji_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmojiOption {
  String get riveAsset => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  List<Color> get gradient => throw _privateConstructorUsedError;
  Color get particleColor => throw _privateConstructorUsedError;

  /// Create a copy of EmojiOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmojiOptionCopyWith<EmojiOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmojiOptionCopyWith<$Res> {
  factory $EmojiOptionCopyWith(
          EmojiOption value, $Res Function(EmojiOption) then) =
      _$EmojiOptionCopyWithImpl<$Res, EmojiOption>;
  @useResult
  $Res call(
      {String riveAsset,
      String label,
      List<Color> gradient,
      Color particleColor});
}

/// @nodoc
class _$EmojiOptionCopyWithImpl<$Res, $Val extends EmojiOption>
    implements $EmojiOptionCopyWith<$Res> {
  _$EmojiOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmojiOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? riveAsset = null,
    Object? label = null,
    Object? gradient = null,
    Object? particleColor = null,
  }) {
    return _then(_value.copyWith(
      riveAsset: null == riveAsset
          ? _value.riveAsset
          : riveAsset // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      gradient: null == gradient
          ? _value.gradient
          : gradient // ignore: cast_nullable_to_non_nullable
              as List<Color>,
      particleColor: null == particleColor
          ? _value.particleColor
          : particleColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmojiOptionImplCopyWith<$Res>
    implements $EmojiOptionCopyWith<$Res> {
  factory _$$EmojiOptionImplCopyWith(
          _$EmojiOptionImpl value, $Res Function(_$EmojiOptionImpl) then) =
      __$$EmojiOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String riveAsset,
      String label,
      List<Color> gradient,
      Color particleColor});
}

/// @nodoc
class __$$EmojiOptionImplCopyWithImpl<$Res>
    extends _$EmojiOptionCopyWithImpl<$Res, _$EmojiOptionImpl>
    implements _$$EmojiOptionImplCopyWith<$Res> {
  __$$EmojiOptionImplCopyWithImpl(
      _$EmojiOptionImpl _value, $Res Function(_$EmojiOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmojiOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? riveAsset = null,
    Object? label = null,
    Object? gradient = null,
    Object? particleColor = null,
  }) {
    return _then(_$EmojiOptionImpl(
      riveAsset: null == riveAsset
          ? _value.riveAsset
          : riveAsset // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      gradient: null == gradient
          ? _value._gradient
          : gradient // ignore: cast_nullable_to_non_nullable
              as List<Color>,
      particleColor: null == particleColor
          ? _value.particleColor
          : particleColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$EmojiOptionImpl implements _EmojiOption {
  const _$EmojiOptionImpl(
      {required this.riveAsset,
      required this.label,
      required final List<Color> gradient,
      required this.particleColor})
      : _gradient = gradient;

  @override
  final String riveAsset;
  @override
  final String label;
  final List<Color> _gradient;
  @override
  List<Color> get gradient {
    if (_gradient is EqualUnmodifiableListView) return _gradient;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gradient);
  }

  @override
  final Color particleColor;

  @override
  String toString() {
    return 'EmojiOption(riveAsset: $riveAsset, label: $label, gradient: $gradient, particleColor: $particleColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmojiOptionImpl &&
            (identical(other.riveAsset, riveAsset) ||
                other.riveAsset == riveAsset) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._gradient, _gradient) &&
            (identical(other.particleColor, particleColor) ||
                other.particleColor == particleColor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, riveAsset, label,
      const DeepCollectionEquality().hash(_gradient), particleColor);

  /// Create a copy of EmojiOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmojiOptionImplCopyWith<_$EmojiOptionImpl> get copyWith =>
      __$$EmojiOptionImplCopyWithImpl<_$EmojiOptionImpl>(this, _$identity);
}

abstract class _EmojiOption implements EmojiOption {
  const factory _EmojiOption(
      {required final String riveAsset,
      required final String label,
      required final List<Color> gradient,
      required final Color particleColor}) = _$EmojiOptionImpl;

  @override
  String get riveAsset;
  @override
  String get label;
  @override
  List<Color> get gradient;
  @override
  Color get particleColor;

  /// Create a copy of EmojiOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmojiOptionImplCopyWith<_$EmojiOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
