import 'dart:convert';

import '/models/address_model.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class AddressProvider with ChangeNotifier {
  late String _tokenVal;

  late AddressModel addressModel;

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<AddressModel> fetchSetUserAddress() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.viewAddress}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final addressMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (addressMapResponse.statusCode < 400) {
        final addressData =
            json.decode(addressMapResponse.body) as Map<String, dynamic>;
        addressData.forEach((key, value) {
          if (key == 'data') {
            addressModel = AddressModel(
              id: value["id"],
              userId: value["user_id"],
              userEmail: value["user_email"],
              userName: value["user_name"],
              addressLine1: value["address_line1"],
              addressLine2: value["address_line2"],
              country: value["country"],
              state: value["state"],
              city: value["city"],
              postalCode: value["postal_code"],
              createdAt: value["created_at"],
              updatedAt: value["updated_at"],
            );
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return addressModel;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(addressMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Future<void> createAddress(String addrLine1, String addrLine2, String city,
      String state, String postal, String country) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.createAddress}';

      final inputBodyVal = json.encode({
        "address_line1": addrLine1,
        "address_line2": addrLine2,
        "city": city,
        "state": state,
        "postal_code": postal,
        "country": country,
      });

      final addressMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (addressMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(addressMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
