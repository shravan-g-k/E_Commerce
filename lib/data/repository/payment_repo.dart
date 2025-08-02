import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PaymentRepository {
  final String _serverApi = dotenv.env['SERVER_API']!;

  Future<Map<String, dynamic>> createOrder(
    double amount,
    String currency,
    String receipt,
  ) async {
    Uri url = Uri.parse('$_serverApi/order');

    http.Response res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'amount': amount,
          'currency': currency,
          'receipt': receipt,
        },
      ),
    );


    Map<String, dynamic> data = jsonDecode(res.body);
    return data;
  }

  Future<bool> verifyPayment(
      String? orderId, String? paymentId, String? signature) async {
    Uri url = Uri.parse('$_serverApi/verify-payment');
    final body = jsonEncode({
      'razorpay_order_id': orderId,
      'razorpay_payment_id': paymentId,
      'razorpay_signature': signature,
    });

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    final data = jsonDecode(res.body);
    return data['success'] == true;
  }
}
