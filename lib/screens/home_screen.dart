import 'dart:collection';

import 'package:eshop/models/cartitem.dart';
import 'package:eshop/models/item.dart';
import 'package:eshop/models/sale.dart';
import 'package:eshop/models/user.dart';
import 'package:eshop/screens/checkout_screen.dart';
import 'package:eshop/screens/profile_screen.dart';
import 'package:eshop/widgets/add_to_cart.dart';
import 'package:eshop/widgets/cart_button.dart';
import 'package:eshop/widgets/rebuy_carrousel.dart';
import 'package:eshop/widgets/sale_carrousel.dart';
import 'package:eshop/widgets/search_bar.dart';
import 'package:eshop/widgets/suggestion_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn;
  String appTitle;
  HashMap<String, int> cartMap;
  HashMap<Sale, bool> saleMap;
  List<CartItem> cartList;
  List<Item> buyAgain;
  List<Item> suggestions;
  List<Sale> sales;
  final navigatorKey = GlobalKey<NavigatorState>();
  User user;

  @override
  void initState() {
    super.initState();
    appTitle = "eShop";
    isLoggedIn = false;
    cartMap = new HashMap<String, int>();
    cartList = new List<CartItem>();
    buyAgain = new List<Item>();
    suggestions = new List<Item>();
    sales = new List<Sale>();
    saleMap = new HashMap<Sale, bool>();
    _getBuyAgainList();
    _getSuggestions();
    _getSaleList();
  }

  void _login() {
    ///////  This method would handle user-login prior to setting the state //////
    user = new User("assets/images/profile.jpg", "Jane", "Doe", "01/01/1900",
        "New York", "NY");
    setState(() {
      isLoggedIn = true;
    });
  }

  bool compareItems(Item item1, Item item2) {
    return (item1.name == item2.name && item1.index == item2.index);
  }

  void _addItemToCart({Item item, int quantity, Sale sale}) {
    print("SALE REGISTERED");
    if (sale != null) {
      setState(() {
        cartList.add(new CartItem(sale.item, quantity, true));
      });
      return;
    }

    String name = item.name + " " + item.sizes[item.index].toString();
    if (!cartMap.containsKey(name)) {
      cartMap[name] = quantity;
    } else {
      cartMap.update(name, (e) => quantity);
      for (int i = 0; i < cartList.length; i++) {
        if (compareItems(cartList[i].item, item)) {
          setState(() {
            cartList.removeAt(i);
          });
          break;
        }
      }
    }
    if (quantity > 0) {
      setState(() {
        cartList.add(new CartItem(item, quantity, false));
      });
    }
  }

  _removeItem(Item item) {
    String name = item.name + " " + item.sizes[item.index].toString();
    cartMap.remove(name);
  }

  void _getSaleList() {
    Item x = new Item("Sirloin Steak", "assets/images/sirloinsteak.png",
        [12.0, 16.0, 20.0], ["10oz", "16oz", "20oz"], ["Meat", "Steak"]);
    x.index = 1;
    Item y = new Item("T-Bone Steak", "assets/images/tbonesteak.png",
        [12.0, 16.0, 20.0], ["10oz", "16oz", "20oz"], ["Meat", "Steak"]);
    y.index = 2;
    Item z = new Item("Potatoes", "assets/images/potatoes.png", [4.0, 6.0, 8.0],
        ["1lb", "1.5lb", "2lb"], ["Potatoes", "Potato"]);
    z.index = 0;

    sales.add(
        new Sale(y, 2, y.prices[y.index] * 1.5, "BUY ONE, GET ONE 50% OFF"));
    sales.add(new Sale(z, 2, x.prices[z.index], "BUY ONE, GET ONE FREE"));
    sales.add(
        new Sale(x, 2, x.prices[x.index] * 1.5, "BUY ONE, GET ONE 50% OFF"));
    for (Sale sale in sales) {
      print(sale.item.prices[sale.item.index]);
      sale.item.prices[sale.item.index] = sale.price;
      print(sale.item.prices[sale.item.index]);
      saleMap[sale] = false;
    }
  }

  void _getBuyAgainList() {
    Item b = new Item("Blueberries", "assets/images/blueberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(b);
    Item c = new Item("Oranges", "assets/images/oranges.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(c);
    Item d = new Item("Raspberries", "assets/images/raspberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(d);
    Item e = new Item("Strawberries", "assets/images/strawberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(e);
    Item f = new Item("Apples", "assets/images/apples.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(f);
    Item g = new Item("Cherries", "assets/images/cherries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(g);
    Item h = new Item("Pineapples", "assets/images/pineapples.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(h);
    Item i = new Item("Lemons", "assets/images/lemons.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(i);
    Item j = new Item("Limes", "assets/images/limes.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    buyAgain.add(j);
  }

  void _getSuggestions() {
    Item x = new Item("Sirloin Steak", "assets/images/sirloinsteak.png",
        [12.0, 16.0, 20.0], ["10oz", "16oz", "20oz"], ["Meat", "Steak"]);
    suggestions.add(x);
    Item y = new Item("T-Bone Steak", "assets/images/tbonesteak.png",
        [12.0, 16.0, 20.0], ["10oz", "16oz", "20oz"], ["Meat", "Steak"]);
    suggestions.add(y);
    Item z = new Item("Broccoli", "assets/images/broccoli.png",
        [1.00, 2.00, 3.00], ["1lb", "2lb", "3lb"], ["Vegetable"]);
    suggestions.add(z);
    Item j = new Item("Limes", "assets/images/limes.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(j);
    Item h = new Item("Pineapples", "assets/images/pineapples.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(h);
    Item e = new Item("Strawberries", "assets/images/strawberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(e);
    Item c = new Item("Oranges", "assets/images/oranges.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(c);
    Item d = new Item("Raspberries", "assets/images/raspberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(d);
    Item f = new Item("Apples", "assets/images/apples.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(f);
    Item b = new Item("Blueberries", "assets/images/blueberries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "Family Pack"], ["Fruit"]);
    suggestions.add(b);
    Item g = new Item("Cherries", "assets/images/cherries.png",
        [3.50, 4.50, 6.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(g);
    Item i = new Item("Lemons", "assets/images/lemons.png", [3.50, 4.50, 6.00],
        ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(i);
    Item k = new Item("Squash", "assets/images/squash.png", [2.50, 3.50, 4.00],
        ["8oz", "12oz", "16oz"], ["Vegetable"]);
    suggestions.add(k);
    Item l = new Item("Bananas", "assets/images/bananas.png",
        [1.50, 2.50, 3.00], ["8oz", "12oz", "16oz"], ["Fruit"]);
    suggestions.add(l);
    Item m = new Item("Carrots", "assets/images/carrots.png",
        [0.50, 1.00, 1.50], ["8oz", "12oz", "16oz"], ["Vegetable"]);
    suggestions.add(m);
  }

  void _addToCartDialog(BuildContext context, Item item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        String name = item.name + " " + item.sizes[item.index].toString();
        return Container(
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            margin: EdgeInsets.symmetric(
                vertical: height * 0.3, horizontal: width * 0.15),
            elevation: 1.0,
            child: AddToCart(item.clone(), _addItemToCart,
                cartMap.containsKey(name) ? cartMap[name] : 1, this.cartMap),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          appTitle,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
        actions: <Widget>[
          isLoggedIn
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(this.user),
                      ),
                    ),
                    icon: Hero(
                      tag: user.userImageURL,
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundImage: ExactAssetImage(user.userImageURL),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 15.0),
                  child: OutlineButton(
                    onPressed: _login,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    borderSide: BorderSide(
                      color:
                          Theme.of(context).primaryColor, //Color of the border
                      style: BorderStyle.solid, //Style of the border
                      width: 1.0,
                    ),
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SearchBar(),
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: false,
              children: <Widget>[
                Sales(this.sales, this._addItemToCart, this.saleMap),
                BuyAgain(this.buyAgain, _addToCartDialog),
                SuggestionList(this.suggestions, _addToCartDialog),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CartButton(
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckOutScreen(this.cartList, _removeItem),
          ),
        ),
        (cartList.length == 0),
      ),
    );
  }
}
