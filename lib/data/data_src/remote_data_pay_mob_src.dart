import '../network/app_api.dart';
import '../network/requests/paymob/paymob_create_orders_requests.dart';
import '../responses/paymob/get_first_token_response.dart';
import '../responses/paymob/order_registration_response.dart';

abstract class RemoteDataPayMobSrc {
  Future<GetFirstTokenResponse> getFirstToken(String apiKey);
  Future<OrderRegistrationResponse> getOrderId(
      PayMobCreateOrdersRequests createOrdersRequests);
}

class RemoteDataPayMobSrcImpl extends RemoteDataPayMobSrc {
  final PayMobClient _payMobClient;

  RemoteDataPayMobSrcImpl(this._payMobClient);
  @override
  Future<GetFirstTokenResponse> getFirstToken(String apiKey) async {
    return await _payMobClient.getFirstToken(apiKey: apiKey);
  }

  @override
  Future<OrderRegistrationResponse> getOrderId(
      PayMobCreateOrdersRequests createOrdersRequests) async {
    return await _payMobClient.orderRegistration(
      authToken: createOrdersRequests.authToken,
      deliveryNeeded: createOrdersRequests.deliveryNeeded,
      amountCents: createOrdersRequests.amountCents,
      currency: createOrdersRequests.currency,
      items: createOrdersRequests.items,
    );
  }
}
