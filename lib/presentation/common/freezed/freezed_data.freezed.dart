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
  String get phone => throw _privateConstructorUsedError;
  int get phoneVerify => throw _privateConstructorUsedError;
  String get pin => throw _privateConstructorUsedError;
  String get tokenSocial => throw _privateConstructorUsedError;
  int get loginBySocial => throw _privateConstructorUsedError;

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
      String phone,
      int phoneVerify,
      String pin,
      String tokenSocial,
      int loginBySocial});
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
    Object? phone = freezed,
    Object? phoneVerify = freezed,
    Object? pin = freezed,
    Object? tokenSocial = freezed,
    Object? loginBySocial = freezed,
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
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      phoneVerify: phoneVerify == freezed
          ? _value.phoneVerify
          : phoneVerify // ignore: cast_nullable_to_non_nullable
              as int,
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSocial: tokenSocial == freezed
          ? _value.tokenSocial
          : tokenSocial // ignore: cast_nullable_to_non_nullable
              as String,
      loginBySocial: loginBySocial == freezed
          ? _value.loginBySocial
          : loginBySocial // ignore: cast_nullable_to_non_nullable
              as int,
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
      String phone,
      int phoneVerify,
      String pin,
      String tokenSocial,
      int loginBySocial});
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
    Object? phone = freezed,
    Object? phoneVerify = freezed,
    Object? pin = freezed,
    Object? tokenSocial = freezed,
    Object? loginBySocial = freezed,
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
      phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      phoneVerify == freezed
          ? _value.phoneVerify
          : phoneVerify // ignore: cast_nullable_to_non_nullable
              as int,
      pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSocial == freezed
          ? _value.tokenSocial
          : tokenSocial // ignore: cast_nullable_to_non_nullable
              as String,
      loginBySocial == freezed
          ? _value.loginBySocial
          : loginBySocial // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_UserDataObject implements _UserDataObject {
  _$_UserDataObject(
      this.email,
      this.password,
      this.passwordAgin,
      this.userName,
      this.phone,
      this.phoneVerify,
      this.pin,
      this.tokenSocial,
      this.loginBySocial);

  @override
  final String email;
  @override
  final String password;
  @override
  final String passwordAgin;
  @override
  final String userName;
  @override
  final String phone;
  @override
  final int phoneVerify;
  @override
  final String pin;
  @override
  final String tokenSocial;
  @override
  final int loginBySocial;

  @override
  String toString() {
    return 'UserDataObject(email: $email, password: $password, passwordAgin: $passwordAgin, userName: $userName, phone: $phone, phoneVerify: $phoneVerify, pin: $pin, tokenSocial: $tokenSocial, loginBySocial: $loginBySocial)';
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
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality()
                .equals(other.phoneVerify, phoneVerify) &&
            const DeepCollectionEquality().equals(other.pin, pin) &&
            const DeepCollectionEquality()
                .equals(other.tokenSocial, tokenSocial) &&
            const DeepCollectionEquality()
                .equals(other.loginBySocial, loginBySocial));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(passwordAgin),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(phoneVerify),
      const DeepCollectionEquality().hash(pin),
      const DeepCollectionEquality().hash(tokenSocial),
      const DeepCollectionEquality().hash(loginBySocial));

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
      final String phone,
      final int phoneVerify,
      final String pin,
      final String tokenSocial,
      final int loginBySocial) = _$_UserDataObject;

  @override
  String get email;
  @override
  String get password;
  @override
  String get passwordAgin;
  @override
  String get userName;
  @override
  String get phone;
  @override
  int get phoneVerify;
  @override
  String get pin;
  @override
  String get tokenSocial;
  @override
  int get loginBySocial;
  @override
  @JsonKey(ignore: true)
  _$$_UserDataObjectCopyWith<_$_UserDataObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReviewObject {
  int get userId => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;
  int get productId => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReviewObjectCopyWith<ReviewObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewObjectCopyWith<$Res> {
  factory $ReviewObjectCopyWith(
          ReviewObject value, $Res Function(ReviewObject) then) =
      _$ReviewObjectCopyWithImpl<$Res>;
  $Res call(
      {int userId, bool status, int productId, double rating, String comment});
}

/// @nodoc
class _$ReviewObjectCopyWithImpl<$Res> implements $ReviewObjectCopyWith<$Res> {
  _$ReviewObjectCopyWithImpl(this._value, this._then);

  final ReviewObject _value;
  // ignore: unused_field
  final $Res Function(ReviewObject) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? status = freezed,
    Object? productId = freezed,
    Object? rating = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ReviewObjectCopyWith<$Res>
    implements $ReviewObjectCopyWith<$Res> {
  factory _$$_ReviewObjectCopyWith(
          _$_ReviewObject value, $Res Function(_$_ReviewObject) then) =
      __$$_ReviewObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {int userId, bool status, int productId, double rating, String comment});
}

/// @nodoc
class __$$_ReviewObjectCopyWithImpl<$Res>
    extends _$ReviewObjectCopyWithImpl<$Res>
    implements _$$_ReviewObjectCopyWith<$Res> {
  __$$_ReviewObjectCopyWithImpl(
      _$_ReviewObject _value, $Res Function(_$_ReviewObject) _then)
      : super(_value, (v) => _then(v as _$_ReviewObject));

  @override
  _$_ReviewObject get _value => super._value as _$_ReviewObject;

  @override
  $Res call({
    Object? userId = freezed,
    Object? status = freezed,
    Object? productId = freezed,
    Object? rating = freezed,
    Object? comment = freezed,
  }) {
    return _then(_$_ReviewObject(
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ReviewObject implements _ReviewObject {
  _$_ReviewObject(
      this.userId, this.status, this.productId, this.rating, this.comment);

  @override
  final int userId;
  @override
  final bool status;
  @override
  final int productId;
  @override
  final double rating;
  @override
  final String comment;

  @override
  String toString() {
    return 'ReviewObject(userId: $userId, status: $status, productId: $productId, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReviewObject &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.productId, productId) &&
            const DeepCollectionEquality().equals(other.rating, rating) &&
            const DeepCollectionEquality().equals(other.comment, comment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(productId),
      const DeepCollectionEquality().hash(rating),
      const DeepCollectionEquality().hash(comment));

  @JsonKey(ignore: true)
  @override
  _$$_ReviewObjectCopyWith<_$_ReviewObject> get copyWith =>
      __$$_ReviewObjectCopyWithImpl<_$_ReviewObject>(this, _$identity);
}

abstract class _ReviewObject implements ReviewObject {
  factory _ReviewObject(
      final int userId,
      final bool status,
      final int productId,
      final double rating,
      final String comment) = _$_ReviewObject;

  @override
  int get userId;
  @override
  bool get status;
  @override
  int get productId;
  @override
  double get rating;
  @override
  String get comment;
  @override
  @JsonKey(ignore: true)
  _$$_ReviewObjectCopyWith<_$_ReviewObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ContactUsObject {
  String get email => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContactUsObjectCopyWith<ContactUsObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactUsObjectCopyWith<$Res> {
  factory $ContactUsObjectCopyWith(
          ContactUsObject value, $Res Function(ContactUsObject) then) =
      _$ContactUsObjectCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String userName,
      String phone,
      String subject,
      String message});
}

/// @nodoc
class _$ContactUsObjectCopyWithImpl<$Res>
    implements $ContactUsObjectCopyWith<$Res> {
  _$ContactUsObjectCopyWithImpl(this._value, this._then);

  final ContactUsObject _value;
  // ignore: unused_field
  final $Res Function(ContactUsObject) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? userName = freezed,
    Object? phone = freezed,
    Object? subject = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ContactUsObjectCopyWith<$Res>
    implements $ContactUsObjectCopyWith<$Res> {
  factory _$$_ContactUsObjectCopyWith(
          _$_ContactUsObject value, $Res Function(_$_ContactUsObject) then) =
      __$$_ContactUsObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String userName,
      String phone,
      String subject,
      String message});
}

/// @nodoc
class __$$_ContactUsObjectCopyWithImpl<$Res>
    extends _$ContactUsObjectCopyWithImpl<$Res>
    implements _$$_ContactUsObjectCopyWith<$Res> {
  __$$_ContactUsObjectCopyWithImpl(
      _$_ContactUsObject _value, $Res Function(_$_ContactUsObject) _then)
      : super(_value, (v) => _then(v as _$_ContactUsObject));

  @override
  _$_ContactUsObject get _value => super._value as _$_ContactUsObject;

  @override
  $Res call({
    Object? email = freezed,
    Object? userName = freezed,
    Object? phone = freezed,
    Object? subject = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_ContactUsObject(
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ContactUsObject implements _ContactUsObject {
  _$_ContactUsObject(
      this.email, this.userName, this.phone, this.subject, this.message);

  @override
  final String email;
  @override
  final String userName;
  @override
  final String phone;
  @override
  final String subject;
  @override
  final String message;

  @override
  String toString() {
    return 'ContactUsObject(email: $email, userName: $userName, phone: $phone, subject: $subject, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContactUsObject &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.subject, subject) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(subject),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_ContactUsObjectCopyWith<_$_ContactUsObject> get copyWith =>
      __$$_ContactUsObjectCopyWithImpl<_$_ContactUsObject>(this, _$identity);
}

abstract class _ContactUsObject implements ContactUsObject {
  factory _ContactUsObject(
      final String email,
      final String userName,
      final String phone,
      final String subject,
      final String message) = _$_ContactUsObject;

  @override
  String get email;
  @override
  String get userName;
  @override
  String get phone;
  @override
  String get subject;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_ContactUsObjectCopyWith<_$_ContactUsObject> get copyWith =>
      throw _privateConstructorUsedError;
}
