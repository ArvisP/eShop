import 'package:eshop/models/item.dart';
import 'package:eshop/screens/see_all_screen.dart';
import 'package:eshop/widgets/priced_item.dart';
import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  List<Item> suggestions;
  Function _addToCart;
  SuggestionList(this.suggestions, this._addToCart);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(thickness: 1.0, height: 2.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Suggestions",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeAll("Suggestions", _addToCart, suggestions),
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
            child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          shrinkWrap: true,
          children: this.suggestions.map(
            (Item i) {
              return GestureDetector(
                onTap: () => _addToCart(context, i),
                child: PricedItem(i),
              );
            },
          ).toList(),
        ))
      ],
    );
  }
}
