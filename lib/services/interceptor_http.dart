import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:nuvei_sdk_flutter/env/environment.dart';
import 'package:nuvei_sdk_flutter/helper/global_helper.dart';
import 'package:nuvei_sdk_flutter/model/error_model.dart';
import 'package:nuvei_sdk_flutter/model/general_response.dart';

class InterceptorHttp {
  Future<dynamic> request(
    String method,
    String urlEndpoint,
    String code,
    String key,
    dynamic body, {
    Map<String, dynamic>? queryParameters,
    String requestType = "JSON",
    int timeout = 60,
  }) async {
    var logger = Logger(
      printer: PrettyPrinter(methodCount: 0, printEmojis: false),
    );
    final urlService = Environment().baseConfig?.urlBase ?? 'no url';
    String url = "$urlService$urlEndpoint";
    if (queryParameters != null && queryParameters.isNotEmpty) {
      url += "?${Uri(queryParameters: queryParameters).query}";
    }
    logger.t('Url; $url');
    body != null
        ? logger.log(Level.warning, 'body: ${json.encode(body)}')
        : null;

    dynamic data;

    try {
      http.Response _response;
      Uri uri = Uri.parse(url);
      String token = GlobalHelper().generateToken(code, key);
      log(token);
      Map<String, String> _headers = {
        "Auth-token": token,
        "Content-Type": "application/json",
      };

      int responseStatusCode = 0;
      String responseBody = "";

      switch (method) {
        case "POST":
          log(_headers.toString());
          _response = await http
              .post(
                uri,
                headers: _headers,
                body: body != null ? json.encode(body) : null,
              )
              .timeout(Duration(seconds: timeout));
          break;
        case "GET":
          log(_headers.toString());
          _response = await http
              .get(uri, headers: _headers)
              .timeout(Duration(seconds: timeout));
          break;
        default:
          _response = await http.post(uri, body: jsonEncode(body));
          break;
      }
      responseBody = _response.body;
      logger.log(Level.error, responseBody);
      responseStatusCode = _response.statusCode;
      log(responseStatusCode.toString());
      logger.log(Level.trace, json.decode(responseBody));
      switch (responseStatusCode) {
        case 200:
          data = json.decode(responseBody);
          // generalResponse.data = responseDecoded;
          // generalResponse.error = false;
          // generalResponse.message = "request ok";
          break;
        case 400:
          data =ErrorResponseModel.fromJson( json.decode(responseBody));
          // generalResponse.data = responseDecoded;
          // generalResponse.error = true;
          // generalResponse.message = "Bad Request";
          break;
        case 401:
          log(responseBody);
          data =ErrorResponseModel.fromJson( json.decode(responseBody));
          // generalResponse.data = errorResponseModelFromJson(
          //   jsonEncode(responseDecoded),
          // );
          // generalResponse.error = true;
          // generalResponse.message = "Unauthorized ";
          break;
        case 403:
          data = ErrorResponseModel.fromJson( json.decode(responseBody));
          // generalResponse.data = errorResponseModelFromJson(
          //   jsonEncode(responseDecoded),
          // );
          // generalResponse.error = true;
          // generalResponse.message = "Forbidden";
          break;
        case 404:
          data = ErrorResponseModel.fromJson( json.decode(responseBody));

          // generalResponse.data = errorResponseModelFromJson(
          //   jsonEncode(responseDecoded),
          // );
          // generalResponse.error = true;
          // generalResponse.message = "Not found";
          break;
        case 409:
          data = ErrorResponseModel.fromJson( json.decode(responseBody));

          // generalResponse.data = errorResponseModelFromJson(
          //   jsonEncode(responseDecoded),
          // );
          // generalResponse.error = true;
          // generalResponse.message = "Conflict";
          break;
        case 500:
          data =ErrorResponseModel.fromJson( json.decode(responseBody));
          // generalResponse.data = errorResponseModelFromJson(
          //   jsonEncode(responseDecoded),
          // );
          // generalResponse.error = true;
          // generalResponse.message = "Internal Server Error";
          break;
        case 503:
          data =ErrorResponseModel.fromJson( json.decode(responseBody));
          // generalResponse.data = errorResponseModelFromJson(
          //   jsonEncode(responseDecoded),
          // );
          // generalResponse.error = true;
          // generalResponse.message = "Service Unavailable";
          break;
        default:
        data= ErrorResponseModel(error: Error(type: 'Error in request', help: 'help', description: ""));
        // generalResponse.error = true;
        // generalResponse.message = "Error in request";
      }
    } on TimeoutException catch (e) {
      data = ErrorResponseModel(
        error: Error(
          type: 'Timeout',
          help: "Time to connection has been exceed, retry again ",
          description:"",
        ),
      );
      debugPrint('$e');
    } on FormatException catch (ex) {
      data = ErrorResponseModel(
        error: Error(
          type: 'Format Exception',
          help: "Invalid request format, review your attempt",
          description: "",
        ),
      );
      debugPrint(ex.toString());
    } on SocketException catch (exSock) {
      data = ErrorResponseModel(
        error: Error(
          type: 'Soclet Exception',
          help: "Connection error, review you internet connection",
          description: "",
        ),
      );
      logger.e("Connection error, review you connection: $exSock");
    } on Exception catch (e, stacktrace) {
      data = ErrorResponseModel(
        error: Error(
          type: 'Exception',
          help: "Error on request",
          description: "",
        ),
      );
      logger.e("Error on request: $stacktrace");
    }
    return data;
  }

  HttpClient getHttpClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient =
        HttpClient()
          ..connectionTimeout = const Duration(seconds: 10)
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);

    return httpClient;
  }
}
