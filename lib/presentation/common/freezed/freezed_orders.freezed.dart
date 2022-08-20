// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'freezed_orders.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrdersObject {
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  int get paymentMethod => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrdersObjectCopyWith<OrdersObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersObjectCopyWith<$Res> {
  factory $OrdersObjectCopyWith(
          OrdersObject value, $Res Function(OrdersObject) then) =
      _$OrdersObjectCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String phone,
      String address,
      String city,
      String state,
      String country,
      int paymentMethod});
}

/// @nodoc
class _$OrdersObjectCopyWithImpl<$Res> implements $OrdersObjectCopyWith<$Res> {
  _$OrdersObjectCopyWithImpl(this._value, this._then);

  final OrdersObject _value;
  // ignore: unused_field
  final $Res Function(OrdersObject) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? paymentMethod = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_OrdersObjectCopyWith<$Res>
    implements $OrdersObjectCopyWith<$Res> {
  factory _$$_OrdersObjectCopyWith(
          _$_OrdersObject value, $Res Function(_$_OrdersObject) then) =
      __$$_OrdersObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String phone,
      String address,
      String city,
      String state,
      String country,
      int paymentMethod});
}

/// @nodoc
class __$$_OrdersObjectCopyWithImpl<$Res>
    extends _$OrdersObjectCopyWithImpl<$Res>
    implements _$$_OrdersObjectCopyWith<$Res> {
  __$$_OrdersObjectCopyWithImpl(
      _$_OrdersObject _value, $Res Function(_$_OrdersObject) _then)
      : super(_value, (v) => _then(v as _$_OrdersObject));

  @override
  _$_OrdersObject get _value => super._value as _$_OrdersObject;

  @override
  $Res call({
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? paymentMethod = freezed,
  }) {
    return _then(_$_OrdersObject(
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_OrdersObject implements _OrdersObject {
  _$_OrdersObject(this.email, this.firstName, this.lastName, this.phone,
      this.address, this.city, this.state, this.country, this.paymentMethod);

  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String phone;
  @override
  final String address;
  @override
  final String city;
  @override
  final String state;
  @override
  final String country;
  @override
  final int paymentMethod;

  @override
  String toString() {
    return 'OrdersObject(email: $email, firstName: $firstName, lastName: $lastName, phone: $phone, address: $address, city: $city, state: $state, country: $country, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrdersObject &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other.state, state) &&
            const DeepCollectionEquality().equals(other.country, country) &&
            const DeepCollectionEquality()
                .equals(other.paymentMethod, paymentMethod));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(city),
      const DeepCollectionEquality().hash(state),
      const DeepCollectionEquality().hash(country),
      const DeepCollectionEquality().hash(paymentMethod));

  @JsonKey(ignore: true)
  @override
  _$$_OrdersObjectCopyWith<_$_OrdersObject> get copyWith =>
      __$$_OrdersObjectCopyWithImpl<_$_OrdersObject>(this, _$identity);
}

abstract class _OrdersObject implements OrdersObject {
  factory _OrdersObject(
      final String email,
      final String firstName,
      final String lastName,
      final String phone,
      final String address,
      final String city,
      final String state,
      final String country,
      final int paymentMethod) = _$_OrdersObject;

  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get phone;
  @override
  String get address;
  @override
  String get city;
  @override
  String get state;
  @override
  String get country;
  @override
  int get paymentMethod;
  @override
  @JsonKey(ignore: true)
  _$$_OrdersObjectCopyWith<_$_OrdersObject> get copyWith =>
      throw _privateConstructorUsedError;
}
