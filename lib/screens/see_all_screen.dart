import 'package:eshop/models/item.dart';
import 'package:eshop/widgets/priced_item.dart';
import 'package:flutter/material.dart';

class SeeAll extends StatelessWidget {
  List<Item> list;
  String title;
  Function _addToCart;

  SeeAll(this.title, this._addToCart, this.list);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title,
            style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Container(
        child: list.length == 0
            ? Center(
                child: Text(
                  "No previous purchases",
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
                ),
              )
            : GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children: this.list.map((Item i) {
                  return GestureDetector(
                    onTap: () => _addToCart(context, i),
                    child: PricedItem(i),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
