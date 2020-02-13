import 'package:eshop/models/sale.dart';
import 'package:flutter/material.dart';

class SaleItem extends StatelessWidget {
  Sale sale;
  SaleItem(this.sale);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(sale.item.imageURL, width: 150.0, height: 110.0),
          Text(
            "${sale.item.name} - ${sale.item.sizes[sale.item.index]}",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(sale.description,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 10.0),
              maxLines: 1,
              overflow: TextOverflow.fade),
        ],
      ),
    );
  }
}
