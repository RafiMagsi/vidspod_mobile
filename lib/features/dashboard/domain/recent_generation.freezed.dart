// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_generation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecentGeneration {

 String get id; String get thumbnailUrl; String get status;
/// Create a copy of RecentGeneration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentGenerationCopyWith<RecentGeneration> get copyWith => _$RecentGenerationCopyWithImpl<RecentGeneration>(this as RecentGeneration, _$identity);

  /// Serializes this RecentGeneration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentGeneration&&(identical(other.id, id) || other.id == id)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,thumbnailUrl,status);

@override
String toString() {
  return 'RecentGeneration(id: $id, thumbnailUrl: $thumbnailUrl, status: $status)';
}


}

/// @nodoc
abstract mixin class $RecentGenerationCopyWith<$Res>  {
  factory $RecentGenerationCopyWith(RecentGeneration value, $Res Function(RecentGeneration) _then) = _$RecentGenerationCopyWithImpl;
@useResult
$Res call({
 String id, String thumbnailUrl, String status
});




}
/// @nodoc
class _$RecentGenerationCopyWithImpl<$Res>
    implements $RecentGenerationCopyWith<$Res> {
  _$RecentGenerationCopyWithImpl(this._self, this._then);

  final RecentGeneration _self;
  final $Res Function(RecentGeneration) _then;

/// Create a copy of RecentGeneration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? thumbnailUrl = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentGeneration].
extension RecentGenerationPatterns on RecentGeneration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentGeneration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentGeneration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentGeneration value)  $default,){
final _that = this;
switch (_that) {
case _RecentGeneration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentGeneration value)?  $default,){
final _that = this;
switch (_that) {
case _RecentGeneration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String thumbnailUrl,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentGeneration() when $default != null:
return $default(_that.id,_that.thumbnailUrl,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String thumbnailUrl,  String status)  $default,) {final _that = this;
switch (_that) {
case _RecentGeneration():
return $default(_that.id,_that.thumbnailUrl,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String thumbnailUrl,  String status)?  $default,) {final _that = this;
switch (_that) {
case _RecentGeneration() when $default != null:
return $default(_that.id,_that.thumbnailUrl,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentGeneration implements RecentGeneration {
  const _RecentGeneration({required this.id, required this.thumbnailUrl, required this.status});
  factory _RecentGeneration.fromJson(Map<String, dynamic> json) => _$RecentGenerationFromJson(json);

@override final  String id;
@override final  String thumbnailUrl;
@override final  String status;

/// Create a copy of RecentGeneration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentGenerationCopyWith<_RecentGeneration> get copyWith => __$RecentGenerationCopyWithImpl<_RecentGeneration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentGenerationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentGeneration&&(identical(other.id, id) || other.id == id)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,thumbnailUrl,status);

@override
String toString() {
  return 'RecentGeneration(id: $id, thumbnailUrl: $thumbnailUrl, status: $status)';
}


}

/// @nodoc
abstract mixin class _$RecentGenerationCopyWith<$Res> implements $RecentGenerationCopyWith<$Res> {
  factory _$RecentGenerationCopyWith(_RecentGeneration value, $Res Function(_RecentGeneration) _then) = __$RecentGenerationCopyWithImpl;
@override @useResult
$Res call({
 String id, String thumbnailUrl, String status
});




}
/// @nodoc
class __$RecentGenerationCopyWithImpl<$Res>
    implements _$RecentGenerationCopyWith<$Res> {
  __$RecentGenerationCopyWithImpl(this._self, this._then);

  final _RecentGeneration _self;
  final $Res Function(_RecentGeneration) _then;

/// Create a copy of RecentGeneration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? thumbnailUrl = null,Object? status = null,}) {
  return _then(_RecentGeneration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
