class OtpRequest {
  final OtpUser? user;
  final OtpTransaction? transaction;
  final String? type; // valores posibles: "BY_OTP" | "BY_CRES" | "AUTHENTICATION_CONTINUE" | "BY_AMOUNT" | "BY_AUTH_CODE"
  final String? value;
  final bool? moreInfo;

  OtpRequest({
    this.user,
    this.transaction,
    this.type,
    this.value,
    this.moreInfo,
  });

  factory OtpRequest.fromJson(Map<String, dynamic> json) {
    return OtpRequest(
      user: json['user'] != null ? OtpUser.fromJson(json['user']) : null,
      transaction: json['transaction'] != null ? OtpTransaction.fromJson(json['transaction']) : null,
      type: json['type'],
      value: json['value'],
      moreInfo: json['more_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (user != null) 'user': user!.toJson(),
      if (transaction != null) 'transaction': transaction!.toJson(),
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (moreInfo != null) 'more_info': moreInfo,
    };
  }
}

class OtpUser {
  final String id;

  OtpUser({required this.id});

  factory OtpUser.fromJson(Map<String, dynamic> json) {
    return OtpUser(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

class OtpTransaction {
  final String id;

  OtpTransaction({required this.id});

  factory OtpTransaction.fromJson(Map<String, dynamic> json) {
    return OtpTransaction(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
