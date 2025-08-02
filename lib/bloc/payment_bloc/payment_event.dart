part of 'payment_bloc.dart';

@immutable
sealed class PaymentBlocEvent {}

class PaymentInitiated extends PaymentBlocEvent {
  final double amount;
  final String currency;
  final String receipt;
  PaymentInitiated(this.amount, this.currency, this.receipt);
}

class PaymentOrderCreated extends PaymentBlocEvent {
  final Map<String, dynamic> order;
  PaymentOrderCreated(this.order);     

}

class PaymentSuccessfulEvent extends PaymentBlocEvent {
  final PaymentSuccessResponse response;
  PaymentSuccessfulEvent(this.response);
}

class PaymentErrorEvent extends PaymentBlocEvent {
  final PaymentFailureResponse response;
  PaymentErrorEvent(this.response);
}
