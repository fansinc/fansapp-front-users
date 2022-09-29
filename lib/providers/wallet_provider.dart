import 'dart:convert';

import '/models/wallet_model.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class WalletProvider with ChangeNotifier {
  late String _tokenVal;

  late WalletModel walletModel;

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<WalletModel> getWalletInterest() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.getWalletInterest}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final walletMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (walletMapResponse.statusCode < 400) {
        final profileData =
            json.decode(walletMapResponse.body) as Map<String, dynamic>;
        profileData.forEach((key, value) {
          if (key == 'wallet_interest_status') {
            walletModel = WalletModel(
              walletInterestStatus: value,
            );
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return walletModel;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(walletMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Future<void> createWalletInterest(bool walletInterestStatus) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.setWalletInterest}';

      final inputBodyVal = json.encode({
        "wallet_interest_status": walletInterestStatus,
      });

      final walletMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (walletMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(walletMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
