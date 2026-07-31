// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_hub.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GenerateHub {

 Map<String, dynamic> get flowMeta; List<FormatPreset> get formatPresets; List<Map<String, dynamic>> get stylePacks; List<Map<String, dynamic>> get aiVideoProducts; List<String> get cameraMovements; List<String> get aspectRatios; List<Map<String, dynamic>> get userElements; String? get heroBackgroundVideo; int get generationCost;
/// Create a copy of GenerateHub
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerateHubCopyWith<GenerateHub> get copyWith => _$GenerateHubCopyWithImpl<GenerateHub>(this as GenerateHub, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerateHub&&const DeepCollectionEquality().equals(other.flowMeta, flowMeta)&&const DeepCollectionEquality().equals(other.formatPresets, formatPresets)&&const DeepCollectionEquality().equals(other.stylePacks, stylePacks)&&const DeepCollectionEquality().equals(other.aiVideoProducts, aiVideoProducts)&&const DeepCollectionEquality().equals(other.cameraMovements, cameraMovements)&&const DeepCollectionEquality().equals(other.aspectRatios, aspectRatios)&&const DeepCollectionEquality().equals(other.userElements, userElements)&&(identical(other.heroBackgroundVideo, heroBackgroundVideo) || other.heroBackgroundVideo == heroBackgroundVideo)&&(identical(other.generationCost, generationCost) || other.generationCost == generationCost));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(flowMeta),const DeepCollectionEquality().hash(formatPresets),const DeepCollectionEquality().hash(stylePacks),const DeepCollectionEquality().hash(aiVideoProducts),const DeepCollectionEquality().hash(cameraMovements),const DeepCollectionEquality().hash(aspectRatios),const DeepCollectionEquality().hash(userElements),heroBackgroundVideo,generationCost);

@override
String toString() {
  return 'GenerateHub(flowMeta: $flowMeta, formatPresets: $formatPresets, stylePacks: $stylePacks, aiVideoProducts: $aiVideoProducts, cameraMovements: $cameraMovements, aspectRatios: $aspectRatios, userElements: $userElements, heroBackgroundVideo: $heroBackgroundVideo, generationCost: $generationCost)';
}


}

