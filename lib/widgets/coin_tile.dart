import 'package:crytpo_project/models/coin.dart';
import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  final Coin coin;
  final Function onPressed;
  CoinTile({
    this.coin,
    this.onPressed,
  }) : assert(coin != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: 100,
        color: Color.fromRGBO(230, 230, 230, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(coin.name + ": "),
            IconButton(
              icon: Icon(
                Icons.bookmark,
                color: coin.bookmarked ? Colors.green : Colors.white,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
