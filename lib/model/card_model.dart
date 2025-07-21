import 'dart:convert';

///prefixes of multiples cards
///

List<String> visaPrefixes = ["4"];
List<String> mastercardPrefixes = [
  "2221",
  "2222",
  "2223",
  "2224",
  "2225",
  "2226",
  "2227",
  "2228",
  "2229",
  "223",
  "224",
  "225",
  "226",
  "227",
  "228",
  "229",
  "23",
  "24",
  "25",
  "26",
  "270",
  "271",
  "2720",
  "50",
  "51",
  "52",
  "53",
  "54",
  "55",
];
List<String> amexPrefixes = ["34", "37"];
List<String> discoverPrefixes = ["60", "62", "64", "65"];
List<String> jcbPrefixes = ["35"];
List<String> dinersClubPrefixes = [
  "300",
  "301",
  "302",
  "303",
  "304",
  "305",
  "309",
  "36",
  "38",
  "39",
];
List<String> maestroPrefixes = ["56","59", "67", "69"];

/// Model to build a card payment
/// contains a required and optional parameters
/// use [CardBuilder] to build a Card as
/// Card Model you required
class CardModel {
  final String cardNumber;
  final String holderName;
  final int expiryMonth;
  final int expiryYear;
  final String cvc;
  final String? type;
  final String? accountType;

  CardModel._({
    required this.cardNumber,
    required this.holderName,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvc,
    this.type,
    this.accountType,
  });

  /// Serializa el modelo a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'card_number': cardNumber,
      'holder_name': holderName,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
      'cvc': cvc,
      if (type != null) 'type': type,
      if (accountType != null) 'account_type': accountType,
    };
  }

  /// Deserializa un mapa JSON a un objeto CardModel.
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel._(
      cardNumber: json['card_number'] as String,
      holderName: json['holder_name'] as String,
      expiryMonth: json['expiry_month'] as int,
      expiryYear: json['expiry_year'] as int,
      cvc: json['cvc'] as String,
      type: json['type'] as String?,
      accountType: json['account_type'] as String?,
    );
  }

  /// Convierte el modelo a una cadena JSON.
  String toJsonString() => jsonEncode(toJson());

  /// Crea un CardModel a partir de una cadena JSON.
  factory CardModel.fromJsonString(String jsonString) =>
      CardModel.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
}

/// Clase Builder para construir instancias de CardModel.
class CardBuilder {
  String? _cardNumber;
  String? _holderName;
  int? _expiryMonth;
  int? _expiryYear;
  String? _cvc;
  String? _type;
  String? _accountType;

  /// Establece el número de la tarjeta (requerido).
  CardBuilder setCardNumber(String cardNumber) {
    _cardNumber = cardNumber;
    return this;
  }

  /// Establece el nombre del titular (requerido).
  CardBuilder setHolderName(String holderName) {
    _holderName = holderName;
    return this;
  }

  /// Establece el mes de expiración (requerido).
  CardBuilder setExpiryMonth(int expiryMonth) {
    _expiryMonth = expiryMonth;
    return this;
  }

  /// Establece el año de expiración (requerido).
  CardBuilder setExpiryYear(int expiryYear) {
    _expiryYear = expiryYear;
    return this;
  }

  /// Establece el código de seguridad (requerido).
  CardBuilder setCvc(String cvc) {
    _cvc = cvc;
    return this;
  }

  /// Establece el tipo de tarjeta (opcional).
  CardBuilder setType(String? type) {
    _type = type;
    return this;
  }

  /// Establece el tipo de cuenta (opcional).
  CardBuilder setAccountType(String? accountType) {
    _accountType = accountType;
    return this;
  }

  /// Construye el objeto CardModel, validando los campos requeridos.
  CardModel build() {
    if (_cardNumber == null || _cardNumber!.isEmpty) {
      throw ArgumentError('El número de tarjeta es requerido.');
    }
    if (_holderName == null || _holderName!.isEmpty) {
      throw ArgumentError('El nombre del titular es requerido.');
    }
    if (_expiryMonth == null) {
      throw ArgumentError('El mes de expiración es requerido.');
    }
    if (_expiryYear == null) {
      throw ArgumentError('El año de expiración es requerido.');
    }
    if (_cvc == null || _cvc!.isEmpty) {
      throw ArgumentError('El código CVC es requerido.');
    }

    return CardModel._(
      cardNumber: _cardNumber!,
      holderName: _holderName!,
      expiryMonth: _expiryMonth!,
      expiryYear: _expiryYear!,
      cvc: _cvc!,
      type: _type,
      accountType: _accountType,
    );
  }
}
