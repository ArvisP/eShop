import 'package:eshop/models/item.dart';
import 'package:eshop/screens/see_all_screen.dart';
import 'package:eshop/widgets/priced_item.dart';
import 'package:flutter/material.dart';

class BuyAgain extends StatelessWidget {
  List<Item> list;
  Function _addToCart;

  BuyAgain(this.list, this._addToCart);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(thickness: 1.0, height: 2.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Buy Again",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeAll("Buy Again", _addToCart, list),
                  ),
                ),
                child: Text(
                  "See all",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: list.length == 0 ? 30.0 : 150.0,
          child: list.length == 0
              ? Text(
                  "No previous purchases found.",
                  style: TextStyle(color: Colors.grey),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () => _addToCart(context, this.list[index]),
                        child: PricedItem(this.list[index]));
                  }),
        ),
        SizedBox(height: 5.0),
      ],
    );
  }
}
