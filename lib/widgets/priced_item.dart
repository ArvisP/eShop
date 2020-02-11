import 'package:eshop/models/item.dart';
import 'package:flutter/material.dart';

class PricedItem extends StatelessWidget {
  final Item item;

  PricedItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(item.imageURL, width: 100.0, height: 80.0),
          Text("${this.item.name}"),
          Text(
            "\$${this.item.prices[0].toStringAsFixed(2)}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 14.0),
          ),
          Text(
            "${this.item.sizes[0]}",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
