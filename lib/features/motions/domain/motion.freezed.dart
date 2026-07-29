// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'motion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Motion {

 String get publicGuid; String get title; String get description; String get thumbnailUrl; String get previewVideoUrl; String get referenceType; int get creditPrice; List<String> get supportedAspectRatios; bool get isAvailable;
/// Create a copy of Motion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotionCopyWith<Motion> get copyWith => _$MotionCopyWithImpl<Motion>(this as Motion, _$identity);

  /// Serializes this Motion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Motion&&(identical(other.publicGuid, publicGuid) || other.publicGuid == publicGuid)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.previewVideoUrl, previewVideoUrl) || other.previewVideoUrl == previewVideoUrl)&&(identical(other.referenceType, referenceType) || other.referenceType == referenceType)&&(identical(other.creditPrice, creditPrice) || other.creditPrice == creditPrice)&&const DeepCollectionEquality().equals(other.supportedAspectRatios, supportedAspectRatios)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicGuid,title,description,thumbnailUrl,previewVideoUrl,referenceType,creditPrice,const DeepCollectionEquality().hash(supportedAspectRatios),isAvailable);

@override
String toString() {
  return 'Motion(publicGuid: $publicGuid, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, previewVideoUrl: $previewVideoUrl, referenceType: $referenceType, creditPrice: $creditPrice, supportedAspectRatios: $supportedAspectRatios, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $MotionCopyWith<$Res>  {
  factory $MotionCopyWith(Motion value, $Res Function(Motion) _then) = _$MotionCopyWithImpl;
@useResult
$Res call({
 String publicGuid, String title, String description, String thumbnailUrl, String previewVideoUrl, String referenceType, int creditPrice, List<String> supportedAspectRatios, bool isAvailable
});




}
/// @nodoc
class _$MotionCopyWithImpl<$Res>
    implements $MotionCopyWith<$Res> {
  _$MotionCopyWithImpl(this._self, this._then);

  final Motion _self;
  final $Res Function(Motion) _then;

/// Create a copy of Motion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? publicGuid = null,Object? title = null,Object? description = null,Object? thumbnailUrl = null,Object? previewVideoUrl = null,Object? referenceType = null,Object? creditPrice = null,Object? supportedAspectRatios = null,Object? isAvailable = null,}) {
  return _then(_self.copyWith(
publicGuid: null == publicGuid ? _self.publicGuid : publicGuid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,previewVideoUrl: null == previewVideoUrl ? _self.previewVideoUrl : previewVideoUrl // ignore: cast_nullable_to_non_nullable
as String,referenceType: null == referenceType ? _self.referenceType : referenceType // ignore: cast_nullable_to_non_nullable
as String,creditPrice: null == creditPrice ? _self.creditPrice : creditPrice // ignore: cast_nullable_to_non_nullable
as int,supportedAspectRatios: null == supportedAspectRatios ? _self.supportedAspectRatios : supportedAspectRatios // ignore: cast_nullable_to_non_nullable
as List<String>,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Motion].
extension MotionPatterns on Motion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Motion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Motion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Motion value)  $default,){
final _that = this;
switch (_that) {
case _Motion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Motion value)?  $default,){
final _that = this;
switch (_that) {
case _Motion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String publicGuid,  String title,  String description,  String thumbnailUrl,  String previewVideoUrl,  String referenceType,  int creditPrice,  List<String> supportedAspectRatios,  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Motion() when $default != null:
return $default(_that.publicGuid,_that.title,_that.description,_that.thumbnailUrl,_that.previewVideoUrl,_that.referenceType,_that.creditPrice,_that.supportedAspectRatios,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String publicGuid,  String title,  String description,  String thumbnailUrl,  String previewVideoUrl,  String referenceType,  int creditPrice,  List<String> supportedAspectRatios,  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _Motion():
return $default(_that.publicGuid,_that.title,_that.description,_that.thumbnailUrl,_that.previewVideoUrl,_that.referenceType,_that.creditPrice,_that.supportedAspectRatios,_that.isAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String publicGuid,  String title,  String description,  String thumbnailUrl,  String previewVideoUrl,  String referenceType,  int creditPrice,  List<String> supportedAspectRatios,  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _Motion() when $default != null:
return $default(_that.publicGuid,_that.title,_that.description,_that.thumbnailUrl,_that.previewVideoUrl,_that.referenceType,_that.creditPrice,_that.supportedAspectRatios,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Motion implements Motion {
  const _Motion({required this.publicGuid, required this.title, required this.description, required this.thumbnailUrl, required this.previewVideoUrl, required this.referenceType, required this.creditPrice, required final  List<String> supportedAspectRatios, required this.isAvailable}): _supportedAspectRatios = supportedAspectRatios;
  factory _Motion.fromJson(Map<String, dynamic> json) => _$MotionFromJson(json);

@override final  String publicGuid;
@override final  String title;
@override final  String description;
@override final  String thumbnailUrl;
@override final  String previewVideoUrl;
@override final  String referenceType;
@override final  int creditPrice;
 final  List<String> _supportedAspectRatios;
@override List<String> get supportedAspectRatios {
  if (_supportedAspectRatios is EqualUnmodifiableListView) return _supportedAspectRatios;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportedAspectRatios);
}

@override final  bool isAvailable;

/// Create a copy of Motion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotionCopyWith<_Motion> get copyWith => __$MotionCopyWithImpl<_Motion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MotionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Motion&&(identical(other.publicGuid, publicGuid) || other.publicGuid == publicGuid)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.previewVideoUrl, previewVideoUrl) || other.previewVideoUrl == previewVideoUrl)&&(identical(other.referenceType, referenceType) || other.referenceType == referenceType)&&(identical(other.creditPrice, creditPrice) || other.creditPrice == creditPrice)&&const DeepCollectionEquality().equals(other._supportedAspectRatios, _supportedAspectRatios)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicGuid,title,description,thumbnailUrl,previewVideoUrl,referenceType,creditPrice,const DeepCollectionEquality().hash(_supportedAspectRatios),isAvailable);

@override
String toString() {
  return 'Motion(publicGuid: $publicGuid, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, previewVideoUrl: $previewVideoUrl, referenceType: $referenceType, creditPrice: $creditPrice, supportedAspectRatios: $supportedAspectRatios, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$MotionCopyWith<$Res> implements $MotionCopyWith<$Res> {
  factory _$MotionCopyWith(_Motion value, $Res Function(_Motion) _then) = __$MotionCopyWithImpl;
@override @useResult
$Res call({
 String publicGuid, String title, String description, String thumbnailUrl, String previewVideoUrl, String referenceType, int creditPrice, List<String> supportedAspectRatios, bool isAvailable
});




}
/// @nodoc
class __$MotionCopyWithImpl<$Res>
    implements _$MotionCopyWith<$Res> {
  __$MotionCopyWithImpl(this._self, this._then);

  final _Motion _self;
  final $Res Function(_Motion) _then;

/// Create a copy of Motion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? publicGuid = null,Object? title = null,Object? description = null,Object? thumbnailUrl = null,Object? previewVideoUrl = null,Object? referenceType = null,Object? creditPrice = null,Object? supportedAspectRatios = null,Object? isAvailable = null,}) {
  return _then(_Motion(
publicGuid: null == publicGuid ? _self.publicGuid : publicGuid // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,previewVideoUrl: null == previewVideoUrl ? _self.previewVideoUrl : previewVideoUrl // ignore: cast_nullable_to_non_nullable
as String,referenceType: null == referenceType ? _self.referenceType : referenceType // ignore: cast_nullable_to_non_nullable
as String,creditPrice: null == creditPrice ? _self.creditPrice : creditPrice // ignore: cast_nullable_to_non_nullable
as int,supportedAspectRatios: null == supportedAspectRatios ? _self._supportedAspectRatios : supportedAspectRatios // ignore: cast_nullable_to_non_nullable
as List<String>,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
