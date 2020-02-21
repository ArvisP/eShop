import 'package:eshop/models/cartitem.dart';
import 'package:eshop/models/item.dart';
import 'package:eshop/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckOutScreen extends StatefulWidget {
  List<CartItem> cart;
  Function removeItem;
  bool editing = false;
  CheckOutScreen(this.cart, this.removeItem);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final formatCurrency = new NumberFormat.simpleCurrency();
  double total = 0;

  @override
  void initState() {
    super.initState();
    _getTotal();
  }

  _getTotal() {
    double temp = 0;
    for (CartItem item in this.widget.cart) {
      temp += item.price;
    }
    setState(() {
      total = temp;
    });
  }

  _remove(BuildContext context, int index) {
    String name = widget.cart[index].item.name;
    widget.removeItem(widget.cart[index].item);
    setState(() {
      widget.cart.removeAt(index);
    });

    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$name removed',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ));
  }

  _pay(BuildContext context) {
    /////// Select payment method ///////
    /////// Process payment ///////
    ////// Send order for fulfillment //////
    /////// Add order info to user's account //////
    setState(() {
      widget.cart.clear();
    });
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text("Thank you for your order!"),
                content: Text(
                    'Give us 10 minutes to get your order ready for pick up :)'),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return;
        });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          "Shopping Cart",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Column(
        mainAxisAlignment: widget.cart.length == 0
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: <Widget>[
          (widget.cart.length == 0)
              ? Text(
                  "No items in your cart",
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
                )
              : Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.cart.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CartItemWidget(
                        widget.cart[index],
                        () => _remove(context, index),
                        _getTotal,
                      );
                    },
                  ),
                ),
          (widget.cart.length == 0)
              ? Container()
              : Container(
                  height: 80.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total: ${formatCurrency.format(total)}",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.cart.length == 0 ? null : () => _pay(context),
        child: Text("Pay", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
