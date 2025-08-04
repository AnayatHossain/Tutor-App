import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../consts.dart';
import '../core/const/app_colors.dart';
import '../core/network_caller/endpoints.dart';


class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  // Create Payment Method using Setup Intent and Payment Sheet, then authorize payment
  Future<void> createAndAuthorizePayment(String offerId, int amount) async {
    try {
      if (offerId.isEmpty) {
        throw Exception('Offer ID is empty');
      }
      if (kDebugMode) {
        print(
          'Starting payment method creation for offerId: $offerId, amount: $amount',
        );
      }

      // Step 1: Create Setup Intent to collect card details
      if (kDebugMode) {
        print('Creating Setup Intent...');
      }
      String? setupIntentClientSecret = await _createSetupIntent();
      if (setupIntentClientSecret == null) {
        throw Exception('Failed to create setup intent: client secret is null');
      }
      if (kDebugMode) {
        print(
          'Setup Intent created with client_secret: $setupIntentClientSecret',
        );
      }

      // Step 2: Initialize Payment Sheet for Setup Intent
      if (kDebugMode) {
        print('Initializing Payment Sheet...');
      }
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: setupIntentClientSecret,
          merchantDisplayName: 'Jessichoo',
        ),
      );
      if (kDebugMode) {
        print('Payment Sheet initialized successfully');
      }

      // Step 3: Present Payment Sheet to collect card details
      if (kDebugMode) {
        print('Presenting Payment Sheet...');
      }
      await Stripe.instance.presentPaymentSheet();
      if (kDebugMode) {
        print('Payment Sheet presented successfully');
      }

      // Step 4: Retrieve Setup Intent to get Payment Method ID
      if (kDebugMode) {
        print('Retrieving Setup Intent...');
      }
      final setupIntent = await Stripe.instance.retrieveSetupIntent(
        setupIntentClientSecret,
      );
      final paymentMethodId = setupIntent.paymentMethodId;
      // ignore: unnecessary_null_comparison
      if (paymentMethodId == null) {
        throw Exception(
          'Failed to retrieve payment method ID from Setup Intent',
        );
      }
      if (kDebugMode) {
        print('Payment Method ID retrieved: $paymentMethodId');
      }
      if (kDebugMode) {
        print('Full Setup Intent response: ${setupIntent.toJson()}');
      }

      // Step 5: Authorize payment with offerId and paymentMethodId
      if (kDebugMode) {
        print(
          'Authorizing payment with offerId: $offerId, paymentMethodId: $paymentMethodId',
        );
      }
      await _authorizePaymentWithOffer(offerId, paymentMethodId);

      Get.snackbar(
        'success'.tr,
        'payment_authorized_successfully'.tr,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Payment authorization failed: $e');
      }
      Get.snackbar(
        'error'.tr,
        'Payment error: ${e.toString()}',
        backgroundColor: AppColors.secondaryColor,
        colorText: Colors.white,
      );
      rethrow;
    }
  }

  // Create Setup Intent
  Future<String?> _createSetupIntent() async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> body = {
        'automatic_payment_methods[enabled]': 'true',
      };
      if (kDebugMode) {
        print('Creating Setup Intent with body: $body');
      }
      var response = await dio.post(
        "https://api.stripe.com/v1/setup_intents",
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          print('Stripe API error response: ${response.data}');
        }
        throw Exception(
          'Stripe API error: ${response.data['error']['message'] ?? 'Unknown error'}',
        );
      }

      if (kDebugMode) {
        print('Setup Intent response: ${response.data}');
      }
      if (response.data != null && response.data['client_secret'] != null) {
        return response.data['client_secret'] as String;
      } else {
        throw Exception('Client secret not found in setup intent response');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating setup intent: $e');
      }
      rethrow;
    }
  }

  // Authorize payment by sending offerId and paymentMethodId to the backend
  Future<void> _authorizePaymentWithOffer(
    String offerId,
    String paymentMethodId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Authentication token is missing');
      }

      final Dio dio = Dio();
      final requestBody = {
        'offerId': offerId,
        'paymentMethodId': paymentMethodId,
      };
      if (kDebugMode) {
        print('Sending authorize payment request: $requestBody');
      }
      final response = await dio.post(
        '${Urls.baseUrl}/payments/authorize-payment',
        data: requestBody,
        options: Options(
          headers: {'Authorization': token, 'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        if (kDebugMode) {
          print(
            'Authorize Payment Response: status=${response.statusCode}, body=${response.data}',
          );
        }
        throw Exception(
          'Failed to authorize payment: ${response.data['message'] ?? 'Server error (status: ${response.statusCode})'}',
        );
      }
      if (kDebugMode) {
        print('Authorize Payment successful: ${response.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error authorizing payment: $e');
      }
      if (kDebugMode) {
        print(
          'Request Data: offerId=$offerId, paymentMethodId=$paymentMethodId',
        );
      }
      rethrow;
    }
  }

  // Legacy method using Payment Intent (for backward compatibility)
  Future<void> createAndAuthorizePaymentWithPaymentIntent(
    String offerId,
    int amount,
  ) async {
    try {
      if (offerId.isEmpty) {
        throw Exception('Offer ID is empty');
      }
      if (kDebugMode) {
        print(
          'Starting payment authorization for offerId: $offerId, amount: $amount',
        );
      }

      // Step 1: Create Payment Intent
      if (kDebugMode) {
        print('Creating Payment Intent...');
      }
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount,
        'usd',
      );
      if (paymentIntentClientSecret == null) {
        throw Exception(
          'Failed to create payment intent: client secret is null',
        );
      }
      if (kDebugMode) {
        print(
          'Payment Intent created with client_secret: $paymentIntentClientSecret',
        );
      }

      // Step 2: Initialize Payment Sheet
      if (kDebugMode) {
        print('Initializing Payment Sheet...');
      }
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Jessichoo',
        ),
      );
      if (kDebugMode) {
        print('Payment Sheet initialized successfully');
      }

      // Step 3: Present Payment Sheet
      if (kDebugMode) {
        print('Presenting Payment Sheet...');
      }
      await Stripe.instance.presentPaymentSheet();
      if (kDebugMode) {
        print('Payment Sheet presented successfully');
      }

      // Step 4: Retrieve Payment Intent
      if (kDebugMode) {
        print('Retrieving Payment Intent...');
      }
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(
        paymentIntentClientSecret,
      );
      final paymentMethodId = paymentIntent.paymentMethodId;
      if (paymentMethodId == null) {
        throw Exception(
          'Failed to retrieve payment method ID from Payment Intent',
        );
      }
      if (kDebugMode) {
        print('Payment Method ID retrieved: $paymentMethodId');
      }

      // Step 5: Authorize payment
      if (kDebugMode) {
        print(
          'Authorizing payment with offerId: $offerId, paymentMethodId: $paymentMethodId',
        );
      }
      await _authorizePaymentWithOffer(offerId, paymentMethodId);

      Get.snackbar(
        'success'.tr,
        'payment_authorized_successfully'.tr,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Payment authorization failed: $e');
      }
      Get.snackbar(
        'error'.tr,
        'Payment error: ${e.toString()}',
        backgroundColor: AppColors.secondaryColor,
        colorText: Colors.white,
      );
      rethrow;
    }
  }

  // Create Payment Intent
  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        'automatic_payment_methods[enabled]': 'true',
      };
      if (kDebugMode) {
        print('Creating Payment Intent with body: $body');
      }
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          print('Stripe API error response: ${response.data}');
        }
        throw Exception(
          'Stripe API error: ${response.data['error']['message'] ?? 'Unknown error'}',
        );
      }

      if (kDebugMode) {
        print('Payment Intent response: ${response.data}');
      }
      if (response.data != null && response.data['client_secret'] != null) {
        return response.data['client_secret'] as String;
      } else {
        throw Exception('Client secret not found in payment intent response');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating payment intent: $e');
      }
      rethrow;
    }
  }

  // Calculate amount in cents
  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  // Legacy method for backward compatibility
}
