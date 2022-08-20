class PayMobCreateOrdersRequests {
  final String authToken;
  final bool deliveryNeeded;
  final int amountCents;
  final String currency;
  final List<Map<String, dynamic>>? items;

  PayMobCreateOrdersRequests(
      {required this.authToken,
      this.deliveryNeeded = false,
      required this.amountCents,
      this.currency = "EGP",
      this.items = const [{}]});
}
