// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_settlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreditSettlement {

 int get creditsCharged; int get creditsRefunded; String get status; String? get message;
/// Create a copy of CreditSettlement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditSettlementCopyWith<CreditSettlement> get copyWith => _$CreditSettlementCopyWithImpl<CreditSettlement>(this as CreditSettlement, _$identity);

  /// Serializes this CreditSettlement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditSettlement&&(identical(other.creditsCharged, creditsCharged) || other.creditsCharged == creditsCharged)&&(identical(other.creditsRefunded, creditsRefunded) || other.creditsRefunded == creditsRefunded)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,creditsCharged,creditsRefunded,status,message);

@override
String toString() {
  return 'CreditSettlement(creditsCharged: $creditsCharged, creditsRefunded: $creditsRefunded, status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class $CreditSettlementCopyWith<$Res>  {
  factory $CreditSettlementCopyWith(CreditSettlement value, $Res Function(CreditSettlement) _then) = _$CreditSettlementCopyWithImpl;
@useResult
$Res call({
 int creditsCharged, int creditsRefunded, String status, String? message
});




}
/// @nodoc
class _$CreditSettlementCopyWithImpl<$Res>
    implements $CreditSettlementCopyWith<$Res> {
  _$CreditSettlementCopyWithImpl(this._self, this._then);

  final CreditSettlement _self;
  final $Res Function(CreditSettlement) _then;

/// Create a copy of CreditSettlement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? creditsCharged = null,Object? creditsRefunded = null,Object? status = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
creditsCharged: null == creditsCharged ? _self.creditsCharged : creditsCharged // ignore: cast_nullable_to_non_nullable
as int,creditsRefunded: null == creditsRefunded ? _self.creditsRefunded : creditsRefunded // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreditSettlement].
extension CreditSettlementPatterns on CreditSettlement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreditSettlement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreditSettlement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreditSettlement value)  $default,){
final _that = this;
switch (_that) {
case _CreditSettlement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreditSettlement value)?  $default,){
final _that = this;
switch (_that) {
case _CreditSettlement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int creditsCharged,  int creditsRefunded,  String status,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreditSettlement() when $default != null:
return $default(_that.creditsCharged,_that.creditsRefunded,_that.status,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int creditsCharged,  int creditsRefunded,  String status,  String? message)  $default,) {final _that = this;
switch (_that) {
case _CreditSettlement():
return $default(_that.creditsCharged,_that.creditsRefunded,_that.status,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int creditsCharged,  int creditsRefunded,  String status,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _CreditSettlement() when $default != null:
return $default(_that.creditsCharged,_that.creditsRefunded,_that.status,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreditSettlement implements CreditSettlement {
  const _CreditSettlement({required this.creditsCharged, required this.creditsRefunded, required this.status, this.message});
  factory _CreditSettlement.fromJson(Map<String, dynamic> json) => _$CreditSettlementFromJson(json);

@override final  int creditsCharged;
@override final  int creditsRefunded;
@override final  String status;
@override final  String? message;

/// Create a copy of CreditSettlement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreditSettlementCopyWith<_CreditSettlement> get copyWith => __$CreditSettlementCopyWithImpl<_CreditSettlement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreditSettlementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreditSettlement&&(identical(other.creditsCharged, creditsCharged) || other.creditsCharged == creditsCharged)&&(identical(other.creditsRefunded, creditsRefunded) || other.creditsRefunded == creditsRefunded)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,creditsCharged,creditsRefunded,status,message);

@override
String toString() {
  return 'CreditSettlement(creditsCharged: $creditsCharged, creditsRefunded: $creditsRefunded, status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class _$CreditSettlementCopyWith<$Res> implements $CreditSettlementCopyWith<$Res> {
  factory _$CreditSettlementCopyWith(_CreditSettlement value, $Res Function(_CreditSettlement) _then) = __$CreditSettlementCopyWithImpl;
@override @useResult
$Res call({
 int creditsCharged, int creditsRefunded, String status, String? message
});




}
/// @nodoc
class __$CreditSettlementCopyWithImpl<$Res>
    implements _$CreditSettlementCopyWith<$Res> {
  __$CreditSettlementCopyWithImpl(this._self, this._then);

  final _CreditSettlement _self;
  final $Res Function(_CreditSettlement) _then;

/// Create a copy of CreditSettlement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? creditsCharged = null,Object? creditsRefunded = null,Object? status = null,Object? message = freezed,}) {
  return _then(_CreditSettlement(
creditsCharged: null == creditsCharged ? _self.creditsCharged : creditsCharged // ignore: cast_nullable_to_non_nullable
as int,creditsRefunded: null == creditsRefunded ? _self.creditsRefunded : creditsRefunded // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
