import 'dart:collection';

import 'package:eshop/models/cartitem.dart';
import 'package:eshop/models/item.dart';
import 'package:eshop/models/sale.dart';
import 'package:eshop/models/user.dart';
import 'package:eshop/screens/checkout_screen.dart';
import 'package:eshop/screens/profile_screen.dart';
import 'package:eshop/screens/search_screen.dart';
import 'package:eshop/widgets/add_to_cart.dart';
import 'package:eshop/widgets/cart_button.dart';
import 'package:eshop/widgets/rebuy_carrousel.dart';
import 'package:eshop/widgets/sale_carrousel.dart';
import 'package:eshop/widgets/search_widget.dart';
import 'package:eshop/widgets/suggestion_list.dart';
import 'package:flutter/material.dart';
import 'package:eshop/models/data/inventory_data.dart';
import 'package:eshop/models/data/sales_data.dart';
import 'package:eshop/models/data/user_data.dart';

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
  final navigatorKey = GlobalKey<NavigatorState>();
  bool searching;
  String query;

  @override
  void initState() {
    super.initState();
    appTitle = "eShop";
    isLoggedIn = false;
    cartMap = new HashMap<String, int>();
    cartList = new List<CartItem>();
    buyAgain = new List<Item>();
    suggestions = new List<Item>();
    saleMap = new HashMap<Sale,
        bool>(); // Will ensure Sale prices can only be applied once per puchase.
    searching = false;
    query = "What can we help you find today?";
    _getBuyAgainList();
    _getSuggestions();
    _getSaleList();
  }

  void _login() {
    ///////  This method would handle user-login prior to setting the state //////
    setState(() {
      isLoggedIn = true;
    });
  }

  bool compareItems(Item item1, Item item2) {
    return (item1.name == item2.name && item1.index == item2.index);
  }

  void _addItemToCart({Item item, int quantity, Sale sale}) {
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
    for (Sale sale in sales) {
      sale.item.prices[sale.item.index] = sale.price;
      saleMap[sale] = false;
    }
  }

  void _getBuyAgainList() {
    // Fetch previous items purchased
    int startIndex = 0;
    int endIndex = inventory.length - 5;
    for (; startIndex < endIndex; startIndex++) {
      this.buyAgain.add(inventory[startIndex]);
    }
  }

  void _getSuggestions() {
    // Fetch suggestions based on previous searches or popular items
    int startIndex = 4;
    int endIndex = inventory.length;
    for (; startIndex < endIndex; startIndex++) {
      this.suggestions.add(inventory[startIndex]);
    }
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

  void search(String q) {
    setState(() {
      this.query = q;
      searching = true;
    });
  }

  void doneSearching() {
    setState(() {
      this.query = "What can we help you find today?";
      searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            appTitle,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          elevation: 0.0,
          leading: Visibility(
            visible: this.searching,
            child: GestureDetector(
                onTap: doneSearching,
                child: Icon(Icons.home,
                    color: Theme.of(context).primaryColor, size: 30.0)),
          ),
          actions: <Widget>[
            isLoggedIn
                ? Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(user),
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
                    padding: const EdgeInsets.all(10.0),
                    child: OutlineButton(
                      onPressed: _login,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      borderSide: BorderSide(
                        color: Theme.of(context)
                            .primaryColor, //Color of the border
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchWidget(this.query, this.search),
          searching
              ? SearchScreen(this.query, this._addToCartDialog)
              : Expanded(
                  child: ListView(
                    shrinkWrap: false,
                    children: <Widget>[
                      Sales(sales, this._addItemToCart, this.saleMap),
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
