import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  String? id;
  String? status;
  String? currentStatus;
  int? statusDetail;
  String? paymentDate;
  double? amount;
  int? installments;
  String? devReference;
  String? authorizationCode;
  String? message;
  String? carrierCode;
  String? installmentsType;
  String? paymentMethodType;
  String? productDescription;
  String? carrier;
  double? refundAmount;

  TransactionModel({
    this.id,
    this.status,
    this.currentStatus,
    this.statusDetail,
    this.paymentDate,
    this.amount,
    this.installments,
    this.devReference,
    this.authorizationCode,
    this.message,
    this.carrierCode,
    this.installmentsType,
    this.paymentMethodType,
    this.productDescription,
    this.carrier,
    this.refundAmount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String?,
      status: json['status'] as String?,
      currentStatus: json['current_status'] as String?,
      statusDetail: json['status_detail'] as int?,
      paymentDate: json['payment_date'] as String?,
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      installments: json['installments'] as int?,
      devReference: json['dev_reference'] as String?,
      authorizationCode: json['authorization_code'] as String?,
      message: json['message'] as String?,
      carrierCode: json['carrier_code'] as String?,
      installmentsType: json['installments_type'] as String?,
      paymentMethodType: json['payment_method_type'] as String?,
      productDescription: json['product_description'] as String?,
      carrier: json['carrier'] as String?,
      refundAmount: json['refund_amount'] != null ? (json['refund_amount'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (status != null) data['status'] = status;
    if (currentStatus != null) data['current_status'] = currentStatus;
    if (statusDetail != null) data['status_detail'] = statusDetail;
    if (paymentDate != null) data['payment_date'] = paymentDate;
    if (amount != null) data['amount'] = amount;
    if (installments != null) data['installments'] = installments;
    if (devReference != null) data['dev_reference'] = devReference;
    if (authorizationCode != null) data['authorization_code'] = authorizationCode;
    if (message != null) data['message'] = message;
    if (carrierCode != null) data['carrier_code'] = carrierCode;
    if (installmentsType != null) data['installments_type'] = installmentsType;
    if (paymentMethodType != null) data['payment_method_type'] = paymentMethodType;
    if (productDescription != null) data['product_description'] = productDescription;
    if (carrier != null) data['carrier'] = carrier;
    if (refundAmount != null) data['refund_amount'] = refundAmount;
    return data;
  }
}