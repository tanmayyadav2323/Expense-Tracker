import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/models/months.dart';

class PaymentBox extends StatelessWidget {
  Transactions transaction;
  Function delete;
  PaymentBox({
    Key? key,
    required this.transaction,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  return delete(transaction);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction.subtitle,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                '${transaction.amount}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          DottedLine(
            dashLength: 10,
            dashColor: Colors.white70,
            dashGapLength: 6,
          )
        ],
      ),
    );
  }
}
