import 'package:dmms/Core/models/error_response.dart';
import 'package:dmms/Core/resources/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../exceptions/exceptions.dart';

class ApiHelper {
  final Duration timeOutDuration = const Duration(seconds: 30);

  _responseHandler(http.Response response) {
    if (response.statusCode == 400) {
      var errorResponse = ErrorResponse(
          errorMessage: json.decode(response.body)['error_message'],
          details: json.decode(response.body)['details']);

      throw ServerException(errorResponse: errorResponse);
    }
    if (response.statusCode == 401) {
      throw UnauthorizedException(
          errorResponse:
              ErrorResponse(errorMessage: 'Unauthorized', details: ''));
    }
    if (response.statusCode == 403) {
      throw ServerException(
          errorResponse: ErrorResponse(
              errorMessage: 'Forbidden',
              details: 'Code: ${response.statusCode}'));
    }
    if (response.statusCode == 404) {
      throw ServerException(
          errorResponse: ErrorResponse(
              errorMessage: 'Notfound',
              details: 'Code: ${response.statusCode}'));
    }

    if (response.statusCode == 405) {
      throw ServerException(
          errorResponse: ErrorResponse(
              errorMessage: 'Method not allowed',
              details: 'Code: ${response.statusCode}'));
    }
    if (response.statusCode >= 500) {
      throw ServerException(
          errorResponse: ErrorResponse(
              errorMessage: 'Internal Server Error', details: ''));
    }
    throw ServerException(
        errorResponse: ErrorResponse(
            errorMessage: "Server Error",
            details: "Code: ${response.statusCode.toString()}"));
  }

  _headerBuilder(String? token) {
    return {
      "Accept": "application/json",
      "Content-type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> get({required String URL, String? token}) async {
    final url = Uri.parse(URL);

    final response =
        await http.get(url, headers: _headerBuilder(token)).timeout(
      timeOutDuration,
      onTimeout: () {
        throw ServerException(
            errorResponse: ErrorResponse(
                errorMessage: AppStrings.timeOut.tr(), details: ''));
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      _responseHandler(response);
    }
  }

  Future<dynamic> post(
      // ignore: non_constant_identifier_names
      {required String URL,
      dynamic body,
      String? token}) async {
    final url = Uri.parse(URL);
    final response = await http
        .post(url, body: jsonEncode(body), headers: _headerBuilder(token))
        .timeout(
      timeOutDuration,
      onTimeout: () {
        throw ErrorResponse(errorMessage: AppStrings.timeOut.tr(), details: '');
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      _responseHandler(response);
    }
  }

  Future<dynamic> delete(
      // ignore: non_constant_identifier_names
      {required String URL,
      dynamic body,
      String? token}) async {
    final url = Uri.parse(URL);
    final response = await http
        .delete(url, body: json.encode(body), headers: _headerBuilder(token))
        .timeout(
      timeOutDuration,
      onTimeout: () {
        throw ServerException(
            errorResponse: ErrorResponse(
                errorMessage: AppStrings.timeOut.tr(), details: ''));
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      _responseHandler(response);
    }
  }

  Future<dynamic> put(
      // ignore: non_constant_identifier_names
      {required String URL,
      dynamic body,
      String? token}) async {
    final url = Uri.parse(URL);
    final response = await http
        .put(url, body: json.encode(body), headers: _headerBuilder(token))
        .timeout(
      timeOutDuration,
      onTimeout: () {
        throw ServerException(
            errorResponse: ErrorResponse(
                errorMessage: AppStrings.timeOut.tr(), details: ''));
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      _responseHandler(response);
    }
  }
}
