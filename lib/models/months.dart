import 'package:flutter/material.dart';
import 'package:personal_expenses/helpers/db_helpers.dart';

class Transactions {
  String id;
  String title;
  String subtitle;
  int amount;
  String month;

  Transactions(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.month});
}

class Months with ChangeNotifier {
  int _selectedIndex = 0;
  final List _months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List get months {
    return [..._months];
  }

  int get index {
    return _selectedIndex;
  }

  void ChangeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List _transactions = [];

  void addTransaction(Transactions trans) {
    final newTrans = Transactions(
        id: DateTime.now().toString(),
        title: trans.title,
        subtitle: trans.subtitle,
        amount: trans.amount,
        month: trans.month);
    _transactions.add(trans);
    notifyListeners();
    DBHelper.insert('user', {
      'id': newTrans.id,
      'title': newTrans.title,
      'subtitle': newTrans.subtitle,
      'amount': newTrans.amount,
      'month': newTrans.month
    });
  }

  Future<void> fetchAndSetTrans() async {
    final dataList = await DBHelper.getData('user');
    _transactions = dataList
        .map((item) => Transactions(
            id: item['id'],
            title: item['title'],
            subtitle: item['subtitle'],
            amount: item['amount'],
            month: item['month']))
        .toList();
    notifyListeners();
  }

  void deleteTransaction(Transactions trans) {
    int index = _transactions.indexOf(trans);
    _transactions.removeAt(index);
    DBHelper.delete(trans.id);
    notifyListeners();
  }

  int totalAmount(int index) {
    int total = 0;
    for (var element in _transactions) {
      if (element.month == _months[index]) {
        total += int.parse(element.amount.toString());
      }
    }
    return total;
  }

  List get transactions {
    fetchAndSetTrans();
    List x = _transactions.map((obj) {
      if (obj.month == _months[_selectedIndex]) {
        return obj;
      }
    }).toList();
    x.removeWhere((item) => item == null);
    return x;
  }
}