/// @nodoc
abstract mixin class $GenerateHubCopyWith<$Res>  {
  factory $GenerateHubCopyWith(GenerateHub value, $Res Function(GenerateHub) _then) = _$GenerateHubCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> flowMeta, List<FormatPreset> formatPresets, List<Map<String, dynamic>> stylePacks, List<Map<String, dynamic>> aiVideoProducts, List<String> cameraMovements, List<String> aspectRatios, List<Map<String, dynamic>> userElements, String? heroBackgroundVideo, int generationCost
});




}
/// @nodoc
class _$GenerateHubCopyWithImpl<$Res>
    implements $GenerateHubCopyWith<$Res> {
  _$GenerateHubCopyWithImpl(this._self, this._then);

  final GenerateHub _self;
  final $Res Function(GenerateHub) _then;

/// Create a copy of GenerateHub
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flowMeta = null,Object? formatPresets = null,Object? stylePacks = null,Object? aiVideoProducts = null,Object? cameraMovements = null,Object? aspectRatios = null,Object? userElements = null,Object? heroBackgroundVideo = freezed,Object? generationCost = null,}) {
  return _then(_self.copyWith(
flowMeta: null == flowMeta ? _self.flowMeta : flowMeta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,formatPresets: null == formatPresets ? _self.formatPresets : formatPresets // ignore: cast_nullable_to_non_nullable
as List<FormatPreset>,stylePacks: null == stylePacks ? _self.stylePacks : stylePacks // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,aiVideoProducts: null == aiVideoProducts ? _self.aiVideoProducts : aiVideoProducts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,cameraMovements: null == cameraMovements ? _self.cameraMovements : cameraMovements // ignore: cast_nullable_to_non_nullable
as List<String>,aspectRatios: null == aspectRatios ? _self.aspectRatios : aspectRatios // ignore: cast_nullable_to_non_nullable
as List<String>,userElements: null == userElements ? _self.userElements : userElements // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,heroBackgroundVideo: freezed == heroBackgroundVideo ? _self.heroBackgroundVideo : heroBackgroundVideo // ignore: cast_nullable_to_non_nullable
as String?,generationCost: null == generationCost ? _self.generationCost : generationCost // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerateHub].
extension GenerateHubPatterns on GenerateHub {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerateHub value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerateHub() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerateHub value)  $default,){
final _that = this;
switch (_that) {
case _GenerateHub():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerateHub value)?  $default,){
final _that = this;
switch (_that) {
case _GenerateHub() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> flowMeta,  List<FormatPreset> formatPresets,  List<Map<String, dynamic>> stylePacks,  List<Map<String, dynamic>> aiVideoProducts,  List<String> cameraMovements,  List<String> aspectRatios,  List<Map<String, dynamic>> userElements,  String? heroBackgroundVideo,  int generationCost)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerateHub() when $default != null:
return $default(_that.flowMeta,_that.formatPresets,_that.stylePacks,_that.aiVideoProducts,_that.cameraMovements,_that.aspectRatios,_that.userElements,_that.heroBackgroundVideo,_that.generationCost);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> flowMeta,  List<FormatPreset> formatPresets,  List<Map<String, dynamic>> stylePacks,  List<Map<String, dynamic>> aiVideoProducts,  List<String> cameraMovements,  List<String> aspectRatios,  List<Map<String, dynamic>> userElements,  String? heroBackgroundVideo,  int generationCost)  $default,) {final _that = this;
switch (_that) {
case _GenerateHub():
return $default(_that.flowMeta,_that.formatPresets,_that.stylePacks,_that.aiVideoProducts,_that.cameraMovements,_that.aspectRatios,_that.userElements,_that.heroBackgroundVideo,_that.generationCost);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> flowMeta,  List<FormatPreset> formatPresets,  List<Map<String, dynamic>> stylePacks,  List<Map<String, dynamic>> aiVideoProducts,  List<String> cameraMovements,  List<String> aspectRatios,  List<Map<String, dynamic>> userElements,  String? heroBackgroundVideo,  int generationCost)?  $default,) {final _that = this;
switch (_that) {
case _GenerateHub() when $default != null:
return $default(_that.flowMeta,_that.formatPresets,_that.stylePacks,_that.aiVideoProducts,_that.cameraMovements,_that.aspectRatios,_that.userElements,_that.heroBackgroundVideo,_that.generationCost);case _:
  return null;

}
}

}

/// @nodoc


class _GenerateHub implements GenerateHub {
  const _GenerateHub({required final  Map<String, dynamic> flowMeta, required final  List<FormatPreset> formatPresets, required final  List<Map<String, dynamic>> stylePacks, required final  List<Map<String, dynamic>> aiVideoProducts, required final  List<String> cameraMovements, required final  List<String> aspectRatios, required final  List<Map<String, dynamic>> userElements, this.heroBackgroundVideo, required this.generationCost}): _flowMeta = flowMeta,_formatPresets = formatPresets,_stylePacks = stylePacks,_aiVideoProducts = aiVideoProducts,_cameraMovements = cameraMovements,_aspectRatios = aspectRatios,_userElements = userElements;
  

 final  Map<String, dynamic> _flowMeta;
@override Map<String, dynamic> get flowMeta {
  if (_flowMeta is EqualUnmodifiableMapView) return _flowMeta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_flowMeta);
}

 final  List<FormatPreset> _formatPresets;
@override List<FormatPreset> get formatPresets {
  if (_formatPresets is EqualUnmodifiableListView) return _formatPresets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formatPresets);
}

 final  List<Map<String, dynamic>> _stylePacks;
@override List<Map<String, dynamic>> get stylePacks {
  if (_stylePacks is EqualUnmodifiableListView) return _stylePacks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stylePacks);
}

 final  List<Map<String, dynamic>> _aiVideoProducts;
@override List<Map<String, dynamic>> get aiVideoProducts {
  if (_aiVideoProducts is EqualUnmodifiableListView) return _aiVideoProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aiVideoProducts);
}

 final  List<String> _cameraMovements;
@override List<String> get cameraMovements {
  if (_cameraMovements is EqualUnmodifiableListView) return _cameraMovements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cameraMovements);
}

 final  List<String> _aspectRatios;
@override List<String> get aspectRatios {
  if (_aspectRatios is EqualUnmodifiableListView) return _aspectRatios;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aspectRatios);
}

 final  List<Map<String, dynamic>> _userElements;
