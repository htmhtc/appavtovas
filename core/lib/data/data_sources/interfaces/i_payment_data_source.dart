import 'package:core/domain/entities/yookassa/yookassa_payment.dart';
import 'package:yookassa_payments_flutter/input_data/tokenization_module_input_data.dart';

abstract interface class IPaymentDataSource {
  TokenizationModuleInputData buildTokenizationInputData({
    required String shopToken,
    required String shopId,
    required String value,
    required String title,
    required String subtitle,
  });

  Future<YookassaPayment> createPaymentObject({
    required TokenizationModuleInputData tokenizationModuleInputData,
    required String shopToken,
    required String shopId,
    required String cost,
    required String paymentDescription,
    required String customerName,
    required String customerInn,
    required String customerEmail,
    required String customerPhone,
  });

  Future<String> fetchPaymentStatus({
    required String shopToken,
    required String shopId,
    required String paymentId,
  });
}