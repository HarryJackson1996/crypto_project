import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  final String coinName;
  final double coinValue;

  CoinTile({this.coinName, this.coinValue}) : assert(coinName != null && coinValue != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: 100,
        color: Color.fromRGBO(230, 230, 230, 1),
        child: Row(
          children: [Text(coinName + ": "), Text(coinValue.toString())],
        ),
      ),
    );
  }
}
