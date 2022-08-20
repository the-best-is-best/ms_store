class PayMobRequestCreateOrdersRequests {
  final String authToken;
  final bool deliveryNeeded;
  final int amountCents;
  final String currency;
  final List<Map<String, dynamic>>? items;

  PayMobRequestCreateOrdersRequests(
      {required this.authToken,
      this.deliveryNeeded = false,
      required this.amountCents,
      this.currency = "EGP",
      this.items = const [{}]});
}

class PayMobCreateOrdersRequests {
  final String authToken;
  final int amountCents;
  final String currency;
  final expiration = 60 * 60 * 24 * 5;
  final int orderId;
  final Map<String, String> billingData;
  final int integrationId;

  PayMobCreateOrdersRequests({
    required this.orderId,
    required this.billingData,
    required this.integrationId,
    required this.authToken,
    required this.amountCents,
    this.currency = "EGP",
  });
}

class BuyRequest {
  final String authToken;
  final Map<String, String> source;

  BuyRequest({
    required this.source,
    required this.authToken,
  });
}