@override List<Map<String, dynamic>> get userElements {
  if (_userElements is EqualUnmodifiableListView) return _userElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userElements);
}

@override final  String? heroBackgroundVideo;
@override final  int generationCost;

/// Create a copy of GenerateHub
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerateHubCopyWith<_GenerateHub> get copyWith => __$GenerateHubCopyWithImpl<_GenerateHub>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateHub&&const DeepCollectionEquality().equals(other._flowMeta, _flowMeta)&&const DeepCollectionEquality().equals(other._formatPresets, _formatPresets)&&const DeepCollectionEquality().equals(other._stylePacks, _stylePacks)&&const DeepCollectionEquality().equals(other._aiVideoProducts, _aiVideoProducts)&&const DeepCollectionEquality().equals(other._cameraMovements, _cameraMovements)&&const DeepCollectionEquality().equals(other._aspectRatios, _aspectRatios)&&const DeepCollectionEquality().equals(other._userElements, _userElements)&&(identical(other.heroBackgroundVideo, heroBackgroundVideo) || other.heroBackgroundVideo == heroBackgroundVideo)&&(identical(other.generationCost, generationCost) || other.generationCost == generationCost));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_flowMeta),const DeepCollectionEquality().hash(_formatPresets),const DeepCollectionEquality().hash(_stylePacks),const DeepCollectionEquality().hash(_aiVideoProducts),const DeepCollectionEquality().hash(_cameraMovements),const DeepCollectionEquality().hash(_aspectRatios),const DeepCollectionEquality().hash(_userElements),heroBackgroundVideo,generationCost);

@override
String toString() {
  return 'GenerateHub(flowMeta: $flowMeta, formatPresets: $formatPresets, stylePacks: $stylePacks, aiVideoProducts: $aiVideoProducts, cameraMovements: $cameraMovements, aspectRatios: $aspectRatios, userElements: $userElements, heroBackgroundVideo: $heroBackgroundVideo, generationCost: $generationCost)';
}


}

/// @nodoc
abstract mixin class _$GenerateHubCopyWith<$Res> implements $GenerateHubCopyWith<$Res> {
  factory _$GenerateHubCopyWith(_GenerateHub value, $Res Function(_GenerateHub) _then) = __$GenerateHubCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> flowMeta, List<FormatPreset> formatPresets, List<Map<String, dynamic>> stylePacks, List<Map<String, dynamic>> aiVideoProducts, List<String> cameraMovements, List<String> aspectRatios, List<Map<String, dynamic>> userElements, String? heroBackgroundVideo, int generationCost
});




}
/// @nodoc
class __$GenerateHubCopyWithImpl<$Res>
    implements _$GenerateHubCopyWith<$Res> {
  __$GenerateHubCopyWithImpl(this._self, this._then);

  final _GenerateHub _self;
  final $Res Function(_GenerateHub) _then;

/// Create a copy of GenerateHub
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flowMeta = null,Object? formatPresets = null,Object? stylePacks = null,Object? aiVideoProducts = null,Object? cameraMovements = null,Object? aspectRatios = null,Object? userElements = null,Object? heroBackgroundVideo = freezed,Object? generationCost = null,}) {
  return _then(_GenerateHub(
flowMeta: null == flowMeta ? _self._flowMeta : flowMeta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,formatPresets: null == formatPresets ? _self._formatPresets : formatPresets // ignore: cast_nullable_to_non_nullable
as List<FormatPreset>,stylePacks: null == stylePacks ? _self._stylePacks : stylePacks // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,aiVideoProducts: null == aiVideoProducts ? _self._aiVideoProducts : aiVideoProducts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,cameraMovements: null == cameraMovements ? _self._cameraMovements : cameraMovements // ignore: cast_nullable_to_non_nullable
as List<String>,aspectRatios: null == aspectRatios ? _self._aspectRatios : aspectRatios // ignore: cast_nullable_to_non_nullable
as List<String>,userElements: null == userElements ? _self._userElements : userElements // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,heroBackgroundVideo: freezed == heroBackgroundVideo ? _self.heroBackgroundVideo : heroBackgroundVideo // ignore: cast_nullable_to_non_nullable
as String?,generationCost: null == generationCost ? _self.generationCost : generationCost // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
