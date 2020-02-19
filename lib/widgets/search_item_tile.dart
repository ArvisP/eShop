import 'package:eshop/models/item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchItemTile extends StatelessWidget {
  String name;
  String sizes;
  String price;
  String imageURL;
  final formatCurrency = new NumberFormat.simpleCurrency();
  final Function addToCart;

  SearchItemTile(Item item, this.addToCart) {
    name = item.name;
    sizes =
        item.sizes.toString().substring(1, item.sizes.toString().length - 1);
    price =
        "${formatCurrency.format(item.prices[0]).toString()} - ${formatCurrency.format(item.prices[item.prices.length - 1]).toString()}";
    imageURL = item.imageURL;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addToCart,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor == Colors.white
              ? Colors.grey[300]
              : Theme.of(context).primaryColor,
          border: Border.all(
              style: BorderStyle.solid,
              width: 0.5,
              color: Theme.of(context).focusColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageURL, width: 70.0, height: 70.0),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.name,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text("Sizes: $sizes"),
              ],
            ),
            SizedBox(width: 30.0),
            Text(
              this.price,
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
