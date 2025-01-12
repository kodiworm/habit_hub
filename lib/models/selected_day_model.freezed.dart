// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_day_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectedDay {
  DateTime get selectedDay => throw _privateConstructorUsedError;
  List<Habit> get habits => throw _privateConstructorUsedError;

  /// Create a copy of SelectedDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedDayCopyWith<SelectedDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedDayCopyWith<$Res> {
  factory $SelectedDayCopyWith(
          SelectedDay value, $Res Function(SelectedDay) then) =
      _$SelectedDayCopyWithImpl<$Res, SelectedDay>;
  @useResult
  $Res call({DateTime selectedDay, List<Habit> habits});
}

/// @nodoc
class _$SelectedDayCopyWithImpl<$Res, $Val extends SelectedDay>
    implements $SelectedDayCopyWith<$Res> {
  _$SelectedDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDay = null,
    Object? habits = null,
  }) {
    return _then(_value.copyWith(
      selectedDay: null == selectedDay
          ? _value.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      habits: null == habits
          ? _value.habits
          : habits // ignore: cast_nullable_to_non_nullable
              as List<Habit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectedDayImplCopyWith<$Res>
    implements $SelectedDayCopyWith<$Res> {
  factory _$$SelectedDayImplCopyWith(
          _$SelectedDayImpl value, $Res Function(_$SelectedDayImpl) then) =
      __$$SelectedDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDay, List<Habit> habits});
}

/// @nodoc
class __$$SelectedDayImplCopyWithImpl<$Res>
    extends _$SelectedDayCopyWithImpl<$Res, _$SelectedDayImpl>
    implements _$$SelectedDayImplCopyWith<$Res> {
  __$$SelectedDayImplCopyWithImpl(
      _$SelectedDayImpl _value, $Res Function(_$SelectedDayImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectedDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDay = null,
    Object? habits = null,
  }) {
    return _then(_$SelectedDayImpl(
      selectedDay: null == selectedDay
          ? _value.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      habits: null == habits
          ? _value.habits
          : habits // ignore: cast_nullable_to_non_nullable
              as List<Habit>,
    ));
  }
}

/// @nodoc

class _$SelectedDayImpl with DiagnosticableTreeMixin implements _SelectedDay {
  const _$SelectedDayImpl({required this.selectedDay, required this.habits});

  @override
  final DateTime selectedDay;
  @override
  final List<Habit> habits;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SelectedDay(selectedDay: $selectedDay, habits: $habits)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SelectedDay'))
      ..add(DiagnosticsProperty('selectedDay', selectedDay))
      ..add(DiagnosticsProperty('habits', habits));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedDayImpl &&
            (identical(other.selectedDay, selectedDay) ||
                other.selectedDay == selectedDay) &&
            const DeepCollectionEquality().equals(other.habits, habits));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedDay, const DeepCollectionEquality().hash(habits));

  /// Create a copy of SelectedDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedDayImplCopyWith<_$SelectedDayImpl> get copyWith =>
      __$$SelectedDayImplCopyWithImpl<_$SelectedDayImpl>(this, _$identity);
}

abstract class _SelectedDay implements SelectedDay {
  const factory _SelectedDay(
      {required final DateTime selectedDay,
      required final List<Habit> habits}) = _$SelectedDayImpl;

  @override
  DateTime get selectedDay;
  @override
  List<Habit> get habits;

  /// Create a copy of SelectedDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedDayImplCopyWith<_$SelectedDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
