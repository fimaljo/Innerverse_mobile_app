// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MemoryModel _$MemoryModelFromJson(Map<String, dynamic> json) {
  return _MemoryModel.fromJson(json);
}

/// @nodoc
mixin _$MemoryModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get emojiLabel => throw _privateConstructorUsedError;
  @HiveField(2)
  String get riveAsset => throw _privateConstructorUsedError;
  @HiveField(3)
  double get emotionSliderValue => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get dateTime => throw _privateConstructorUsedError;
  @HiveField(5)
  @TimeOfDayConverter()
  TimeOfDay get time => throw _privateConstructorUsedError;
  @HiveField(8)
  @WorldIconModelConverter()
  WorldIconModel get worldIcon => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get title => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(9)
  List<String>? get images => throw _privateConstructorUsedError;

  /// Serializes this MemoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoryModelCopyWith<MemoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryModelCopyWith<$Res> {
  factory $MemoryModelCopyWith(
          MemoryModel value, $Res Function(MemoryModel) then) =
      _$MemoryModelCopyWithImpl<$Res, MemoryModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String emojiLabel,
      @HiveField(2) String riveAsset,
      @HiveField(3) double emotionSliderValue,
      @HiveField(4) DateTime dateTime,
      @HiveField(5) @TimeOfDayConverter() TimeOfDay time,
      @HiveField(8) @WorldIconModelConverter() WorldIconModel worldIcon,
      @HiveField(6) String? title,
      @HiveField(7) String? description,
      @HiveField(9) List<String>? images});

  $WorldIconModelCopyWith<$Res> get worldIcon;
}

