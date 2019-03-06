import 'dart:async';

import 'package:meta/meta.dart';
import 'package:mobile_ecommerce/models/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> saveCartData(Cart cart) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString("cart", cart.box.toString());
    //print('cart saved: ${cart.box.toString()}');
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
