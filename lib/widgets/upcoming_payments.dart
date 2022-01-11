import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class UpcomingPayments extends StatelessWidget {
  Widget icon;
  String title;
  String subtitle;
  double amount;

  UpcomingPayments({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: icon,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 1),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 9,
            ),
            Text(
              '+\$${amount}',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              colors: [Colors.white70.withOpacity(0.01), Colors.black54],
              stops: const [0, 0.2]),
        ),
        height: 180,
        width: 150,
      ),
    );
  }
}