/// @nodoc
class _$MemoryModelCopyWithImpl<$Res, $Val extends MemoryModel>
    implements $MemoryModelCopyWith<$Res> {
  _$MemoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? emojiLabel = null,
    Object? riveAsset = null,
    Object? emotionSliderValue = null,
    Object? dateTime = null,
    Object? time = null,
    Object? worldIcon = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? images = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      emojiLabel: null == emojiLabel
          ? _value.emojiLabel
          : emojiLabel // ignore: cast_nullable_to_non_nullable
              as String,
      riveAsset: null == riveAsset
          ? _value.riveAsset
          : riveAsset // ignore: cast_nullable_to_non_nullable
              as String,
      emotionSliderValue: null == emotionSliderValue
          ? _value.emotionSliderValue
          : emotionSliderValue // ignore: cast_nullable_to_non_nullable
              as double,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      worldIcon: null == worldIcon
          ? _value.worldIcon
          : worldIcon // ignore: cast_nullable_to_non_nullable
              as WorldIconModel,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  /// Create a copy of MemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorldIconModelCopyWith<$Res> get worldIcon {
    return $WorldIconModelCopyWith<$Res>(_value.worldIcon, (value) {
      return _then(_value.copyWith(worldIcon: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MemoryModelImplCopyWith<$Res>
    implements $MemoryModelCopyWith<$Res> {
  factory _$$MemoryModelImplCopyWith(
          _$MemoryModelImpl value, $Res Function(_$MemoryModelImpl) then) =
      __$$MemoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String emojiLabel,
      @HiveField(2) String riveAsset,
      @HiveField(3) double emotionSliderValue,
      @HiveField(4) DateTime dateTime,
      @HiveField(5) @TimeOfDayConverter() TimeOfDay time,
      @HiveField(8) @WorldIconModelConverter() WorldIconModel worldIcon,
      @HiveField(6) String? title,
      @HiveField(7) String? description,
      @HiveField(9) List<String>? images});

  @override
  $WorldIconModelCopyWith<$Res> get worldIcon;
}

/// @nodoc
class __$$MemoryModelImplCopyWithImpl<$Res>
    extends _$MemoryModelCopyWithImpl<$Res, _$MemoryModelImpl>
    implements _$$MemoryModelImplCopyWith<$Res> {
  __$$MemoryModelImplCopyWithImpl(
      _$MemoryModelImpl _value, $Res Function(_$MemoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? emojiLabel = null,
    Object? riveAsset = null,
    Object? emotionSliderValue = null,
    Object? dateTime = null,
    Object? time = null,
    Object? worldIcon = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? images = freezed,
  }) {
    return _then(_$MemoryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      emojiLabel: null == emojiLabel
          ? _value.emojiLabel
          : emojiLabel // ignore: cast_nullable_to_non_nullable
              as String,
      riveAsset: null == riveAsset
          ? _value.riveAsset
          : riveAsset // ignore: cast_nullable_to_non_nullable
              as String,
      emotionSliderValue: null == emotionSliderValue
          ? _value.emotionSliderValue
          : emotionSliderValue // ignore: cast_nullable_to_non_nullable
              as double,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      worldIcon: null == worldIcon
          ? _value.worldIcon
          : worldIcon // ignore: cast_nullable_to_non_nullable
              as WorldIconModel,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemoryModelImpl implements _MemoryModel {
  const _$MemoryModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.emojiLabel,
      @HiveField(2) required this.riveAsset,
      @HiveField(3) required this.emotionSliderValue,
      @HiveField(4) required this.dateTime,
      @HiveField(5) @TimeOfDayConverter() required this.time,
      @HiveField(8) @WorldIconModelConverter() required this.worldIcon,
      @HiveField(6) this.title,
      @HiveField(7) this.description,
      @HiveField(9) final List<String>? images})
      : _images = images;

  factory _$MemoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemoryModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String emojiLabel;
  @override
  @HiveField(2)
  final String riveAsset;
  @override
  @HiveField(3)
  final double emotionSliderValue;
  @override
  @HiveField(4)
  final DateTime dateTime;
  @override
  @HiveField(5)
  @TimeOfDayConverter()
  final TimeOfDay time;
  @override
  @HiveField(8)
  @WorldIconModelConverter()
  final WorldIconModel worldIcon;
  @override
  @HiveField(6)
  final String? title;
  @override
  @HiveField(7)
  final String? description;
  final List<String>? _images;
  @override
  @HiveField(9)
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MemoryModel(id: $id, emojiLabel: $emojiLabel, riveAsset: $riveAsset, emotionSliderValue: $emotionSliderValue, dateTime: $dateTime, time: $time, worldIcon: $worldIcon, title: $title, description: $description, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.emojiLabel, emojiLabel) ||
                other.emojiLabel == emojiLabel) &&
            (identical(other.riveAsset, riveAsset) ||
                other.riveAsset == riveAsset) &&
            (identical(other.emotionSliderValue, emotionSliderValue) ||
                other.emotionSliderValue == emotionSliderValue) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.worldIcon, worldIcon) ||
                other.worldIcon == worldIcon) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      emojiLabel,
      riveAsset,
      emotionSliderValue,
      dateTime,
      time,
      worldIcon,
      title,
      description,
      const DeepCollectionEquality().hash(_images));

  /// Create a copy of MemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoryModelImplCopyWith<_$MemoryModelImpl> get copyWith =>
      __$$MemoryModelImplCopyWithImpl<_$MemoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoryModelImplToJson(
      this,
    );
  }
}

abstract class _MemoryModel implements MemoryModel {
  const factory _MemoryModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String emojiLabel,
      @HiveField(2) required final String riveAsset,
      @HiveField(3) required final double emotionSliderValue,
      @HiveField(4) required final DateTime dateTime,
      @HiveField(5) @TimeOfDayConverter() required final TimeOfDay time,
      @HiveField(8)
      @WorldIconModelConverter()
      required final WorldIconModel worldIcon,
      @HiveField(6) final String? title,
      @HiveField(7) final String? description,
      @HiveField(9) final List<String>? images}) = _$MemoryModelImpl;

  factory _MemoryModel.fromJson(Map<String, dynamic> json) =
      _$MemoryModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get emojiLabel;
  @override
  @HiveField(2)
  String get riveAsset;
  @override
  @HiveField(3)
  double get emotionSliderValue;
  @override
  @HiveField(4)
  DateTime get dateTime;
  @override
  @HiveField(5)
  @TimeOfDayConverter()
  TimeOfDay get time;
  @override
  @HiveField(8)
  @WorldIconModelConverter()
  WorldIconModel get worldIcon;
  @override
  @HiveField(6)
  String? get title;
  @override
  @HiveField(7)
  String? get description;
  @override
  @HiveField(9)
  List<String>? get images;

  /// Create a copy of MemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoryModelImplCopyWith<_$MemoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
