// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_generation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageGeneration {

 String get generationId;
/// Create a copy of ImageGeneration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageGenerationCopyWith<ImageGeneration> get copyWith => _$ImageGenerationCopyWithImpl<ImageGeneration>(this as ImageGeneration, _$identity);

  /// Serializes this ImageGeneration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGeneration&&(identical(other.generationId, generationId) || other.generationId == generationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,generationId);

@override
String toString() {
  return 'ImageGeneration(generationId: $generationId)';
}


}

/// @nodoc
abstract mixin class $ImageGenerationCopyWith<$Res>  {
  factory $ImageGenerationCopyWith(ImageGeneration value, $Res Function(ImageGeneration) _then) = _$ImageGenerationCopyWithImpl;
@useResult
$Res call({
 String generationId
});




}
/// @nodoc
class _$ImageGenerationCopyWithImpl<$Res>
    implements $ImageGenerationCopyWith<$Res> {
  _$ImageGenerationCopyWithImpl(this._self, this._then);

  final ImageGeneration _self;
  final $Res Function(ImageGeneration) _then;

/// Create a copy of ImageGeneration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? generationId = null,}) {
  return _then(_self.copyWith(
generationId: null == generationId ? _self.generationId : generationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageGeneration].
extension ImageGenerationPatterns on ImageGeneration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageGeneration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageGeneration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageGeneration value)  $default,){
final _that = this;
switch (_that) {
case _ImageGeneration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageGeneration value)?  $default,){
final _that = this;
switch (_that) {
case _ImageGeneration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String generationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageGeneration() when $default != null:
return $default(_that.generationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String generationId)  $default,) {final _that = this;
switch (_that) {
case _ImageGeneration():
return $default(_that.generationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String generationId)?  $default,) {final _that = this;
switch (_that) {
case _ImageGeneration() when $default != null:
return $default(_that.generationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageGeneration implements ImageGeneration {
  const _ImageGeneration({required this.generationId});
  factory _ImageGeneration.fromJson(Map<String, dynamic> json) => _$ImageGenerationFromJson(json);

@override final  String generationId;

/// Create a copy of ImageGeneration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageGenerationCopyWith<_ImageGeneration> get copyWith => __$ImageGenerationCopyWithImpl<_ImageGeneration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageGenerationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageGeneration&&(identical(other.generationId, generationId) || other.generationId == generationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,generationId);

@override
String toString() {
  return 'ImageGeneration(generationId: $generationId)';
}


}

/// @nodoc
abstract mixin class _$ImageGenerationCopyWith<$Res> implements $ImageGenerationCopyWith<$Res> {
  factory _$ImageGenerationCopyWith(_ImageGeneration value, $Res Function(_ImageGeneration) _then) = __$ImageGenerationCopyWithImpl;
@override @useResult
$Res call({
 String generationId
});




}
/// @nodoc
class __$ImageGenerationCopyWithImpl<$Res>
    implements _$ImageGenerationCopyWith<$Res> {
  __$ImageGenerationCopyWithImpl(this._self, this._then);

  final _ImageGeneration _self;
  final $Res Function(_ImageGeneration) _then;

/// Create a copy of ImageGeneration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? generationId = null,}) {
  return _then(_ImageGeneration(
generationId: null == generationId ? _self.generationId : generationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ImageGenerationStatus {

 String get id; String get status; List<String> get resultUrls; List<String> get resultPaths; String? get projectId; String? get errorMessage;
/// Create a copy of ImageGenerationStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageGenerationStatusCopyWith<ImageGenerationStatus> get copyWith => _$ImageGenerationStatusCopyWithImpl<ImageGenerationStatus>(this as ImageGenerationStatus, _$identity);

  /// Serializes this ImageGenerationStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.resultUrls, resultUrls)&&const DeepCollectionEquality().equals(other.resultPaths, resultPaths)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,const DeepCollectionEquality().hash(resultUrls),const DeepCollectionEquality().hash(resultPaths),projectId,errorMessage);

@override
String toString() {
  return 'ImageGenerationStatus(id: $id, status: $status, resultUrls: $resultUrls, resultPaths: $resultPaths, projectId: $projectId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ImageGenerationStatusCopyWith<$Res>  {
  factory $ImageGenerationStatusCopyWith(ImageGenerationStatus value, $Res Function(ImageGenerationStatus) _then) = _$ImageGenerationStatusCopyWithImpl;
@useResult
$Res call({
 String id, String status, List<String> resultUrls, List<String> resultPaths, String? projectId, String? errorMessage
});




}
/// @nodoc
class _$ImageGenerationStatusCopyWithImpl<$Res>
    implements $ImageGenerationStatusCopyWith<$Res> {
  _$ImageGenerationStatusCopyWithImpl(this._self, this._then);

  final ImageGenerationStatus _self;
  final $Res Function(ImageGenerationStatus) _then;

/// Create a copy of ImageGenerationStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? resultUrls = null,Object? resultPaths = null,Object? projectId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,resultUrls: null == resultUrls ? _self.resultUrls : resultUrls // ignore: cast_nullable_to_non_nullable
as List<String>,resultPaths: null == resultPaths ? _self.resultPaths : resultPaths // ignore: cast_nullable_to_non_nullable
as List<String>,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageGenerationStatus].
extension ImageGenerationStatusPatterns on ImageGenerationStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageGenerationStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageGenerationStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageGenerationStatus value)  $default,){
final _that = this;
switch (_that) {
case _ImageGenerationStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageGenerationStatus value)?  $default,){
final _that = this;
switch (_that) {
case _ImageGenerationStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  List<String> resultUrls,  List<String> resultPaths,  String? projectId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageGenerationStatus() when $default != null:
return $default(_that.id,_that.status,_that.resultUrls,_that.resultPaths,_that.projectId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  List<String> resultUrls,  List<String> resultPaths,  String? projectId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ImageGenerationStatus():
return $default(_that.id,_that.status,_that.resultUrls,_that.resultPaths,_that.projectId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  List<String> resultUrls,  List<String> resultPaths,  String? projectId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ImageGenerationStatus() when $default != null:
return $default(_that.id,_that.status,_that.resultUrls,_that.resultPaths,_that.projectId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageGenerationStatus implements ImageGenerationStatus {
  const _ImageGenerationStatus({required this.id, required this.status, required final  List<String> resultUrls, required final  List<String> resultPaths, this.projectId, this.errorMessage}): _resultUrls = resultUrls,_resultPaths = resultPaths;
  factory _ImageGenerationStatus.fromJson(Map<String, dynamic> json) => _$ImageGenerationStatusFromJson(json);

@override final  String id;
@override final  String status;
 final  List<String> _resultUrls;
@override List<String> get resultUrls {
  if (_resultUrls is EqualUnmodifiableListView) return _resultUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resultUrls);
}

 final  List<String> _resultPaths;
@override List<String> get resultPaths {
  if (_resultPaths is EqualUnmodifiableListView) return _resultPaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resultPaths);
}

@override final  String? projectId;
@override final  String? errorMessage;

/// Create a copy of ImageGenerationStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageGenerationStatusCopyWith<_ImageGenerationStatus> get copyWith => __$ImageGenerationStatusCopyWithImpl<_ImageGenerationStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageGenerationStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageGenerationStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._resultUrls, _resultUrls)&&const DeepCollectionEquality().equals(other._resultPaths, _resultPaths)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,const DeepCollectionEquality().hash(_resultUrls),const DeepCollectionEquality().hash(_resultPaths),projectId,errorMessage);

@override
String toString() {
  return 'ImageGenerationStatus(id: $id, status: $status, resultUrls: $resultUrls, resultPaths: $resultPaths, projectId: $projectId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ImageGenerationStatusCopyWith<$Res> implements $ImageGenerationStatusCopyWith<$Res> {
  factory _$ImageGenerationStatusCopyWith(_ImageGenerationStatus value, $Res Function(_ImageGenerationStatus) _then) = __$ImageGenerationStatusCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, List<String> resultUrls, List<String> resultPaths, String? projectId, String? errorMessage
});




}
/// @nodoc
class __$ImageGenerationStatusCopyWithImpl<$Res>
    implements _$ImageGenerationStatusCopyWith<$Res> {
  __$ImageGenerationStatusCopyWithImpl(this._self, this._then);

  final _ImageGenerationStatus _self;
  final $Res Function(_ImageGenerationStatus) _then;

/// Create a copy of ImageGenerationStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? resultUrls = null,Object? resultPaths = null,Object? projectId = freezed,Object? errorMessage = freezed,}) {
  return _then(_ImageGenerationStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,resultUrls: null == resultUrls ? _self._resultUrls : resultUrls // ignore: cast_nullable_to_non_nullable
as List<String>,resultPaths: null == resultPaths ? _self._resultPaths : resultPaths // ignore: cast_nullable_to_non_nullable
as List<String>,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
