import 'package:eshop/models/cartitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItemWidget extends StatefulWidget {
  CartItem item;
  bool editMode = false;
  Function edit;
  Function remove;

  CartItemWidget(this.item, this.remove);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final formatCurrency = new NumberFormat.simpleCurrency();
  String _name;
  String _size;
  int tempQuantity;
  double tempPrice;
  SlidableState state;

  @override
  void initState() {
    super.initState();
    _name = widget.item.item.name;
    _size = widget.item.item.sizes[widget.item.item.selectedIndex];
  }

  _switchEditMode() {
    if (!widget.editMode) {
      tempQuantity = widget.item.quantity;
      tempPrice = widget.item.price;
    }
    setState(() {
      widget.editMode = !widget.editMode;
    });
  }

  _okEdit() {
    widget.item.setQuantity(tempQuantity);
    _switchEditMode();
  }

  _cancelEdit() {
    _switchEditMode();
  }

  void _pressedAdd() {
    setState(() {
      tempQuantity++;
      tempPrice += widget.item.item.prices[widget.item.item.index];
    });
  }

  void _pressedDeduct() {
    setState(() {
      tempQuantity--;
      tempPrice -= widget.item.item.prices[widget.item.item.index];
    });
  }

  @override
  Widget build(BuildContext context) {  
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: false,
           
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 5.0),
              Image.asset(widget.item.item.imageURL, width: 80.0, height: 90.0),
              Container(
                width: widget.editMode
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "$_name",
                      style: TextStyle(fontWeight: FontWeight.w600),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Size: $_size",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600)),
                    widget.item.isSale
                        ? Text(
                            "ON SALE",
                            style: TextStyle(color: Colors.red, fontSize: 12.0),
                          )
                        : Container()
                  ],
                ),
              ),
              Visibility(
                visible: (widget.editMode && tempQuantity > 1),
                child: GestureDetector(
                  onTap: _pressedDeduct,
                  child: Icon(Icons.remove_circle),
                ),
              ),
              widget.editMode
                  ? Text("Qty: $tempQuantity")
                  : Text("Qty: ${widget.item.quantity} "),
              Visibility(
                visible: widget.editMode,
                child: GestureDetector(
                  onTap: _pressedAdd,
                  child: Icon(Icons.add_circle),
                ),
              ),
              widget.editMode
                  ? Text(" ${formatCurrency.format(tempPrice)}  ")
                  : Text(" ${formatCurrency.format(widget.item.price)}  "),
            ],
          ),
          secondaryActions: widget.editMode
              ? <Widget>[
                  IconSlideAction(
                    caption: 'Cancel',
                    color: Colors.red,
                    icon: Icons.cancel,
                    onTap: _cancelEdit,
                  ),
                  IconSlideAction(
                    caption: 'Confirm',
                    color: Colors.green,
                    icon: Icons.check_circle,
                    onTap: _okEdit,
                  ),
                ]
              : <Widget>[
                  Visibility(
                    visible: !widget.item.isSale,
                    child: IconSlideAction(
                      caption: 'Edit',
                      color: Colors.yellow[600],
                      icon: Icons.edit,
                      onTap: this._switchEditMode,
                    ),
                  ),
                  IconSlideAction(
                    caption: 'Remove',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: this.widget.remove,
                  ),
                ],
        ),
        Divider(thickness: 2.0, height: 1.0),
        
      ],
    );
  }
}
