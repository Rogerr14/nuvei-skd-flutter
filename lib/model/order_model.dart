
class Order {
  double amount;
  String? description;
  String? devReference;
  double? vat;
  int? installments;
  int? installmentsType;
  double? taxableAmount;
  double? taxPercentage;
  int? monthsGrace;

  Order({
    required this.amount,
    required this.description,
    required this.devReference,
    required this.vat,
    this.installments,
    this.installmentsType,
    this.taxableAmount,
    this.taxPercentage,
    this.monthsGrace,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      devReference: json['dev_reference'] as String,
      vat: (json['vat'] as num).toDouble(),
      installments: json['installments'] as int?,
      installmentsType: json['installments_type'] as int?,
      taxableAmount: json['taxable_amount'] != null ? (json['taxable_amount'] as num).toDouble() : null,
      taxPercentage: json['tax_percentage'] != null ? (json['tax_percentage'] as num).toDouble() : null,
      monthsGrace: json['months_grace'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'amount': amount
    };
    if(devReference != null) data['dev_reference'] = devReference;
    if(vat != null) data['vat'] = vat;
    if (description != null) data['description'] = description;
    if (installments != null) data['installments'] = installments;
    if (installmentsType != null) data['installments_type'] = installmentsType;
    if (taxableAmount != null) data['taxable_amount'] = taxableAmount;
    if (taxPercentage != null) data['tax_percentage'] = taxPercentage;
    if (monthsGrace != null) data['months_grace'] = monthsGrace;
    return data;
  }
}
