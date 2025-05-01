import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shopsmart_users/Models/ephmeral_key/ephmeral_key.dart';
import 'package:shopsmart_users/Models/init_payment_sheet_input_model.dart';
import 'package:shopsmart_users/Models/payment_intent_input_model.dart';
import 'package:shopsmart_users/Models/payment_intent_model/payment_intent_model.dart';
import 'package:shopsmart_users/consts/app_api_keys.dart';
import 'package:shopsmart_users/services/api_service.dart';

class StripeService {
  final ApiService apiService = ApiService();
  String urlpayment = "https://api.stripe.com/v1/payment_intents";
  String urlcustomer = "https://api.stripe.com/v1/customers";
  String urlephmeral = "https://api.stripe.com/v1/ephemeral_keys";
  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel inputModel,
  ) async {
    var response = await apiService.post(
      contentType: Headers.formUrlEncodedContentType,
      url: urlpayment,
      body: inputModel.toJson(),
      token: ApiKeys.seacretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet({
    required InitPaymentSheetInputModel inputmodel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: inputmodel.clientSecret,
        merchantDisplayName: 'Ahmed Ftooh',
        customerEphemeralKeySecret: inputmodel.ephemeralKeySecret,
        customerId: inputmodel.customerId,
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({required PaymentIntentInputModel inputModel}) async {
    // Create a payment intent
    var paymentIntent = await createPaymentIntent(inputModel);
    var ephmeralkey = await createEphmralKey(customerId: inputModel.customerId);
    var initPaymentSheetInputModel = InitPaymentSheetInputModel(
      clientSecret: paymentIntent.clientSecret!,
      customerId: inputModel.customerId,
      ephemeralKeySecret: ephmeralkey.secret!,
    );
    // Initialize the payment sheet with the client secret
    await initPaymentSheet(inputmodel: initPaymentSheetInputModel);
    // Display the payment sheet to the user
    await displayPaymentSheet();
  }

  Future<PaymentIntentModel> createCustomer(
    PaymentIntentInputModel inputModel,
  ) async {
    var response = await apiService.post(
      contentType: Headers.formUrlEncodedContentType,
      url: urlcustomer,
      body: inputModel.toJson(),
      token: ApiKeys.seacretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future<EphmeralKey> createEphmralKey({required String customerId}) async {
    var response = await apiService.post(
      contentType: Headers.formUrlEncodedContentType,
      url: urlephmeral,
      body: {'customer': customerId},
      token: ApiKeys.seacretKey,
      headers: {
        "Authorization": "Bearer ${ApiKeys.seacretKey}",
        "Stripe-Version": "2025-03-31.basil",
      },
    );
    var ephmeralKeyModel = EphmeralKey.fromJson(response.data);
    return ephmeralKeyModel;
  }
}
