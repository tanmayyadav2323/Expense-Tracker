import 'package:flutter/material.dart';
import 'package:personal_expenses/models/months.dart';
import 'package:personal_expenses/widgets/payments_box.dart';
import 'package:provider/provider.dart';

class Payments extends StatelessWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final months = Provider.of<Months>(context);
    final transactions = months.transactions;
    return transactions.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(colors: [
                Colors.white70.withOpacity(0.1),
                Colors.black54.withOpacity(0.9)
              ], stops: const [
                0,
                0.08
              ]),
            ),
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.only(right: 20, left: 20, top: 20),
              itemBuilder: (context, index) {
                return PaymentBox(
                  transaction: transactions[index],
                  delete: months.deleteTransaction,
                );
              },
              itemCount: transactions.length,
            ),
          )
        : Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(colors: [
                Colors.white70.withOpacity(0.1),
                Colors.black54.withOpacity(0.9)
              ], stops: const [
                0,
                0.08
              ]),
            ),
            child: const Center(
                child: Text(
              "No Transactions Yet 🤨",
              style: TextStyle(fontSize: 20),
            )),
          );
  }
}
