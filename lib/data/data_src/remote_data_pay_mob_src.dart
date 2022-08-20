import '../network/app_api.dart';
import '../network/requests/paymob/paymob_create_orders_requests.dart';
import '../responses/paymob/buy_response.dart';
import '../responses/paymob/create_order_response.dart';
import '../responses/paymob/get_first_token_response.dart';
import '../responses/paymob/order_registration_response.dart';

abstract class RemoteDataPayMobSrc {
  Future<GetFirstTokenResponse> getFirstToken(String apiKey);
  Future<OrderRegistrationResponse> getOrderId(
      PayMobRequestCreateOrdersRequests createRequestOrdersRequests);
  Future<PayMobRequestCreateOrderResponse> createOrdersRequests(
      PayMobCreateOrdersRequests payMobCreateOrdersRequests);

  Future<BuyResponse> buyRequest(BuyRequest bayRequest);
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
      PayMobRequestCreateOrdersRequests createRequestOrdersRequests) async {
    return await _payMobClient.orderRegistration(
      authToken: createRequestOrdersRequests.authToken,
      deliveryNeeded: createRequestOrdersRequests.deliveryNeeded,
      amountCents: createRequestOrdersRequests.amountCents,
      currency: createRequestOrdersRequests.currency,
      items: createRequestOrdersRequests.items,
    );
  }

  @override
  Future<PayMobRequestCreateOrderResponse> createOrdersRequests(
      PayMobCreateOrdersRequests payMobCreateOrdersRequests) async {
    return await _payMobClient.createOrder(
      authToken: payMobCreateOrdersRequests.authToken,
      amountCents: payMobCreateOrdersRequests.amountCents,
      billingData: payMobCreateOrdersRequests.billingData,
      orderId: payMobCreateOrdersRequests.orderId,
      expiration: payMobCreateOrdersRequests.expiration,
      integrationId: payMobCreateOrdersRequests.integrationId,
    );
  }

  @override
  Future<BuyResponse> buyRequest(BuyRequest bayRequest) {
    return _payMobClient.puyRequest(
      authToken: bayRequest.authToken,
      source: bayRequest.source,
    );
  }
}
