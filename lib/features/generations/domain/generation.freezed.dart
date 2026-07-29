// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Generation {

 String get id; String get status; int get reservedCredits; String get workflowType; Map<String, dynamic> get progress; String? get videoUrl;
/// Create a copy of Generation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerationCopyWith<Generation> get copyWith => _$GenerationCopyWithImpl<Generation>(this as Generation, _$identity);

  /// Serializes this Generation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Generation&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.reservedCredits, reservedCredits) || other.reservedCredits == reservedCredits)&&(identical(other.workflowType, workflowType) || other.workflowType == workflowType)&&const DeepCollectionEquality().equals(other.progress, progress)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,reservedCredits,workflowType,const DeepCollectionEquality().hash(progress),videoUrl);

@override
String toString() {
  return 'Generation(id: $id, status: $status, reservedCredits: $reservedCredits, workflowType: $workflowType, progress: $progress, videoUrl: $videoUrl)';
}


}

/// @nodoc
abstract mixin class $GenerationCopyWith<$Res>  {
  factory $GenerationCopyWith(Generation value, $Res Function(Generation) _then) = _$GenerationCopyWithImpl;
@useResult
$Res call({
 String id, String status, int reservedCredits, String workflowType, Map<String, dynamic> progress, String? videoUrl
});




}
/// @nodoc
class _$GenerationCopyWithImpl<$Res>
    implements $GenerationCopyWith<$Res> {
  _$GenerationCopyWithImpl(this._self, this._then);

  final Generation _self;
  final $Res Function(Generation) _then;

/// Create a copy of Generation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? reservedCredits = null,Object? workflowType = null,Object? progress = null,Object? videoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reservedCredits: null == reservedCredits ? _self.reservedCredits : reservedCredits // ignore: cast_nullable_to_non_nullable
as int,workflowType: null == workflowType ? _self.workflowType : workflowType // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Generation].
extension GenerationPatterns on Generation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Generation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Generation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Generation value)  $default,){
final _that = this;
switch (_that) {
case _Generation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Generation value)?  $default,){
final _that = this;
switch (_that) {
case _Generation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  int reservedCredits,  String workflowType,  Map<String, dynamic> progress,  String? videoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Generation() when $default != null:
return $default(_that.id,_that.status,_that.reservedCredits,_that.workflowType,_that.progress,_that.videoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  int reservedCredits,  String workflowType,  Map<String, dynamic> progress,  String? videoUrl)  $default,) {final _that = this;
switch (_that) {
case _Generation():
return $default(_that.id,_that.status,_that.reservedCredits,_that.workflowType,_that.progress,_that.videoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  int reservedCredits,  String workflowType,  Map<String, dynamic> progress,  String? videoUrl)?  $default,) {final _that = this;
switch (_that) {
case _Generation() when $default != null:
return $default(_that.id,_that.status,_that.reservedCredits,_that.workflowType,_that.progress,_that.videoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Generation implements Generation {
  const _Generation({required this.id, required this.status, required this.reservedCredits, required this.workflowType, required final  Map<String, dynamic> progress, this.videoUrl}): _progress = progress;
  factory _Generation.fromJson(Map<String, dynamic> json) => _$GenerationFromJson(json);

@override final  String id;
@override final  String status;
@override final  int reservedCredits;
@override final  String workflowType;
 final  Map<String, dynamic> _progress;
@override Map<String, dynamic> get progress {
  if (_progress is EqualUnmodifiableMapView) return _progress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_progress);
}

@override final  String? videoUrl;

/// Create a copy of Generation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerationCopyWith<_Generation> get copyWith => __$GenerationCopyWithImpl<_Generation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Generation&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.reservedCredits, reservedCredits) || other.reservedCredits == reservedCredits)&&(identical(other.workflowType, workflowType) || other.workflowType == workflowType)&&const DeepCollectionEquality().equals(other._progress, _progress)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,reservedCredits,workflowType,const DeepCollectionEquality().hash(_progress),videoUrl);

@override
String toString() {
  return 'Generation(id: $id, status: $status, reservedCredits: $reservedCredits, workflowType: $workflowType, progress: $progress, videoUrl: $videoUrl)';
}


}

/// @nodoc
abstract mixin class _$GenerationCopyWith<$Res> implements $GenerationCopyWith<$Res> {
  factory _$GenerationCopyWith(_Generation value, $Res Function(_Generation) _then) = __$GenerationCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, int reservedCredits, String workflowType, Map<String, dynamic> progress, String? videoUrl
});




}
/// @nodoc
class __$GenerationCopyWithImpl<$Res>
    implements _$GenerationCopyWith<$Res> {
  __$GenerationCopyWithImpl(this._self, this._then);

  final _Generation _self;
  final $Res Function(_Generation) _then;

/// Create a copy of Generation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? reservedCredits = null,Object? workflowType = null,Object? progress = null,Object? videoUrl = freezed,}) {
  return _then(_Generation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reservedCredits: null == reservedCredits ? _self.reservedCredits : reservedCredits // ignore: cast_nullable_to_non_nullable
as int,workflowType: null == workflowType ? _self.workflowType : workflowType // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self._progress : progress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
