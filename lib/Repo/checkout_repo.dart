import 'package:dartz/dartz.dart';

import 'package:shopsmart_users/Models/payment_intent_input_model.dart';
import 'package:shopsmart_users/core/errors/failures.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel inputModel,
  });
}
