// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'research_run.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResearchRun {

 String get id; String get topic; String get status; Map<String, dynamic> get progress;
/// Create a copy of ResearchRun
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResearchRunCopyWith<ResearchRun> get copyWith => _$ResearchRunCopyWithImpl<ResearchRun>(this as ResearchRun, _$identity);

  /// Serializes this ResearchRun to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResearchRun&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.progress, progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,status,const DeepCollectionEquality().hash(progress));

@override
String toString() {
  return 'ResearchRun(id: $id, topic: $topic, status: $status, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $ResearchRunCopyWith<$Res>  {
  factory $ResearchRunCopyWith(ResearchRun value, $Res Function(ResearchRun) _then) = _$ResearchRunCopyWithImpl;
@useResult
$Res call({
 String id, String topic, String status, Map<String, dynamic> progress
});




}
/// @nodoc
class _$ResearchRunCopyWithImpl<$Res>
    implements $ResearchRunCopyWith<$Res> {
  _$ResearchRunCopyWithImpl(this._self, this._then);

  final ResearchRun _self;
  final $Res Function(ResearchRun) _then;

/// Create a copy of ResearchRun
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? topic = null,Object? status = null,Object? progress = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResearchRun].
extension ResearchRunPatterns on ResearchRun {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResearchRun value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResearchRun() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResearchRun value)  $default,){
final _that = this;
switch (_that) {
case _ResearchRun():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResearchRun value)?  $default,){
final _that = this;
switch (_that) {
case _ResearchRun() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String topic,  String status,  Map<String, dynamic> progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResearchRun() when $default != null:
return $default(_that.id,_that.topic,_that.status,_that.progress);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String topic,  String status,  Map<String, dynamic> progress)  $default,) {final _that = this;
switch (_that) {
case _ResearchRun():
return $default(_that.id,_that.topic,_that.status,_that.progress);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String topic,  String status,  Map<String, dynamic> progress)?  $default,) {final _that = this;
switch (_that) {
case _ResearchRun() when $default != null:
return $default(_that.id,_that.topic,_that.status,_that.progress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResearchRun implements ResearchRun {
  const _ResearchRun({required this.id, required this.topic, required this.status, required final  Map<String, dynamic> progress}): _progress = progress;
  factory _ResearchRun.fromJson(Map<String, dynamic> json) => _$ResearchRunFromJson(json);

@override final  String id;
@override final  String topic;
@override final  String status;
 final  Map<String, dynamic> _progress;
@override Map<String, dynamic> get progress {
  if (_progress is EqualUnmodifiableMapView) return _progress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_progress);
}


/// Create a copy of ResearchRun
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResearchRunCopyWith<_ResearchRun> get copyWith => __$ResearchRunCopyWithImpl<_ResearchRun>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResearchRunToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResearchRun&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._progress, _progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,status,const DeepCollectionEquality().hash(_progress));

@override
String toString() {
  return 'ResearchRun(id: $id, topic: $topic, status: $status, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$ResearchRunCopyWith<$Res> implements $ResearchRunCopyWith<$Res> {
  factory _$ResearchRunCopyWith(_ResearchRun value, $Res Function(_ResearchRun) _then) = __$ResearchRunCopyWithImpl;
@override @useResult
$Res call({
 String id, String topic, String status, Map<String, dynamic> progress
});




}
/// @nodoc
class __$ResearchRunCopyWithImpl<$Res>
    implements _$ResearchRunCopyWith<$Res> {
  __$ResearchRunCopyWithImpl(this._self, this._then);

  final _ResearchRun _self;
  final $Res Function(_ResearchRun) _then;

/// Create a copy of ResearchRun
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? topic = null,Object? status = null,Object? progress = null,}) {
  return _then(_ResearchRun(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self._progress : progress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
