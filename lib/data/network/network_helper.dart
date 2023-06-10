import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../core/failures.dart';

abstract class NetworkHelper {
  Future<Either<Failure, String?>> get(String url,
      {Map<String, String>? headers, bool isNeedAuth});

  Future<Either<Failure, String?>> post(String url,
      {Map<String, String>? headers, body, encoding, bool isNeedAuth});


  Future<Either<Failure, String?>> patch(String url,
      {Map<String, String>? headers, body, encoding, bool isNeedAuth});



  bool isJson(response);

  Future<Either<Failure, String?>> delete(String url,
      {Map<String, String>? headers, bool isNeedAuth});

  Future<Either<Failure, String?>> put(String url,
      {Map<String, String>? headers, body, encoding, bool isNeedAuth});

  Future<Map<String, String>> appendHeader(
      {Map<String, String>? head, bool isNeedAuth});

  Either<Failure, String?> handleResponse({http.Response response});
}
