import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  String query;
  Function search;

  SearchBar(this.query, this.search);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var iconHeight = 30.0;
    return Container(
      width: width,
      height: height / 20,
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Theme.of(context).accentColor,
            height: iconHeight,
            width: iconHeight,
            child: Icon(Icons.search, color: Theme.of(context).primaryColor),
          ),
          Container(
            width: width - iconHeight - 10.0,
            height: 30.0,
            color: Theme.of(context).primaryColor,
            child: AutoCompleteTextField<String>(
              key: key,
              suggestions: ["Hello"],
              style: new TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).focusColor,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, bottom: 13.0),
                hintText: this.query,
                hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic),
              ),
              itemFilter: (item, query) {
                return item.toLowerCase().startsWith(query.toLowerCase());
              },
              itemSorter: (a, b) {
                return a.compareTo(b);
              },
              itemSubmitted: (item) {
                this.search(item);
              },
              itemBuilder: (context, item) {
                return Text(item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
