// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_orders.freezed.dart';

@freezed
class OrdersObject with _$OrdersObject {
  factory OrdersObject(
    String email,
    String firstName,
    String lastName,
    String phone,
    String address,
    String city,
    String state,
    String country,
    int paymentMethod,
  ) = _OrdersObject;
}
