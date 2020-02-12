import 'package:eshop/models/cartitem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItemWidget extends StatelessWidget {
  CartItem item;
  bool editMode = false;
  Function edit;
  Function remove;
  final formatCurrency = new NumberFormat.simpleCurrency();

  CartItemWidget(this.item, this.edit, this.remove);

  _editModeEnabled() {
    editMode = true;
  }

  @override
  Widget build(BuildContext context) {
    String name = item.item.name;
    var size = item.item.sizes[item.item.selectedIndex];
    int quantity = item.quantity;
    double price = item.item.prices[item.item.selectedIndex] * item.quantity;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 5.0),
              Image.asset(item.item.imageURL, width: 90.0, height: 90.0),
              Container(
                width: editMode
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${name}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Size: ${size}",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600)),
                    item.isSale
                        ? Text(
                            "ON SALE",
                            style: TextStyle(color: Colors.red, fontSize: 12.0),
                          )
                        : Container()
                  ],
                ),
              ),
              Visibility(visible: editMode, child: Icon(Icons.remove_circle)),
              Text("Qty: ${quantity} "),
              Visibility(visible: editMode, child: Icon(Icons.add_circle)),
              Text(" ${formatCurrency.format(price)}  "),
            ],
          ),
          secondaryActions: editMode
              ? <Widget>[
                  IconSlideAction(
                    caption: 'Cancel',
                    color: Colors.red,
                    icon: Icons.cancel,
                    onTap: null,
                  ),
                  IconSlideAction(
                    caption: 'Confirm',
                    color: Colors.green,
                    icon: Icons.check_circle,
                    onTap: this.remove,
                  ),
                ]
              : <Widget>[
                  Visibility(
                    visible: !item.isSale,
                    child: IconSlideAction(
                      caption: 'Edit',
                      color: Colors.yellow[600],
                      icon: Icons.edit,
                      onTap: this._editModeEnabled,
                    ),
                  ),
                  IconSlideAction(
                    caption: 'Remove',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: this.remove,
                  ),
                ],
        ),
        Divider(thickness: 2.0, height: 1.0),
      ],
    );
  }
}
