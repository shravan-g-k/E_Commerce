part of 'payment_bloc.dart';

@immutable
sealed class PaymentBlocState {}

final class PaymentInitial extends PaymentBlocState {}

final class PaymentLoading extends PaymentBlocState {}

final class PaymentSuccess extends PaymentBlocState {}

final class PaymentError extends PaymentBlocState {
  final String message;
  PaymentError(this.message);
}