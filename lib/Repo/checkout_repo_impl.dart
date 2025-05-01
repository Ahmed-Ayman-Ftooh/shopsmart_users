import 'package:dartz/dartz.dart';
import 'package:shopsmart_users/Models/payment_intent_input_model.dart';
import 'package:shopsmart_users/Repo/checkout_repo.dart';
import 'package:shopsmart_users/core/errors/failures.dart';
import 'package:shopsmart_users/services/stripe_service.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel inputModel,
  }) async {
    try {
      await stripeService.makePayment(inputModel: inputModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
