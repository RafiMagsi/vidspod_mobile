// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'format_preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormatPreset {

 String get key; String get publicId; String get label; String get description; String? get imageUrl; String? get previewVideoUrl; String? get styleReferenceImageUrl; String? get templateVideoUrl; String? get aspectRatio; String? get stylePack; int get durationSeconds; int get sceneCount; int get batchSize; List<String> get categories; List<String> get cameraMovements; String get generationMode; String get prompt; String get genre; String get speed; String get shotsMode; String get modelKey; bool get requiresReferenceImage; bool get audioEnabled; Map<String, dynamic>? get workflow;
/// Create a copy of FormatPreset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatPresetCopyWith<FormatPreset> get copyWith => _$FormatPresetCopyWithImpl<FormatPreset>(this as FormatPreset, _$identity);

  /// Serializes this FormatPreset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatPreset&&(identical(other.key, key) || other.key == key)&&(identical(other.publicId, publicId) || other.publicId == publicId)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.previewVideoUrl, previewVideoUrl) || other.previewVideoUrl == previewVideoUrl)&&(identical(other.styleReferenceImageUrl, styleReferenceImageUrl) || other.styleReferenceImageUrl == styleReferenceImageUrl)&&(identical(other.templateVideoUrl, templateVideoUrl) || other.templateVideoUrl == templateVideoUrl)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.stylePack, stylePack) || other.stylePack == stylePack)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.sceneCount, sceneCount) || other.sceneCount == sceneCount)&&(identical(other.batchSize, batchSize) || other.batchSize == batchSize)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.cameraMovements, cameraMovements)&&(identical(other.generationMode, generationMode) || other.generationMode == generationMode)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.shotsMode, shotsMode) || other.shotsMode == shotsMode)&&(identical(other.modelKey, modelKey) || other.modelKey == modelKey)&&(identical(other.requiresReferenceImage, requiresReferenceImage) || other.requiresReferenceImage == requiresReferenceImage)&&(identical(other.audioEnabled, audioEnabled) || other.audioEnabled == audioEnabled)&&const DeepCollectionEquality().equals(other.workflow, workflow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,key,publicId,label,description,imageUrl,previewVideoUrl,styleReferenceImageUrl,templateVideoUrl,aspectRatio,stylePack,durationSeconds,sceneCount,batchSize,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(cameraMovements),generationMode,prompt,genre,speed,shotsMode,modelKey,requiresReferenceImage,audioEnabled,const DeepCollectionEquality().hash(workflow)]);

@override
String toString() {
  return 'FormatPreset(key: $key, publicId: $publicId, label: $label, description: $description, imageUrl: $imageUrl, previewVideoUrl: $previewVideoUrl, styleReferenceImageUrl: $styleReferenceImageUrl, templateVideoUrl: $templateVideoUrl, aspectRatio: $aspectRatio, stylePack: $stylePack, durationSeconds: $durationSeconds, sceneCount: $sceneCount, batchSize: $batchSize, categories: $categories, cameraMovements: $cameraMovements, generationMode: $generationMode, prompt: $prompt, genre: $genre, speed: $speed, shotsMode: $shotsMode, modelKey: $modelKey, requiresReferenceImage: $requiresReferenceImage, audioEnabled: $audioEnabled, workflow: $workflow)';
}


}

