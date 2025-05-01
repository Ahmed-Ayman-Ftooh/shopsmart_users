import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsmart_users/Models/payment_intent_input_model.dart';
import 'package:shopsmart_users/Repo/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;

  Future makePayment({required PaymentIntentInputModel input}) async {
    emit(PaymentLoading());
    var data = await checkoutRepo.makePayment(inputModel: input);
    data.fold(
      (failure) {
        emit(PaymentFailure(failure.errorMessage));
      },
      (data) {
        emit(PaymentSuccess());
      },
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
