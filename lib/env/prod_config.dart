import 'package:nuvei_sdk_flutter/env/base_config.dart';

class ProdConfig extends BaseConfig {
  @override
  String get environment => "PROD";

  @override
  String get urlBase => "https://ccapi-stg.paymentez.com";
  
}