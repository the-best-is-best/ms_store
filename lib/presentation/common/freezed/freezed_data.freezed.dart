// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'freezed_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserDataObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get passwordAgin => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get pin => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserDataObjectCopyWith<UserDataObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataObjectCopyWith<$Res> {
  factory $UserDataObjectCopyWith(
          UserDataObject value, $Res Function(UserDataObject) then) =
      _$UserDataObjectCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String password,
      String passwordAgin,
      String userName,
      String pin});
}

/// @nodoc
class _$UserDataObjectCopyWithImpl<$Res>
    implements $UserDataObjectCopyWith<$Res> {
  _$UserDataObjectCopyWithImpl(this._value, this._then);

  final UserDataObject _value;
  // ignore: unused_field
  final $Res Function(UserDataObject) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? passwordAgin = freezed,
    Object? userName = freezed,
    Object? pin = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordAgin: passwordAgin == freezed
          ? _value.passwordAgin
          : passwordAgin // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserDataObjectCopyWith<$Res>
    implements $UserDataObjectCopyWith<$Res> {
  factory _$$_UserDataObjectCopyWith(
          _$_UserDataObject value, $Res Function(_$_UserDataObject) then) =
      __$$_UserDataObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String password,
      String passwordAgin,
      String userName,
      String pin});
}

/// @nodoc
class __$$_UserDataObjectCopyWithImpl<$Res>
    extends _$UserDataObjectCopyWithImpl<$Res>
    implements _$$_UserDataObjectCopyWith<$Res> {
  __$$_UserDataObjectCopyWithImpl(
      _$_UserDataObject _value, $Res Function(_$_UserDataObject) _then)
      : super(_value, (v) => _then(v as _$_UserDataObject));

  @override
  _$_UserDataObject get _value => super._value as _$_UserDataObject;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? passwordAgin = freezed,
    Object? userName = freezed,
    Object? pin = freezed,
  }) {
    return _then(_$_UserDataObject(
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordAgin == freezed
          ? _value.passwordAgin
          : passwordAgin // ignore: cast_nullable_to_non_nullable
              as String,
      userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserDataObject implements _UserDataObject {
  _$_UserDataObject(
      this.email, this.password, this.passwordAgin, this.userName, this.pin);

  @override
  final String email;
  @override
  final String password;
  @override
  final String passwordAgin;
  @override
  final String userName;
  @override
  final String pin;

  @override
  String toString() {
    return 'UserDataObject(email: $email, password: $password, passwordAgin: $passwordAgin, userName: $userName, pin: $pin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserDataObject &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality()
                .equals(other.passwordAgin, passwordAgin) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.pin, pin));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(passwordAgin),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(pin));

  @JsonKey(ignore: true)
  @override
  _$$_UserDataObjectCopyWith<_$_UserDataObject> get copyWith =>
      __$$_UserDataObjectCopyWithImpl<_$_UserDataObject>(this, _$identity);
}

abstract class _UserDataObject implements UserDataObject {
  factory _UserDataObject(
      final String email,
      final String password,
      final String passwordAgin,
      final String userName,
      final String pin) = _$_UserDataObject;

  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  String get passwordAgin => throw _privateConstructorUsedError;
  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  String get pin => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserDataObjectCopyWith<_$_UserDataObject> get copyWith =>
      throw _privateConstructorUsedError;
}
