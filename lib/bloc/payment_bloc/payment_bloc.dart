import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/repository/payment_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentBlocEvent, PaymentBlocState> {
  final _razorpay = Razorpay();
  final PaymentRepository paymentRepository;

  PaymentBloc(this.paymentRepository) : super(PaymentInitial()) {
    on<PaymentInitiated>((event, emit) async {
      emit(PaymentLoading());

      try {
        await paymentRepository
            .createOrder(event.amount, event.currency, event.receipt)
            .then(
          (value) {
            add(PaymentOrderCreated(value));
          },
        );
      } catch (error) {
        emit(PaymentError(error.toString()));
        return;
      }
    });

    on<PaymentOrderCreated>((event, emit) {
      var options = {
        'key': dotenv.env['RAZORPAY_KEY']!,
        'amount': event.order['amount'],
        'currency': event.order['currency'],
        'name': 'E Commerce.',
        'order_id':
            '${event.order['id']}', // Generate order_id using Orders API
        'description': "Payment for order ${event.order['id']}",
        'timeout': 120, // in seconds
        'prefill': {'contact': '+918888888888', 'email': '9M5m5@example.com'}
      };

      _razorpay.open(options);

      void handlePaymentSuccess(PaymentSuccessResponse response) {
        add(PaymentSuccessfulEvent(response));
      }

      void handlePaymentError(PaymentFailureResponse response) {
        add(PaymentErrorEvent(response));
      }

      void handleExternalWallet(ExternalWalletResponse response) {}

      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    });

    on<PaymentSuccessfulEvent>((event, emit) async {
      emit(PaymentLoading());

      // Extract details from the response
      final orderId = event.response.orderId;
      final paymentId = event.response.paymentId;
      final signature = event.response.signature;

      try {
        // Verify payment with backend
        final isVerified = await paymentRepository.verifyPayment(
            orderId, paymentId, signature);

        if (isVerified) {
          emit(PaymentSuccess());
        } else {
          emit(PaymentError("Payment verification failed"));
        }
      } catch (e) {
        emit(PaymentError("Something went wrong"));
        return;
      }
    });

    on<PaymentErrorEvent>((event, emit) {
      emit(PaymentError(event.response.message ?? "Payment failed"));
    });
  }

  @override
  Future<void> close() {
    _razorpay.clear();
    return super.close();
  }
}
