import 'package:nuvei_sdk_flutter/env/base_config.dart';

class DevConfig extends BaseConfig {
  @override
  String get environment => "DEV";

  @override
  String get urlBase => "https://ccapi-stg.paymentez.com";
  
}