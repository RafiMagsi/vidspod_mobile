// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_credits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountCredits {

 int get balance; String get plan; DateTime? get renewsAt; Map<String, int>? get costs;
/// Create a copy of AccountCredits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountCreditsCopyWith<AccountCredits> get copyWith => _$AccountCreditsCopyWithImpl<AccountCredits>(this as AccountCredits, _$identity);

  /// Serializes this AccountCredits to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountCredits&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.renewsAt, renewsAt) || other.renewsAt == renewsAt)&&const DeepCollectionEquality().equals(other.costs, costs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,plan,renewsAt,const DeepCollectionEquality().hash(costs));

@override
String toString() {
  return 'AccountCredits(balance: $balance, plan: $plan, renewsAt: $renewsAt, costs: $costs)';
}


}

/// @nodoc
abstract mixin class $AccountCreditsCopyWith<$Res>  {
  factory $AccountCreditsCopyWith(AccountCredits value, $Res Function(AccountCredits) _then) = _$AccountCreditsCopyWithImpl;
@useResult
$Res call({
 int balance, String plan, DateTime? renewsAt, Map<String, int>? costs
});




}
/// @nodoc
class _$AccountCreditsCopyWithImpl<$Res>
    implements $AccountCreditsCopyWith<$Res> {
  _$AccountCreditsCopyWithImpl(this._self, this._then);

  final AccountCredits _self;
  final $Res Function(AccountCredits) _then;

/// Create a copy of AccountCredits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? plan = null,Object? renewsAt = freezed,Object? costs = freezed,}) {
  return _then(_self.copyWith(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,renewsAt: freezed == renewsAt ? _self.renewsAt : renewsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,costs: freezed == costs ? _self.costs : costs // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountCredits].
extension AccountCreditsPatterns on AccountCredits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountCredits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountCredits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountCredits value)  $default,){
final _that = this;
switch (_that) {
case _AccountCredits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountCredits value)?  $default,){
final _that = this;
switch (_that) {
case _AccountCredits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int balance,  String plan,  DateTime? renewsAt,  Map<String, int>? costs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountCredits() when $default != null:
return $default(_that.balance,_that.plan,_that.renewsAt,_that.costs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int balance,  String plan,  DateTime? renewsAt,  Map<String, int>? costs)  $default,) {final _that = this;
switch (_that) {
case _AccountCredits():
return $default(_that.balance,_that.plan,_that.renewsAt,_that.costs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int balance,  String plan,  DateTime? renewsAt,  Map<String, int>? costs)?  $default,) {final _that = this;
switch (_that) {
case _AccountCredits() when $default != null:
return $default(_that.balance,_that.plan,_that.renewsAt,_that.costs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountCredits implements AccountCredits {
  const _AccountCredits({required this.balance, required this.plan, this.renewsAt, final  Map<String, int>? costs}): _costs = costs;
  factory _AccountCredits.fromJson(Map<String, dynamic> json) => _$AccountCreditsFromJson(json);

@override final  int balance;
@override final  String plan;
@override final  DateTime? renewsAt;
 final  Map<String, int>? _costs;
@override Map<String, int>? get costs {
  final value = _costs;
  if (value == null) return null;
  if (_costs is EqualUnmodifiableMapView) return _costs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AccountCredits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountCreditsCopyWith<_AccountCredits> get copyWith => __$AccountCreditsCopyWithImpl<_AccountCredits>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountCreditsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountCredits&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.renewsAt, renewsAt) || other.renewsAt == renewsAt)&&const DeepCollectionEquality().equals(other._costs, _costs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,plan,renewsAt,const DeepCollectionEquality().hash(_costs));

@override
String toString() {
  return 'AccountCredits(balance: $balance, plan: $plan, renewsAt: $renewsAt, costs: $costs)';
}


}

/// @nodoc
abstract mixin class _$AccountCreditsCopyWith<$Res> implements $AccountCreditsCopyWith<$Res> {
  factory _$AccountCreditsCopyWith(_AccountCredits value, $Res Function(_AccountCredits) _then) = __$AccountCreditsCopyWithImpl;
@override @useResult
$Res call({
 int balance, String plan, DateTime? renewsAt, Map<String, int>? costs
});




}
/// @nodoc
class __$AccountCreditsCopyWithImpl<$Res>
    implements _$AccountCreditsCopyWith<$Res> {
  __$AccountCreditsCopyWithImpl(this._self, this._then);

  final _AccountCredits _self;
  final $Res Function(_AccountCredits) _then;

/// Create a copy of AccountCredits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? plan = null,Object? renewsAt = freezed,Object? costs = freezed,}) {
  return _then(_AccountCredits(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,renewsAt: freezed == renewsAt ? _self.renewsAt : renewsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,costs: freezed == costs ? _self._costs : costs // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,
  ));
}


}

// dart format on
