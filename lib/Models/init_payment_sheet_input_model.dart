class InitPaymentSheetInputModel {
  final String clientSecret;
  final String ephemeralKeySecret;
  final String customerId;

  InitPaymentSheetInputModel({
    required this.clientSecret,
    required this.ephemeralKeySecret,
    required this.customerId,
  });
}