/// @nodoc
abstract mixin class $FormatPresetCopyWith<$Res>  {
  factory $FormatPresetCopyWith(FormatPreset value, $Res Function(FormatPreset) _then) = _$FormatPresetCopyWithImpl;
@useResult
$Res call({
 String key, String publicId, String label, String description, String? imageUrl, String? previewVideoUrl, String? styleReferenceImageUrl, String? templateVideoUrl, String? aspectRatio, String? stylePack, int durationSeconds, int sceneCount, int batchSize, List<String> categories, List<String> cameraMovements, String generationMode, String prompt, String genre, String speed, String shotsMode, String modelKey, bool requiresReferenceImage, bool audioEnabled, Map<String, dynamic>? workflow
});




}
/// @nodoc
class _$FormatPresetCopyWithImpl<$Res>
    implements $FormatPresetCopyWith<$Res> {
  _$FormatPresetCopyWithImpl(this._self, this._then);

  final FormatPreset _self;
  final $Res Function(FormatPreset) _then;

/// Create a copy of FormatPreset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? publicId = null,Object? label = null,Object? description = null,Object? imageUrl = freezed,Object? previewVideoUrl = freezed,Object? styleReferenceImageUrl = freezed,Object? templateVideoUrl = freezed,Object? aspectRatio = freezed,Object? stylePack = freezed,Object? durationSeconds = null,Object? sceneCount = null,Object? batchSize = null,Object? categories = null,Object? cameraMovements = null,Object? generationMode = null,Object? prompt = null,Object? genre = null,Object? speed = null,Object? shotsMode = null,Object? modelKey = null,Object? requiresReferenceImage = null,Object? audioEnabled = null,Object? workflow = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,publicId: null == publicId ? _self.publicId : publicId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,previewVideoUrl: freezed == previewVideoUrl ? _self.previewVideoUrl : previewVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,styleReferenceImageUrl: freezed == styleReferenceImageUrl ? _self.styleReferenceImageUrl : styleReferenceImageUrl // ignore: cast_nullable_to_non_nullable
as String?,templateVideoUrl: freezed == templateVideoUrl ? _self.templateVideoUrl : templateVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,aspectRatio: freezed == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as String?,stylePack: freezed == stylePack ? _self.stylePack : stylePack // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,sceneCount: null == sceneCount ? _self.sceneCount : sceneCount // ignore: cast_nullable_to_non_nullable
as int,batchSize: null == batchSize ? _self.batchSize : batchSize // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,cameraMovements: null == cameraMovements ? _self.cameraMovements : cameraMovements // ignore: cast_nullable_to_non_nullable
as List<String>,generationMode: null == generationMode ? _self.generationMode : generationMode // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,genre: null == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as String,shotsMode: null == shotsMode ? _self.shotsMode : shotsMode // ignore: cast_nullable_to_non_nullable
as String,modelKey: null == modelKey ? _self.modelKey : modelKey // ignore: cast_nullable_to_non_nullable
as String,requiresReferenceImage: null == requiresReferenceImage ? _self.requiresReferenceImage : requiresReferenceImage // ignore: cast_nullable_to_non_nullable
as bool,audioEnabled: null == audioEnabled ? _self.audioEnabled : audioEnabled // ignore: cast_nullable_to_non_nullable
as bool,workflow: freezed == workflow ? _self.workflow : workflow // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [FormatPreset].
extension FormatPresetPatterns on FormatPreset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormatPreset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormatPreset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormatPreset value)  $default,){
final _that = this;
switch (_that) {
case _FormatPreset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormatPreset value)?  $default,){
final _that = this;
switch (_that) {
case _FormatPreset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String publicId,  String label,  String description,  String? imageUrl,  String? previewVideoUrl,  String? styleReferenceImageUrl,  String? templateVideoUrl,  String? aspectRatio,  String? stylePack,  int durationSeconds,  int sceneCount,  int batchSize,  List<String> categories,  List<String> cameraMovements,  String generationMode,  String prompt,  String genre,  String speed,  String shotsMode,  String modelKey,  bool requiresReferenceImage,  bool audioEnabled,  Map<String, dynamic>? workflow)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormatPreset() when $default != null:
return $default(_that.key,_that.publicId,_that.label,_that.description,_that.imageUrl,_that.previewVideoUrl,_that.styleReferenceImageUrl,_that.templateVideoUrl,_that.aspectRatio,_that.stylePack,_that.durationSeconds,_that.sceneCount,_that.batchSize,_that.categories,_that.cameraMovements,_that.generationMode,_that.prompt,_that.genre,_that.speed,_that.shotsMode,_that.modelKey,_that.requiresReferenceImage,_that.audioEnabled,_that.workflow);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String publicId,  String label,  String description,  String? imageUrl,  String? previewVideoUrl,  String? styleReferenceImageUrl,  String? templateVideoUrl,  String? aspectRatio,  String? stylePack,  int durationSeconds,  int sceneCount,  int batchSize,  List<String> categories,  List<String> cameraMovements,  String generationMode,  String prompt,  String genre,  String speed,  String shotsMode,  String modelKey,  bool requiresReferenceImage,  bool audioEnabled,  Map<String, dynamic>? workflow)  $default,) {final _that = this;
switch (_that) {
case _FormatPreset():
return $default(_that.key,_that.publicId,_that.label,_that.description,_that.imageUrl,_that.previewVideoUrl,_that.styleReferenceImageUrl,_that.templateVideoUrl,_that.aspectRatio,_that.stylePack,_that.durationSeconds,_that.sceneCount,_that.batchSize,_that.categories,_that.cameraMovements,_that.generationMode,_that.prompt,_that.genre,_that.speed,_that.shotsMode,_that.modelKey,_that.requiresReferenceImage,_that.audioEnabled,_that.workflow);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String publicId,  String label,  String description,  String? imageUrl,  String? previewVideoUrl,  String? styleReferenceImageUrl,  String? templateVideoUrl,  String? aspectRatio,  String? stylePack,  int durationSeconds,  int sceneCount,  int batchSize,  List<String> categories,  List<String> cameraMovements,  String generationMode,  String prompt,  String genre,  String speed,  String shotsMode,  String modelKey,  bool requiresReferenceImage,  bool audioEnabled,  Map<String, dynamic>? workflow)?  $default,) {final _that = this;
switch (_that) {
case _FormatPreset() when $default != null:
return $default(_that.key,_that.publicId,_that.label,_that.description,_that.imageUrl,_that.previewVideoUrl,_that.styleReferenceImageUrl,_that.templateVideoUrl,_that.aspectRatio,_that.stylePack,_that.durationSeconds,_that.sceneCount,_that.batchSize,_that.categories,_that.cameraMovements,_that.generationMode,_that.prompt,_that.genre,_that.speed,_that.shotsMode,_that.modelKey,_that.requiresReferenceImage,_that.audioEnabled,_that.workflow);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormatPreset extends FormatPreset {
  const _FormatPreset({required this.key, required this.publicId, required this.label, required this.description, this.imageUrl, this.previewVideoUrl, this.styleReferenceImageUrl, this.templateVideoUrl, this.aspectRatio, this.stylePack, required this.durationSeconds, required this.sceneCount, required this.batchSize, required final  List<String> categories, required final  List<String> cameraMovements, required this.generationMode, required this.prompt, required this.genre, required this.speed, required this.shotsMode, required this.modelKey, required this.requiresReferenceImage, required this.audioEnabled, final  Map<String, dynamic>? workflow}): _categories = categories,_cameraMovements = cameraMovements,_workflow = workflow,super._();
  factory _FormatPreset.fromJson(Map<String, dynamic> json) => _$FormatPresetFromJson(json);

@override final  String key;
@override final  String publicId;
@override final  String label;
@override final  String description;
@override final  String? imageUrl;
@override final  String? previewVideoUrl;
@override final  String? styleReferenceImageUrl;
@override final  String? templateVideoUrl;
@override final  String? aspectRatio;
@override final  String? stylePack;
@override final  int durationSeconds;
@override final  int sceneCount;
@override final  int batchSize;
 final  List<String> _categories;
@override List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<String> _cameraMovements;
@override List<String> get cameraMovements {
  if (_cameraMovements is EqualUnmodifiableListView) return _cameraMovements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cameraMovements);
}

@override final  String generationMode;
@override final  String prompt;
@override final  String genre;
@override final  String speed;
@override final  String shotsMode;
@override final  String modelKey;
@override final  bool requiresReferenceImage;
@override final  bool audioEnabled;
 final  Map<String, dynamic>? _workflow;
@override Map<String, dynamic>? get workflow {
  final value = _workflow;
  if (value == null) return null;
  if (_workflow is EqualUnmodifiableMapView) return _workflow;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of FormatPreset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormatPresetCopyWith<_FormatPreset> get copyWith => __$FormatPresetCopyWithImpl<_FormatPreset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatPresetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormatPreset&&(identical(other.key, key) || other.key == key)&&(identical(other.publicId, publicId) || other.publicId == publicId)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.previewVideoUrl, previewVideoUrl) || other.previewVideoUrl == previewVideoUrl)&&(identical(other.styleReferenceImageUrl, styleReferenceImageUrl) || other.styleReferenceImageUrl == styleReferenceImageUrl)&&(identical(other.templateVideoUrl, templateVideoUrl) || other.templateVideoUrl == templateVideoUrl)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.stylePack, stylePack) || other.stylePack == stylePack)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.sceneCount, sceneCount) || other.sceneCount == sceneCount)&&(identical(other.batchSize, batchSize) || other.batchSize == batchSize)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._cameraMovements, _cameraMovements)&&(identical(other.generationMode, generationMode) || other.generationMode == generationMode)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.shotsMode, shotsMode) || other.shotsMode == shotsMode)&&(identical(other.modelKey, modelKey) || other.modelKey == modelKey)&&(identical(other.requiresReferenceImage, requiresReferenceImage) || other.requiresReferenceImage == requiresReferenceImage)&&(identical(other.audioEnabled, audioEnabled) || other.audioEnabled == audioEnabled)&&const DeepCollectionEquality().equals(other._workflow, _workflow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,key,publicId,label,description,imageUrl,previewVideoUrl,styleReferenceImageUrl,templateVideoUrl,aspectRatio,stylePack,durationSeconds,sceneCount,batchSize,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_cameraMovements),generationMode,prompt,genre,speed,shotsMode,modelKey,requiresReferenceImage,audioEnabled,const DeepCollectionEquality().hash(_workflow)]);

