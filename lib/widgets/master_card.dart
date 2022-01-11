import 'dart:math';

import 'package:flutter/material.dart';

class MasterCard extends StatelessWidget {
  int cardNumber;
  String cardHolder;
  MasterCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: pi / 8,
          child: Padding(
            padding: const EdgeInsets.only(top: 38, left: 40),
            child: Container(
              height: 200,
              width: 325,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green[300]!.withOpacity(0.3),
                      Colors.green[900]!.withOpacity(0.3)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
            ),
          ),
        ),
        Transform.rotate(
          angle: pi / 18,
          child: Padding(
            padding: const EdgeInsets.only(top: 38, left: 40),
            child: Container(
              height: 200,
              width: 325,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green[300]!.withOpacity(0.6),
                      Colors.green[900]!.withOpacity(0.6)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
            ),
          ),
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 225,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: LinearGradient(
                      colors: [Colors.green[300]!, Colors.green[900]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    image: NetworkImage(
                        'https://cdn.iconscout.com/icon/premium/png-256-thumb/credit-card-chip-1522324-1288446.png'),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${(cardNumber ~/ pow(10, 12))} ${((cardNumber ~/ pow(10, 12)) * pow(10, 12) - cardNumber ~/ pow(10, 9))}',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'CARD HOLDER',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Text(
                        cardHolder,
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Text(
                        'Mastercard',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w900),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 45,
              left: 220,
              child: Container(
                height: 200,
                width: 200,
                child: const Positioned(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://brand.mastercard.com/content/dam/mccom/brandcenter/thumbnails/mc_downloads_symbol_350x200.png'),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
