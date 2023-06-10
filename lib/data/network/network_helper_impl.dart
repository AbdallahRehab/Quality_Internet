import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

import '../../core/failures.dart';
import '../storage/storage_keys.dart';
import '../storage/storage_repo.dart';
import 'network_helper.dart';

class NetworkHelperImpl extends NetworkHelper {
  var logger = Logger();
  StorageRepo storage;

  NetworkHelperImpl({required this.storage});

  @override
  Future<Either<Failure, String?>> get(String url,
      {Map<String, String>? headers, bool? isNeedAuth = true}) async {
    headers ??= {};
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: await appendHeader(head: headers, isNeedAuth: isNeedAuth),
      );
      print("URL:: $url");
      return handleResponse(response: response);
    } catch (e) {
      return Left(
        Failure(statusCode: 0, message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, String?>> post(String url,
      {body,
      encoding,
      bool encodeBody = true,
      Map<String, String>? headers,
      bool? isNeedAuth = true}) async {
    headers ??= {};
    try {
      final response = await http.post(
        Uri.parse(url),
        body: encodeBody ? json.encode(body) : body,
        headers: await appendHeader(head: headers, isNeedAuth: isNeedAuth),
        encoding: encoding,
      );

      log(
        "RESPONSE:POST:\n -(URL) >> ${url} \n -(BODY) >> ${body} \n -(RESPONSE BODY) >> ${response.statusCode} - ${json.decode(utf8.decode(response.bodyBytes))} \n ",
      );

      return handleResponse(response: response, requestBody: json.encode(body));
    } catch (e) {
      return Left(
        Failure(
          statusCode: 0,
          message: e.toString(),
        ),
      );
    }
  }



  @override
  Future<Either<Failure, String?>> delete(String url,
      {Map<String, String>? headers, bool isNeedAuth = true}) async {
    headers ??= {};
    return http
        .delete(
      Uri.parse(url),
      headers: await appendHeader(head: headers, isNeedAuth: isNeedAuth),
    )
        .then((http.Response response) {
      return handleResponse(response: response);
    });
  }

  @override
  Future<Either<Failure, String?>> put(String url,
      {Map<String, String>? headers,
      body,
      encoding,
      bool isNeedAuth = true}) async {
    headers ??= {};
    return http
        .put(Uri.parse(url),
            body: json.encode(body),
            headers: await appendHeader(head: headers!, isNeedAuth: isNeedAuth),
            encoding: encoding)
        .then(
      (http.Response response) {
        return handleResponse(response: response);
      },
    );
  }

  @override
  Future<Map<String, String>> appendHeader(
      {Map<String, String>? head, bool? isNeedAuth = true}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    if (head != null) {
      headers.addAll(head);
    }
    if (isNeedAuth!) {
      try {
        String? token = await storage.read(StorageKeys.authToken);
        headers.addAll({'Authorization': "Bearer $token"});
      } catch (e) {}
    }
    return headers;
  }

  @override
  Either<Failure, String?> handleResponse(
      {http.Response? response, String? requestBody}) {
    final int statusCode = response!.statusCode;

    print(response.statusCode);
    print(response.body);
    if (statusCode >= 400) {
      //first check if the response is json response
      late bool isJson;
      try {
        jsonDecode(response.body.toString());
        isJson = true;
      } catch (e) {
        isJson = false;
      }

      if (!isJson) {
        if (kDebugMode) {
          print("Data received is not json");
        }
        return Left(
          Failure(message: "Error fetching data", statusCode: statusCode),
        );
      }

      return Left(
        Failure(
            message: json.decode(response.body).toString(),
            statusCode: statusCode),
      );
    } else {
      return Right(response.body);
    }
  }

  @override
  bool isJson(response) {
    {
      late bool isJson;
      try {
        jsonDecode(response);
        isJson = true;
      } catch (e) {
        isJson = false;
      }
      return isJson;
    }
  }

  @override
  Future<Either<Failure, String?>> patch(String url,
      {body,
      encoding,
      bool encodeBody = true,
      Map<String, String>? headers,
      bool? isNeedAuth = true}) async {
    headers ??= {};
    try {
      final response = await http.patch(
        Uri.parse(url),
        body: encodeBody ? json.encode(body) : body,
        headers: await appendHeader(head: headers, isNeedAuth: isNeedAuth),
        encoding: encoding,
      );

      log(
        "RESPONSE:PATCH:\n -(URL) >> ${url} \n -(BODY) >> ${body} \n -(RESPONSE BODY) >> ${response.statusCode} - ${json.decode(utf8.decode(response.bodyBytes))} \n ",
      );

      return handleResponse(response: response, requestBody: json.encode(body));
    } catch (e) {
      return Left(
        Failure(
          statusCode: 0,
          message: e.toString(),
        ),
      );
    }
  }
}