@override
String toString() {
  return 'FormatPreset(key: $key, publicId: $publicId, label: $label, description: $description, imageUrl: $imageUrl, previewVideoUrl: $previewVideoUrl, styleReferenceImageUrl: $styleReferenceImageUrl, templateVideoUrl: $templateVideoUrl, aspectRatio: $aspectRatio, stylePack: $stylePack, durationSeconds: $durationSeconds, sceneCount: $sceneCount, batchSize: $batchSize, categories: $categories, cameraMovements: $cameraMovements, generationMode: $generationMode, prompt: $prompt, genre: $genre, speed: $speed, shotsMode: $shotsMode, modelKey: $modelKey, requiresReferenceImage: $requiresReferenceImage, audioEnabled: $audioEnabled, workflow: $workflow)';
}


}

/// @nodoc
abstract mixin class _$FormatPresetCopyWith<$Res> implements $FormatPresetCopyWith<$Res> {
  factory _$FormatPresetCopyWith(_FormatPreset value, $Res Function(_FormatPreset) _then) = __$FormatPresetCopyWithImpl;
@override @useResult
$Res call({
 String key, String publicId, String label, String description, String? imageUrl, String? previewVideoUrl, String? styleReferenceImageUrl, String? templateVideoUrl, String? aspectRatio, String? stylePack, int durationSeconds, int sceneCount, int batchSize, List<String> categories, List<String> cameraMovements, String generationMode, String prompt, String genre, String speed, String shotsMode, String modelKey, bool requiresReferenceImage, bool audioEnabled, Map<String, dynamic>? workflow
});




}
/// @nodoc
class __$FormatPresetCopyWithImpl<$Res>
    implements _$FormatPresetCopyWith<$Res> {
  __$FormatPresetCopyWithImpl(this._self, this._then);

  final _FormatPreset _self;
  final $Res Function(_FormatPreset) _then;

/// Create a copy of FormatPreset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? publicId = null,Object? label = null,Object? description = null,Object? imageUrl = freezed,Object? previewVideoUrl = freezed,Object? styleReferenceImageUrl = freezed,Object? templateVideoUrl = freezed,Object? aspectRatio = freezed,Object? stylePack = freezed,Object? durationSeconds = null,Object? sceneCount = null,Object? batchSize = null,Object? categories = null,Object? cameraMovements = null,Object? generationMode = null,Object? prompt = null,Object? genre = null,Object? speed = null,Object? shotsMode = null,Object? modelKey = null,Object? requiresReferenceImage = null,Object? audioEnabled = null,Object? workflow = freezed,}) {
  return _then(_FormatPreset(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,publicId: null == publicId ? _self.publicId : publicId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,previewVideoUrl: freezed == previewVideoUrl ? _self.previewVideoUrl : previewVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,styleReferenceImageUrl: freezed == styleReferenceImageUrl ? _self.styleReferenceImageUrl : styleReferenceImageUrl // ignore: cast_nullable_to_non_nullable
as String?,templateVideoUrl: freezed == templateVideoUrl ? _self.templateVideoUrl : templateVideoUrl // ignore: cast_nullable_to_non_nullable
as String?,aspectRatio: freezed == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as String?,stylePack: freezed == stylePack ? _self.stylePack : stylePack // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,sceneCount: null == sceneCount ? _self.sceneCount : sceneCount // ignore: cast_nullable_to_non_nullable
as int,batchSize: null == batchSize ? _self.batchSize : batchSize // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,cameraMovements: null == cameraMovements ? _self._cameraMovements : cameraMovements // ignore: cast_nullable_to_non_nullable
as List<String>,generationMode: null == generationMode ? _self.generationMode : generationMode // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,genre: null == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as String,shotsMode: null == shotsMode ? _self.shotsMode : shotsMode // ignore: cast_nullable_to_non_nullable
as String,modelKey: null == modelKey ? _self.modelKey : modelKey // ignore: cast_nullable_to_non_nullable
as String,requiresReferenceImage: null == requiresReferenceImage ? _self.requiresReferenceImage : requiresReferenceImage // ignore: cast_nullable_to_non_nullable
as bool,audioEnabled: null == audioEnabled ? _self.audioEnabled : audioEnabled // ignore: cast_nullable_to_non_nullable
as bool,workflow: freezed == workflow ? _self._workflow : workflow // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
