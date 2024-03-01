// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:techware_machinetest/data/remote/AppException.dart';
import 'package:techware_machinetest/utils/Utils.dart';

import 'BaseApiService.dart';

class NetworkApiService extends BaseApiService {
  final BuildContext? context;

  NetworkApiService({required this.context});

  @override
  Future get(
    String url,
  ) async {
    dynamic responseJson;
    try {
      //var tockenKey = await SharedPrefsUtil.getString(SharedPrefsUtil.tokenkey);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        //"authentication_key": "$tockenKey"
      };

      Log.print(headers);
      final response =
          await http.get(Uri.parse(baseUrl + url), headers: headers);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    Log.print("Url-----------: $baseUrl$url");
    Log.print("Response-----------: $responseJson");
    //debugPrint("Response: $responseJson");
    return responseJson;
  }

/////

  @override
  Future put(
    String url, {
    Map<String, dynamic>? data = const {},
  }) async {
    debugPrint("🐣 Api Request: $baseUrl$url");
    debugPrint("🐸 Request: $data");
    dynamic responseJson;
    try {
      //   var tockenKey = await SharedPrefsUtil.getString(SharedPrefsUtil.tokenkey);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        // "authentication_key": "$tockenKey",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
      };

      Log.print(headers);
      final response = await http.put(
        Uri.parse(baseUrl + url),
        body: jsonEncode(data),
        headers: headers,
      );

      //debugPrint('🦠 Response: ${response.body}');
      responseJson = returnResponse(response);
      Log.print("Url-----------: $baseUrl$url$data");
      Log.print("Response-----------: $responseJson");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    // debugPrint("🐥 Api Response: $baseUrl$url");
    // debugPrint("🐝 Response: $responseJson");
    return responseJson;
  }

//////

  @override
  Future post(String url, {Map<String, dynamic>? data = const {}, type}) async {
    debugPrint("🐣 Api Request: $baseUrl$url");
    debugPrint("🐸 Request: $data");
    dynamic responseJson;
    try {
      // var tockenKey = await SharedPrefsUtil.getString(SharedPrefsUtil.tokenkey);
      Map<String, String> headers;

      if (type == 1) {
        headers = {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
        };
      } else {
        headers = {
          'Content-Type': 'application/json',
          // "authentication_key": "$tockenKey",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
        };
      }

      Log.print(headers);
      final response = await http.post(Uri.parse(baseUrl + url),
          body: jsonEncode(data), headers: headers);

      //debugPrint('🦠 Response: ${response.body}');
      responseJson = returnResponse(response);
      Log.print("Url-----------: $baseUrl$url$data");
      Log.print("Response-----------: $responseJson");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    // debugPrint("🐥 Api Response: $baseUrl$url");
    // debugPrint("🐝 Response: $responseJson");
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      //  case 400:
      //   throw BadRequestException(response.toString());
      // case 401:
      //   toastMessage("UnAuthorised,AccesToken Expired");
      //   SharedPrefsUtil.logOut();
      //   rootNavigatorKey.currentState!.context.go(AppRoutes.inputMobNum);
      //   throw LogoutExeption();

      // case 403:
      //   throw UnauthorisedException(response.body.toString());
      // case 404:
      //   throw UnauthorisedException(response.body.toString());
      // case 500: */
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}
