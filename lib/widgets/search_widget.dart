import 'dart:collection';

import 'package:eshop/models/data/inventory_data.dart';
import 'package:eshop/models/item.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import "package:eshop/widgets/search_item_tile.dart";

class SearchWidget extends StatefulWidget {
  final HashMap<String, List<Item>> categoryMap;
  final Function addToCart;

  SearchWidget(this.categoryMap, this.addToCart);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final hint = "What can we help you find today?";
  bool searching = false;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Item>> _search(String search) async {
    search = search.toLowerCase();
    setState(() {
      searching = true;
    });
    List<Item> result = new List<Item>();
    for (Item item in inventory) {
      String name = item.name.toLowerCase();
      if (name.startsWith(search) || name.contains(search)) {
        result.add(item);
      }
    }
    if (widget.categoryMap.containsKey(search)) {
      for (Item item in widget.categoryMap[search]) {
        result.add(item);
      }
    }
    return result;
  }

  Widget _emptyWidget() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.1,
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
            Text("No results found", style: TextStyle(fontSize: 18.0)),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      width: width * 0.95,
      height: searching ? 350.0 : 80.0,
      margin: EdgeInsets.only(left: width * 0.025),
      child: SearchBar<Item>(
          // -------------- STYLING ------------- //
          shrinkWrap: false,
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10.0),
          headerPadding: EdgeInsets.all(0.0),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          icon: Icon(Icons.search),
          iconActiveColor: Theme.of(context).accentColor,
          searchBarStyle: SearchBarStyle(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              padding: EdgeInsets.only(left: 10.0),
              backgroundColor: Theme.of(context).primaryColor),
          textStyle: TextStyle(color: Theme.of(context).focusColor),
          loader: Center(
            child: CircularProgressIndicator(
              value: null,
              strokeWidth: 4.0,
            ),
          ),
          crossAxisCount: 1,
          // -------------------------------------- //
          onSearch: _search,
          onCancelled: () => searching = false,
          emptyWidget: _emptyWidget(),
          onItemFound: (Item item, int index) {
            return SearchItemTile(item, () => widget.addToCart(context, item));
          }),
    );
  }
}
