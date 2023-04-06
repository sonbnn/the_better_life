import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants.dart';
import 'package:the_better_life/utils/secure_storage_service.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';


class AuthService {

  static Future<bool> login({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      SecureStorage _secureStorage = injector.get<SecureStorage>();
      Map data = Map();
      data['username'] = username;
      data['password'] = password;
      
      Response response = await http.post('${Constants.apiUrl}/user/login', data: data);
      ResponseData dataResult = response.data;
      await Future.delayed(Duration(milliseconds: 1000));
      if (dataResult.data != null && dataResult.status) {
        TokenObj? token = TokenObj.fromJson(dataResult.data);
        await _secureStorage.setTokenObj(token);
        SnackbarBuilder.showSnackbar(content: dataResult.message ?? '');
        return true;
      } else {
        _secureStorage.removeToken();
        SnackbarBuilder.showSnackbar(content: dataResult.message ?? '', status: false);
      }
      return false;
    } catch (e) {
      print('AuthService login $e');
      SnackbarBuilder.showSnackbar(content: 'MSG_ERROR_SYSTEM', status: false);
      return false;
    }
  }

  static Future<bool> refreshToken(BuildContext context) async {
    try {
      SecureStorage _secureStorage = injector.get<SecureStorage>();
      TokenObj? tokenObj = await _secureStorage.getTokenObj();
      if (tokenObj != null && tokenObj.refreshToken != null) {
        Map data = new Map();
        data['refreshToken'] = tokenObj.refreshToken;
        Dio dio = Dio(BaseOptions(connectTimeout: 10000));
        Response? response = await dio.post('${Constants.apiUrl}/user/get-token-with-refresh-token', data: data);
        if (response.data != null && response.data['data'] != null) {
          TokenObj? token = TokenObj.fromJson(response.data['data']);
          print('Refresh token success');
          await _secureStorage.setTokenObj(token);
          return true;
        }
        return false;
      }
      return false;
    } catch (e, t) {
      print('AuthService refresh token $e $t');
      return false;
    }
  }

  static Future<bool> logout(BuildContext context) async {
    try {
      SecureStorage _secureStorage = injector.get<SecureStorage>();
      TokenObj? tokenObj = await _secureStorage.getTokenObj();
      if (tokenObj != null && tokenObj.refreshToken != null) {
        Map data = new Map();
        data['refreshToken'] = tokenObj.refreshToken;
        await http.post('${Constants.apiUrl}/user/logout', data: data);
        // ResponseData res = response.data;
        await _secureStorage.removeToken();
        return true;
      }
      return false;
    } catch (e, t) {
      print('AuthService logout $e $t');
      return false;
    }
  }
}
