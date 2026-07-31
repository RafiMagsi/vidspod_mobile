// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectListItem {

 String get id; String get title; String get status; String get creationMode; String get aspectRatio; int get targetDurationSeconds; String? get previewUrl; String? get finalUrl; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ProjectListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectListItemCopyWith<ProjectListItem> get copyWith => _$ProjectListItemCopyWithImpl<ProjectListItem>(this as ProjectListItem, _$identity);

  /// Serializes this ProjectListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.creationMode, creationMode) || other.creationMode == creationMode)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.targetDurationSeconds, targetDurationSeconds) || other.targetDurationSeconds == targetDurationSeconds)&&(identical(other.previewUrl, previewUrl) || other.previewUrl == previewUrl)&&(identical(other.finalUrl, finalUrl) || other.finalUrl == finalUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,creationMode,aspectRatio,targetDurationSeconds,previewUrl,finalUrl,createdAt,updatedAt);

@override
String toString() {
  return 'ProjectListItem(id: $id, title: $title, status: $status, creationMode: $creationMode, aspectRatio: $aspectRatio, targetDurationSeconds: $targetDurationSeconds, previewUrl: $previewUrl, finalUrl: $finalUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ProjectListItemCopyWith<$Res>  {
  factory $ProjectListItemCopyWith(ProjectListItem value, $Res Function(ProjectListItem) _then) = _$ProjectListItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String status, String creationMode, String aspectRatio, int targetDurationSeconds, String? previewUrl, String? finalUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ProjectListItemCopyWithImpl<$Res>
    implements $ProjectListItemCopyWith<$Res> {
  _$ProjectListItemCopyWithImpl(this._self, this._then);

  final ProjectListItem _self;
  final $Res Function(ProjectListItem) _then;

/// Create a copy of ProjectListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? creationMode = null,Object? aspectRatio = null,Object? targetDurationSeconds = null,Object? previewUrl = freezed,Object? finalUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,creationMode: null == creationMode ? _self.creationMode : creationMode // ignore: cast_nullable_to_non_nullable
as String,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as String,targetDurationSeconds: null == targetDurationSeconds ? _self.targetDurationSeconds : targetDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,previewUrl: freezed == previewUrl ? _self.previewUrl : previewUrl // ignore: cast_nullable_to_non_nullable
as String?,finalUrl: freezed == finalUrl ? _self.finalUrl : finalUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectListItem].
extension ProjectListItemPatterns on ProjectListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectListItem value)  $default,){
final _that = this;
switch (_that) {
case _ProjectListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectListItem value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String status,  String creationMode,  String aspectRatio,  int targetDurationSeconds,  String? previewUrl,  String? finalUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectListItem() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.creationMode,_that.aspectRatio,_that.targetDurationSeconds,_that.previewUrl,_that.finalUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String status,  String creationMode,  String aspectRatio,  int targetDurationSeconds,  String? previewUrl,  String? finalUrl,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ProjectListItem():
return $default(_that.id,_that.title,_that.status,_that.creationMode,_that.aspectRatio,_that.targetDurationSeconds,_that.previewUrl,_that.finalUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String status,  String creationMode,  String aspectRatio,  int targetDurationSeconds,  String? previewUrl,  String? finalUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ProjectListItem() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.creationMode,_that.aspectRatio,_that.targetDurationSeconds,_that.previewUrl,_that.finalUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectListItem implements ProjectListItem {
  const _ProjectListItem({required this.id, required this.title, required this.status, required this.creationMode, required this.aspectRatio, required this.targetDurationSeconds, this.previewUrl, this.finalUrl, required this.createdAt, required this.updatedAt});
  factory _ProjectListItem.fromJson(Map<String, dynamic> json) => _$ProjectListItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  String status;
@override final  String creationMode;
@override final  String aspectRatio;
@override final  int targetDurationSeconds;
@override final  String? previewUrl;
@override final  String? finalUrl;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ProjectListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectListItemCopyWith<_ProjectListItem> get copyWith => __$ProjectListItemCopyWithImpl<_ProjectListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.creationMode, creationMode) || other.creationMode == creationMode)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.targetDurationSeconds, targetDurationSeconds) || other.targetDurationSeconds == targetDurationSeconds)&&(identical(other.previewUrl, previewUrl) || other.previewUrl == previewUrl)&&(identical(other.finalUrl, finalUrl) || other.finalUrl == finalUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,creationMode,aspectRatio,targetDurationSeconds,previewUrl,finalUrl,createdAt,updatedAt);

@override
String toString() {
  return 'ProjectListItem(id: $id, title: $title, status: $status, creationMode: $creationMode, aspectRatio: $aspectRatio, targetDurationSeconds: $targetDurationSeconds, previewUrl: $previewUrl, finalUrl: $finalUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ProjectListItemCopyWith<$Res> implements $ProjectListItemCopyWith<$Res> {
  factory _$ProjectListItemCopyWith(_ProjectListItem value, $Res Function(_ProjectListItem) _then) = __$ProjectListItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String status, String creationMode, String aspectRatio, int targetDurationSeconds, String? previewUrl, String? finalUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ProjectListItemCopyWithImpl<$Res>
    implements _$ProjectListItemCopyWith<$Res> {
  __$ProjectListItemCopyWithImpl(this._self, this._then);

  final _ProjectListItem _self;
  final $Res Function(_ProjectListItem) _then;

/// Create a copy of ProjectListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? creationMode = null,Object? aspectRatio = null,Object? targetDurationSeconds = null,Object? previewUrl = freezed,Object? finalUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ProjectListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,creationMode: null == creationMode ? _self.creationMode : creationMode // ignore: cast_nullable_to_non_nullable
as String,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as String,targetDurationSeconds: null == targetDurationSeconds ? _self.targetDurationSeconds : targetDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,previewUrl: freezed == previewUrl ? _self.previewUrl : previewUrl // ignore: cast_nullable_to_non_nullable
as String?,finalUrl: freezed == finalUrl ? _self.finalUrl : finalUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
