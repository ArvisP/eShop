import 'package:eshop/models/item.dart';
import 'package:eshop/widgets/priced_item.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  String query;
  Function _addToCart;

  SearchScreen(this.query, this._addToCart);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Item> result;

  @override
  void initState() {
    super.initState();

    /// Process query to build result list ///
    result = new List<Item>();
    Item x = new Item("Sirloin Steak", "assets/images/sirloinsteak.png",
        [12.0, 16.0, 20.0], ["10oz", "16oz", "20oz"], ["Meat", "Steak"]);
    result.add(x);
    Item y = new Item("T-Bone Steak", "assets/images/tbonesteak.png",
        [12.0, 16.0, 20.0], ["10oz", "16oz", "20oz"], ["Meat", "Steak"]);
    result.add(y);
    Item z = new Item("Broccoli", "assets/images/broccoli.png",
        [1.00, 2.00, 3.00], ["1lb", "2lb", "3lb"], ["Vegetable"]);
    result.add(z);
    Item j = new Item("Limes", "assets/images/limes.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(j);
    Item h = new Item("Pineapples", "assets/images/pineapples.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(h);
    Item e = new Item("Strawberries", "assets/images/strawberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(e);
    Item c = new Item("Oranges", "assets/images/oranges.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(c);
    Item d = new Item("Raspberries", "assets/images/raspberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(d);
    Item f = new Item("Apples", "assets/images/apples.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(f);
    Item b = new Item("Blueberries", "assets/images/blueberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "Family Pack"], ["Fruit"]);
    result.add(b);
    Item g = new Item("Cherries", "assets/images/cherries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(g);
    Item i = new Item("Lemons", "assets/images/lemons.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(i);
    Item k = new Item("Squash", "assets/images/squash.png", [2.50, 3.50, 4.00],
        ["8oz", "12oz", "16oz"], ["Vegetable"]);
    result.add(k);
    Item l = new Item("Bananas", "assets/images/bananas.png",
        [1.50, 2.50, 3.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(l);
    Item m = new Item("Carrots", "assets/images/carrots.png",
        [0.50, 1.00, 1.50], ["8oz", "12oz", "16oz"], ["Vegetable"]);
    result.add(m);
    d = new Item("Raspberries", "assets/images/raspberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(d);
    f = new Item("Apples", "assets/images/apples.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(f);
    b = new Item("Blueberries", "assets/images/blueberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "Family Pack"], ["Fruit"]);
    result.add(b);
    g = new Item("Cherries", "assets/images/cherries.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(g);
    i = new Item("Lemons", "assets/images/lemons.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    result.add(i);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),
          RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).focusColor,
              ),
              children: <TextSpan>[
                new TextSpan(
                  text: "Search results for:  ",
                ),
                new TextSpan(
                  text: "\"${widget.query}\"",
                  style: new TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            flex: 1,
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: this.result.map((Item i) {
                return GestureDetector(
                  onTap: () => widget._addToCart(context, i),
                  child: PricedItem(i),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
