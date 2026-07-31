// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'short_run.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShortRun {

 String get id; String get status; String get statusLabel; String get stageKey; String get stageLabel; String get stageMessage; String get presetName; String get presetKey; String get aspectRatio; String? get referenceImageUrl; String? get playbackUrl; bool get playbackReady; bool get canRetry; bool get canCancel; bool get canDeleteMedia; int get outputWidth; int get outputHeight; int get durationSeconds; CreditSettlement get creditSettlement; String get refundStatus; DateTime get createdAt;
/// Create a copy of ShortRun
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShortRunCopyWith<ShortRun> get copyWith => _$ShortRunCopyWithImpl<ShortRun>(this as ShortRun, _$identity);

  /// Serializes this ShortRun to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortRun&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.stageKey, stageKey) || other.stageKey == stageKey)&&(identical(other.stageLabel, stageLabel) || other.stageLabel == stageLabel)&&(identical(other.stageMessage, stageMessage) || other.stageMessage == stageMessage)&&(identical(other.presetName, presetName) || other.presetName == presetName)&&(identical(other.presetKey, presetKey) || other.presetKey == presetKey)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.referenceImageUrl, referenceImageUrl) || other.referenceImageUrl == referenceImageUrl)&&(identical(other.playbackUrl, playbackUrl) || other.playbackUrl == playbackUrl)&&(identical(other.playbackReady, playbackReady) || other.playbackReady == playbackReady)&&(identical(other.canRetry, canRetry) || other.canRetry == canRetry)&&(identical(other.canCancel, canCancel) || other.canCancel == canCancel)&&(identical(other.canDeleteMedia, canDeleteMedia) || other.canDeleteMedia == canDeleteMedia)&&(identical(other.outputWidth, outputWidth) || other.outputWidth == outputWidth)&&(identical(other.outputHeight, outputHeight) || other.outputHeight == outputHeight)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.creditSettlement, creditSettlement) || other.creditSettlement == creditSettlement)&&(identical(other.refundStatus, refundStatus) || other.refundStatus == refundStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,status,statusLabel,stageKey,stageLabel,stageMessage,presetName,presetKey,aspectRatio,referenceImageUrl,playbackUrl,playbackReady,canRetry,canCancel,canDeleteMedia,outputWidth,outputHeight,durationSeconds,creditSettlement,refundStatus,createdAt]);

