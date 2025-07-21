import 'package:nuvei_sdk_flutter/model/card_model.dart';
import 'package:nuvei_sdk_flutter/model/user_model.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter_method_channel.dart';
import 'package:nuvei_sdk_flutter/nuvei_sdk_flutter_method_transaction.dart';

abstract class NuveiSdkFlutterTransactionInterface {
  NuveiSdkFlutterTransactionInterface() : super();

  static NuveiSdkFlutterTransactionInterface _instance =
      NuveiSdkFlutterMethodTransaction();

  static NuveiSdkFlutterTransactionInterface get instance => _instance;

  static set instance(NuveiSdkFlutterTransactionInterface instance) {
    _instance = instance;
  }

   void initEnvironment(String appCode, String appKey, String serverCode, String serverKey, bool testMode){
    throw UnimplementedError('Delete card has not been implemented');
  }

  Future<String?> deleteCard(){
    throw UnimplementedError('Delete card has not been implemented');
  } 

  Future<List<CardModel>?> listCards(String uid){
    throw UnimplementedError('Delete card has not been implemented');
  }

  Future<CardModel?> addCard(CardModel card, UserModel user){
    throw UnimplementedError('Delete card has not been implemented');
  }
  
}
