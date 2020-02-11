import 'package:eshop/models/sale.dart';
import 'package:eshop/screens/see_all_screen.dart';
import 'package:eshop/widgets/sale_item.dart';
import 'package:flutter/material.dart';

class Sales extends StatelessWidget {
  List<Sale> list;
  Function _addToCart;

  Sales(this.list);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Sales",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0),
              ),
           /*   GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SeeAll("Sales", _addToCart, thislist.),
                  ),
                ),
                child: Text(
                  "See all",
                  style: TextStyle(color: Colors.blue),
                ),
              ),*/
            ],
          ),
        ),
        Container(
          height: 150.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return SaleItem(list[index]);
              }),
        ),
      ],
    );
  }
}
