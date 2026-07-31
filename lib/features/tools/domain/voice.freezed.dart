// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Voice {

 String get id; String get name; String get provider; String? get style; String? get language; String? get accent; String? get gender; String? get description; String? get bestFor;
/// Create a copy of Voice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceCopyWith<Voice> get copyWith => _$VoiceCopyWithImpl<Voice>(this as Voice, _$identity);

  /// Serializes this Voice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Voice&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.style, style) || other.style == style)&&(identical(other.language, language) || other.language == language)&&(identical(other.accent, accent) || other.accent == accent)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.description, description) || other.description == description)&&(identical(other.bestFor, bestFor) || other.bestFor == bestFor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,provider,style,language,accent,gender,description,bestFor);

@override
String toString() {
  return 'Voice(id: $id, name: $name, provider: $provider, style: $style, language: $language, accent: $accent, gender: $gender, description: $description, bestFor: $bestFor)';
}


}

/// @nodoc
abstract mixin class $VoiceCopyWith<$Res>  {
  factory $VoiceCopyWith(Voice value, $Res Function(Voice) _then) = _$VoiceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String provider, String? style, String? language, String? accent, String? gender, String? description, String? bestFor
});




}
/// @nodoc
class _$VoiceCopyWithImpl<$Res>
    implements $VoiceCopyWith<$Res> {
  _$VoiceCopyWithImpl(this._self, this._then);

  final Voice _self;
  final $Res Function(Voice) _then;

/// Create a copy of Voice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? provider = null,Object? style = freezed,Object? language = freezed,Object? accent = freezed,Object? gender = freezed,Object? description = freezed,Object? bestFor = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,style: freezed == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,accent: freezed == accent ? _self.accent : accent // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bestFor: freezed == bestFor ? _self.bestFor : bestFor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Voice].
extension VoicePatterns on Voice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Voice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Voice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Voice value)  $default,){
final _that = this;
switch (_that) {
case _Voice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Voice value)?  $default,){
final _that = this;
switch (_that) {
case _Voice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String provider,  String? style,  String? language,  String? accent,  String? gender,  String? description,  String? bestFor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Voice() when $default != null:
return $default(_that.id,_that.name,_that.provider,_that.style,_that.language,_that.accent,_that.gender,_that.description,_that.bestFor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String provider,  String? style,  String? language,  String? accent,  String? gender,  String? description,  String? bestFor)  $default,) {final _that = this;
switch (_that) {
case _Voice():
return $default(_that.id,_that.name,_that.provider,_that.style,_that.language,_that.accent,_that.gender,_that.description,_that.bestFor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String provider,  String? style,  String? language,  String? accent,  String? gender,  String? description,  String? bestFor)?  $default,) {final _that = this;
switch (_that) {
case _Voice() when $default != null:
return $default(_that.id,_that.name,_that.provider,_that.style,_that.language,_that.accent,_that.gender,_that.description,_that.bestFor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Voice extends Voice {
  const _Voice({required this.id, required this.name, required this.provider, this.style, this.language, this.accent, this.gender, this.description, this.bestFor}): super._();
  factory _Voice.fromJson(Map<String, dynamic> json) => _$VoiceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String provider;
@override final  String? style;
@override final  String? language;
@override final  String? accent;
@override final  String? gender;
@override final  String? description;
@override final  String? bestFor;

/// Create a copy of Voice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceCopyWith<_Voice> get copyWith => __$VoiceCopyWithImpl<_Voice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Voice&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.style, style) || other.style == style)&&(identical(other.language, language) || other.language == language)&&(identical(other.accent, accent) || other.accent == accent)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.description, description) || other.description == description)&&(identical(other.bestFor, bestFor) || other.bestFor == bestFor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,provider,style,language,accent,gender,description,bestFor);

@override
String toString() {
  return 'Voice(id: $id, name: $name, provider: $provider, style: $style, language: $language, accent: $accent, gender: $gender, description: $description, bestFor: $bestFor)';
}


}

/// @nodoc
abstract mixin class _$VoiceCopyWith<$Res> implements $VoiceCopyWith<$Res> {
  factory _$VoiceCopyWith(_Voice value, $Res Function(_Voice) _then) = __$VoiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String provider, String? style, String? language, String? accent, String? gender, String? description, String? bestFor
});




}
/// @nodoc
class __$VoiceCopyWithImpl<$Res>
    implements _$VoiceCopyWith<$Res> {
  __$VoiceCopyWithImpl(this._self, this._then);

  final _Voice _self;
  final $Res Function(_Voice) _then;

/// Create a copy of Voice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? provider = null,Object? style = freezed,Object? language = freezed,Object? accent = freezed,Object? gender = freezed,Object? description = freezed,Object? bestFor = freezed,}) {
  return _then(_Voice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,style: freezed == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,accent: freezed == accent ? _self.accent : accent // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bestFor: freezed == bestFor ? _self.bestFor : bestFor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