@override
String toString() {
  return 'ShortRun(id: $id, status: $status, statusLabel: $statusLabel, stageKey: $stageKey, stageLabel: $stageLabel, stageMessage: $stageMessage, presetName: $presetName, presetKey: $presetKey, aspectRatio: $aspectRatio, referenceImageUrl: $referenceImageUrl, playbackUrl: $playbackUrl, playbackReady: $playbackReady, canRetry: $canRetry, canCancel: $canCancel, canDeleteMedia: $canDeleteMedia, outputWidth: $outputWidth, outputHeight: $outputHeight, durationSeconds: $durationSeconds, creditSettlement: $creditSettlement, refundStatus: $refundStatus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ShortRunCopyWith<$Res>  {
  factory $ShortRunCopyWith(ShortRun value, $Res Function(ShortRun) _then) = _$ShortRunCopyWithImpl;
@useResult
$Res call({
 String id, String status, String statusLabel, String stageKey, String stageLabel, String stageMessage, String presetName, String presetKey, String aspectRatio, String? referenceImageUrl, String? playbackUrl, bool playbackReady, bool canRetry, bool canCancel, bool canDeleteMedia, int outputWidth, int outputHeight, int durationSeconds, CreditSettlement creditSettlement, String refundStatus, DateTime createdAt
});


$CreditSettlementCopyWith<$Res> get creditSettlement;

}
/// @nodoc
class _$ShortRunCopyWithImpl<$Res>
    implements $ShortRunCopyWith<$Res> {
  _$ShortRunCopyWithImpl(this._self, this._then);

  final ShortRun _self;
  final $Res Function(ShortRun) _then;

/// Create a copy of ShortRun
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? statusLabel = null,Object? stageKey = null,Object? stageLabel = null,Object? stageMessage = null,Object? presetName = null,Object? presetKey = null,Object? aspectRatio = null,Object? referenceImageUrl = freezed,Object? playbackUrl = freezed,Object? playbackReady = null,Object? canRetry = null,Object? canCancel = null,Object? canDeleteMedia = null,Object? outputWidth = null,Object? outputHeight = null,Object? durationSeconds = null,Object? creditSettlement = null,Object? refundStatus = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,stageKey: null == stageKey ? _self.stageKey : stageKey // ignore: cast_nullable_to_non_nullable
as String,stageLabel: null == stageLabel ? _self.stageLabel : stageLabel // ignore: cast_nullable_to_non_nullable
as String,stageMessage: null == stageMessage ? _self.stageMessage : stageMessage // ignore: cast_nullable_to_non_nullable
as String,presetName: null == presetName ? _self.presetName : presetName // ignore: cast_nullable_to_non_nullable
as String,presetKey: null == presetKey ? _self.presetKey : presetKey // ignore: cast_nullable_to_non_nullable
as String,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as String,referenceImageUrl: freezed == referenceImageUrl ? _self.referenceImageUrl : referenceImageUrl // ignore: cast_nullable_to_non_nullable
as String?,playbackUrl: freezed == playbackUrl ? _self.playbackUrl : playbackUrl // ignore: cast_nullable_to_non_nullable
as String?,playbackReady: null == playbackReady ? _self.playbackReady : playbackReady // ignore: cast_nullable_to_non_nullable
as bool,canRetry: null == canRetry ? _self.canRetry : canRetry // ignore: cast_nullable_to_non_nullable
as bool,canCancel: null == canCancel ? _self.canCancel : canCancel // ignore: cast_nullable_to_non_nullable
as bool,canDeleteMedia: null == canDeleteMedia ? _self.canDeleteMedia : canDeleteMedia // ignore: cast_nullable_to_non_nullable
as bool,outputWidth: null == outputWidth ? _self.outputWidth : outputWidth // ignore: cast_nullable_to_non_nullable
as int,outputHeight: null == outputHeight ? _self.outputHeight : outputHeight // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,creditSettlement: null == creditSettlement ? _self.creditSettlement : creditSettlement // ignore: cast_nullable_to_non_nullable
as CreditSettlement,refundStatus: null == refundStatus ? _self.refundStatus : refundStatus // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ShortRun
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditSettlementCopyWith<$Res> get creditSettlement {
  
  return $CreditSettlementCopyWith<$Res>(_self.creditSettlement, (value) {
    return _then(_self.copyWith(creditSettlement: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShortRun].
extension ShortRunPatterns on ShortRun {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShortRun value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShortRun() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShortRun value)  $default,){
final _that = this;
switch (_that) {
case _ShortRun():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShortRun value)?  $default,){
final _that = this;
switch (_that) {
case _ShortRun() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  String statusLabel,  String stageKey,  String stageLabel,  String stageMessage,  String presetName,  String presetKey,  String aspectRatio,  String? referenceImageUrl,  String? playbackUrl,  bool playbackReady,  bool canRetry,  bool canCancel,  bool canDeleteMedia,  int outputWidth,  int outputHeight,  int durationSeconds,  CreditSettlement creditSettlement,  String refundStatus,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShortRun() when $default != null:
return $default(_that.id,_that.status,_that.statusLabel,_that.stageKey,_that.stageLabel,_that.stageMessage,_that.presetName,_that.presetKey,_that.aspectRatio,_that.referenceImageUrl,_that.playbackUrl,_that.playbackReady,_that.canRetry,_that.canCancel,_that.canDeleteMedia,_that.outputWidth,_that.outputHeight,_that.durationSeconds,_that.creditSettlement,_that.refundStatus,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  String statusLabel,  String stageKey,  String stageLabel,  String stageMessage,  String presetName,  String presetKey,  String aspectRatio,  String? referenceImageUrl,  String? playbackUrl,  bool playbackReady,  bool canRetry,  bool canCancel,  bool canDeleteMedia,  int outputWidth,  int outputHeight,  int durationSeconds,  CreditSettlement creditSettlement,  String refundStatus,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ShortRun():
return $default(_that.id,_that.status,_that.statusLabel,_that.stageKey,_that.stageLabel,_that.stageMessage,_that.presetName,_that.presetKey,_that.aspectRatio,_that.referenceImageUrl,_that.playbackUrl,_that.playbackReady,_that.canRetry,_that.canCancel,_that.canDeleteMedia,_that.outputWidth,_that.outputHeight,_that.durationSeconds,_that.creditSettlement,_that.refundStatus,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  String statusLabel,  String stageKey,  String stageLabel,  String stageMessage,  String presetName,  String presetKey,  String aspectRatio,  String? referenceImageUrl,  String? playbackUrl,  bool playbackReady,  bool canRetry,  bool canCancel,  bool canDeleteMedia,  int outputWidth,  int outputHeight,  int durationSeconds,  CreditSettlement creditSettlement,  String refundStatus,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ShortRun() when $default != null:
return $default(_that.id,_that.status,_that.statusLabel,_that.stageKey,_that.stageLabel,_that.stageMessage,_that.presetName,_that.presetKey,_that.aspectRatio,_that.referenceImageUrl,_that.playbackUrl,_that.playbackReady,_that.canRetry,_that.canCancel,_that.canDeleteMedia,_that.outputWidth,_that.outputHeight,_that.durationSeconds,_that.creditSettlement,_that.refundStatus,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShortRun implements ShortRun {
  const _ShortRun({required this.id, required this.status, required this.statusLabel, required this.stageKey, required this.stageLabel, required this.stageMessage, required this.presetName, required this.presetKey, required this.aspectRatio, this.referenceImageUrl, this.playbackUrl, required this.playbackReady, required this.canRetry, required this.canCancel, required this.canDeleteMedia, required this.outputWidth, required this.outputHeight, required this.durationSeconds, required this.creditSettlement, required this.refundStatus, required this.createdAt});
  factory _ShortRun.fromJson(Map<String, dynamic> json) => _$ShortRunFromJson(json);

@override final  String id;
@override final  String status;
@override final  String statusLabel;
@override final  String stageKey;
@override final  String stageLabel;
@override final  String stageMessage;
@override final  String presetName;
@override final  String presetKey;
@override final  String aspectRatio;
@override final  String? referenceImageUrl;
@override final  String? playbackUrl;
@override final  bool playbackReady;
@override final  bool canRetry;
@override final  bool canCancel;
@override final  bool canDeleteMedia;
@override final  int outputWidth;
@override final  int outputHeight;
@override final  int durationSeconds;
@override final  CreditSettlement creditSettlement;
@override final  String refundStatus;
@override final  DateTime createdAt;

/// Create a copy of ShortRun
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShortRunCopyWith<_ShortRun> get copyWith => __$ShortRunCopyWithImpl<_ShortRun>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShortRunToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShortRun&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.stageKey, stageKey) || other.stageKey == stageKey)&&(identical(other.stageLabel, stageLabel) || other.stageLabel == stageLabel)&&(identical(other.stageMessage, stageMessage) || other.stageMessage == stageMessage)&&(identical(other.presetName, presetName) || other.presetName == presetName)&&(identical(other.presetKey, presetKey) || other.presetKey == presetKey)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.referenceImageUrl, referenceImageUrl) || other.referenceImageUrl == referenceImageUrl)&&(identical(other.playbackUrl, playbackUrl) || other.playbackUrl == playbackUrl)&&(identical(other.playbackReady, playbackReady) || other.playbackReady == playbackReady)&&(identical(other.canRetry, canRetry) || other.canRetry == canRetry)&&(identical(other.canCancel, canCancel) || other.canCancel == canCancel)&&(identical(other.canDeleteMedia, canDeleteMedia) || other.canDeleteMedia == canDeleteMedia)&&(identical(other.outputWidth, outputWidth) || other.outputWidth == outputWidth)&&(identical(other.outputHeight, outputHeight) || other.outputHeight == outputHeight)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.creditSettlement, creditSettlement) || other.creditSettlement == creditSettlement)&&(identical(other.refundStatus, refundStatus) || other.refundStatus == refundStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,status,statusLabel,stageKey,stageLabel,stageMessage,presetName,presetKey,aspectRatio,referenceImageUrl,playbackUrl,playbackReady,canRetry,canCancel,canDeleteMedia,outputWidth,outputHeight,durationSeconds,creditSettlement,refundStatus,createdAt]);

@override
String toString() {
  return 'ShortRun(id: $id, status: $status, statusLabel: $statusLabel, stageKey: $stageKey, stageLabel: $stageLabel, stageMessage: $stageMessage, presetName: $presetName, presetKey: $presetKey, aspectRatio: $aspectRatio, referenceImageUrl: $referenceImageUrl, playbackUrl: $playbackUrl, playbackReady: $playbackReady, canRetry: $canRetry, canCancel: $canCancel, canDeleteMedia: $canDeleteMedia, outputWidth: $outputWidth, outputHeight: $outputHeight, durationSeconds: $durationSeconds, creditSettlement: $creditSettlement, refundStatus: $refundStatus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ShortRunCopyWith<$Res> implements $ShortRunCopyWith<$Res> {
  factory _$ShortRunCopyWith(_ShortRun value, $Res Function(_ShortRun) _then) = __$ShortRunCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, String statusLabel, String stageKey, String stageLabel, String stageMessage, String presetName, String presetKey, String aspectRatio, String? referenceImageUrl, String? playbackUrl, bool playbackReady, bool canRetry, bool canCancel, bool canDeleteMedia, int outputWidth, int outputHeight, int durationSeconds, CreditSettlement creditSettlement, String refundStatus, DateTime createdAt
});


@override $CreditSettlementCopyWith<$Res> get creditSettlement;

}
/// @nodoc
class __$ShortRunCopyWithImpl<$Res>
    implements _$ShortRunCopyWith<$Res> {
  __$ShortRunCopyWithImpl(this._self, this._then);

  final _ShortRun _self;
  final $Res Function(_ShortRun) _then;

/// Create a copy of ShortRun
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? statusLabel = null,Object? stageKey = null,Object? stageLabel = null,Object? stageMessage = null,Object? presetName = null,Object? presetKey = null,Object? aspectRatio = null,Object? referenceImageUrl = freezed,Object? playbackUrl = freezed,Object? playbackReady = null,Object? canRetry = null,Object? canCancel = null,Object? canDeleteMedia = null,Object? outputWidth = null,Object? outputHeight = null,Object? durationSeconds = null,Object? creditSettlement = null,Object? refundStatus = null,Object? createdAt = null,}) {
  return _then(_ShortRun(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,stageKey: null == stageKey ? _self.stageKey : stageKey // ignore: cast_nullable_to_non_nullable
as String,stageLabel: null == stageLabel ? _self.stageLabel : stageLabel // ignore: cast_nullable_to_non_nullable
as String,stageMessage: null == stageMessage ? _self.stageMessage : stageMessage // ignore: cast_nullable_to_non_nullable
as String,presetName: null == presetName ? _self.presetName : presetName // ignore: cast_nullable_to_non_nullable
as String,presetKey: null == presetKey ? _self.presetKey : presetKey // ignore: cast_nullable_to_non_nullable
as String,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as String,referenceImageUrl: freezed == referenceImageUrl ? _self.referenceImageUrl : referenceImageUrl // ignore: cast_nullable_to_non_nullable
as String?,playbackUrl: freezed == playbackUrl ? _self.playbackUrl : playbackUrl // ignore: cast_nullable_to_non_nullable
as String?,playbackReady: null == playbackReady ? _self.playbackReady : playbackReady // ignore: cast_nullable_to_non_nullable
as bool,canRetry: null == canRetry ? _self.canRetry : canRetry // ignore: cast_nullable_to_non_nullable
as bool,canCancel: null == canCancel ? _self.canCancel : canCancel // ignore: cast_nullable_to_non_nullable
as bool,canDeleteMedia: null == canDeleteMedia ? _self.canDeleteMedia : canDeleteMedia // ignore: cast_nullable_to_non_nullable
as bool,outputWidth: null == outputWidth ? _self.outputWidth : outputWidth // ignore: cast_nullable_to_non_nullable
as int,outputHeight: null == outputHeight ? _self.outputHeight : outputHeight // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,creditSettlement: null == creditSettlement ? _self.creditSettlement : creditSettlement // ignore: cast_nullable_to_non_nullable
as CreditSettlement,refundStatus: null == refundStatus ? _self.refundStatus : refundStatus // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ShortRun
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreditSettlementCopyWith<$Res> get creditSettlement {
  
  return $CreditSettlementCopyWith<$Res>(_self.creditSettlement, (value) {
    return _then(_self.copyWith(creditSettlement: value));
  });
}
}

// dart format on
