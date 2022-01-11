import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:personal_expenses/helpers/db_profile.dart';

class User {
  final String id;
  final String username;
  final int cardNumber;
  File? image;
  final String holderName;
  final int balance;
  final int income;

  User(
      {required this.id,
      required this.balance,
      required this.cardNumber,
      required this.holderName,
      required this.image,
      required this.income,
      required this.username});
}

class UserDetail with ChangeNotifier {
  var _user = User(
      id: '',
      username: "Hey dude",
      balance: 0,
      cardNumber: 0,
      image: null,
      holderName: "Add Holder Name",
      income: 0);

  User get userdetail {
    return _user;
  }

  void AddDetails(User user) {
    final usr = User(
        id: DateTime.now().toString(),
        balance: user.balance,
        cardNumber: user.cardNumber,
        holderName: user.holderName,
        image: user.image,
        income: user.income,
        username: user.username);
    _user = usr;
    notifyListeners();
    DBProfile.insert('profile', {
      'id': usr.id,
      'balance': usr.balance,
      'cardNumber': usr.cardNumber,
      'holderName': usr.holderName,
      'image': usr.image!.path,
      'income': usr.income,
      'username': usr.username
    });
  }

  Future<void> fetchAndSetData() async {
    final dataList = await DBProfile.getData('profile');
    _user = dataList.map((item) => item);
  }

  void UpdateImage(File image) {
    _user.image = image;
    notifyListeners();
  }
}
