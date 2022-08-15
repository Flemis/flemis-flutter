/* import 'dart:convert';
import 'dart:typed_data';

import 'package:futstat/environments/production.environment.dart';
//import 'package:futstat/environments/local.environment.dart';
import 'package:futstat/environments/staging.environment.dart';

import 'package:futstat/models/apiResponse.model.dart';
import 'package:futstat/repositories/user.repository.dart';
import 'package:futstat/services/user.service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DefaultService {
  UserRepository userRepository = UserRepository();

  // ---------------------------------------------------------
  // Para mudar o ambiente basta mudar a instância
  // StagingEnvironment() ou ProductionEnvironment()
  // ou LocalEnvironment() (rodando local)
  // ---------------------------------------------------------

  static var environment = StagingEnvironment();

  static String serviceURL = environment.serviceURL;
  static String paymentUrl = environment.paymentURL;
  static String serviceOldURL = environment.serviceOldURL;
  static String playerImagesURL = environment.playerImagesURL;
  static String apiTokenOldURL = environment.apiTokenOldURL;
  static String serviceTerms = environment.serviceTerms;

  Future<String> getToken() async {
    var user = await userRepository.read();
    /* var token = (user != null && user.token != null)
        ? user.token['access_token']
        : null;*/

    var token;
    if (user != null && user.token != null) {
      Duration tokenRemainingTime =
          JwtDecoder.getRemainingTime(user.token['access_token']);
      if (JwtDecoder.isExpired(user.token["access_token"]) ||
          tokenRemainingTime.inMinutes <= Duration(days: 1).inMinutes) {
        var tokenResponse = await refreshToken(user.token);

        user.token = tokenResponse.result["token"];
        await userRepository.save(user);
        token = user.token["access_token"];
      } else {
        token = user.token["access_token"];
      }
    } else {
      return null;
    }
    return token;
  }

  Future<APIResponse> refreshToken(dynamic oldToken) async {
    String url = "$serviceURL/v1/login/refreshtoken";
    var body = {
      "token": oldToken["access_token"],
      "refreshToken": oldToken["refresh_token"]
    };

    try {
      var response = await this.postRefreshToken(url, body: body);
      if (response.statusCode != 200) {
        return APIResponse(
            status: parseResponse(response).status,
            result: parseResponse(response).result,
            message: parseResponse(response).message);
      }
      return APIResponse(
        status: parseResponse(response).status,
        result: parseResponse(response).result,
        message: parseResponse(response).message,
      );
    } catch (e) {
      return APIResponse(
          status: 500,
          message: "Houve um erro, confira a sua internet e tente novamente");
    }
  }

  Future<Response> postRefreshToken(String url,
      {Map<dynamic, dynamic> body}) async {
    final response = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> post(String url, {Map<dynamic, dynamic> body}) async {
    var token = await getToken();
    final response = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> delete(String url, {Map<dynamic, dynamic> body}) async {
    var token = await getToken();

    final response = await http.delete(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> deleteString(String url, String body) async {
    var token = await getToken();

    final response = await http.post(Uri.parse(url),
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> put(String url, {Map<String, dynamic> body}) async {
    var token = await getToken();

    final response = await http.put(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> postString(String url, String body) async {
    var token = await getToken();

    final response = await http.post(Uri.parse(url),
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> get(String url) async {
    var token = await getToken();

    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json", 'Authorization': 'Bearer $token'},
    );
    return response;
  }

  String decodeToJsonString(Uint8List bodyBytes) {
    return utf8.decode(bodyBytes);
  }

  APIResponse parseResponse<T>(Response response) {
    final decoded = decodeToJsonString(response.bodyBytes);
    return APIResponse<T>.fromJson(json.decode(decoded));
  }

  APIResponse parseUserResponse<T>(Response response) {
    final decoded = decodeToJsonString(response.bodyBytes);
    return APIResponse<T>.userFromJson(json.decode(decoded));
  }
}
 */

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../environments/staging_environment.dart';

class DefaultService {
  //UserRepository userRepository = UserRepository();

  static var environment = StagingEnvironment();

  static String? envUrl = environment.url;

  Future<String?> getToken() async {
    //var user = await userRepository.read();
    /* var token = (user != null && user.token != null)
        ? user.token['access_token']
        : null;*/
    var user;
    var token;
    if (user != null && user.token != null) {
      token = user.token;
    } else {
      return null;
    }
    return token;
  }

  Future<Response> post(String url, {Map<dynamic, dynamic>? body}) async {
    // var token = await getToken();
    final response = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          // "Authorization": "Bearer $token",
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> multiPartForm(
      String url, http.MultipartRequest request) async {
    final response = await http.Response.fromStream(await request.send());
    return response;
  }

  Future<Response> delete(String url, {Map<dynamic, dynamic>? body}) async {
    var token = await getToken();

    final response = await http.delete(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> deleteString(String url, String body) async {
    var token = await getToken();

    final response = await http.post(Uri.parse(url),
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> put(String url, {Map<String, dynamic>? body}) async {
    var token = await getToken();

    final response = await http.put(Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> postString(String url, String body) async {
    var token = await getToken();

    final response = await http.post(Uri.parse(url),
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<Response> get(String url) async {
    var token = await getToken();

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  String decodeToJsonString(Uint8List bodyBytes) {
    return utf8.decode(bodyBytes);
  }

  /* APIResponse parseResponse<T>(Response response) {
    final decoded = decodeToJsonString(response.bodyBytes);
    return APIResponse<T>.fromJson(json.decode(decoded));
  }

  APIResponse parseUserResponse<T>(Response response) {
    final decoded = decodeToJsonString(response.bodyBytes);
    return APIResponse<T>.userFromJson(json.decode(decoded));
  } */

}
