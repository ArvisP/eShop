import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:eshop/models/data/inventory_data.dart';
import 'package:eshop/models/item.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  String query;
  Function search;
  String hint = "What can we help you find today?";

  SearchWidget(this.query, this.search);

  Future<List<String>> _search(String search) async {
    return List.generate(search.length, (int index) {
      return "Hello";
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 80.0,
      color: Theme.of(context).accentColor,
      child: SearchBar(
        shrinkWrap: true,
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
      ),
    );
  }
}
