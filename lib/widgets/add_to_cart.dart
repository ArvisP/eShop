import 'dart:collection';

import 'package:eshop/models/item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddToCart extends StatefulWidget {
  final Item item;
  final Function addToCart;
  int quantity = 1;
  HashMap<String, int> cartMap;

  AddToCart(this.item, this.addToCart, this.quantity, this.cartMap);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> with SingleTickerProviderStateMixin{
  double price;
  int _selectedIndex;
  bool _plusHeld;
  bool _minusHeld;
  bool _loopActive;
  AnimationController _controller;
  Animation<double> animation;
  final formatCurrency = new NumberFormat.simpleCurrency();

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _plusHeld = false;
    _minusHeld = false;
    _loopActive = false;
    _selectedIndex = this.widget.item.index;
    price = this.widget.item.prices[_selectedIndex] * widget.quantity;
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: -5, end: -0.6).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    
  }

  void _changeSize(int index) {
    String name = widget.item.name + " " + widget.item.sizes[index].toString();
    if (widget.cartMap.containsKey(name)) {
      widget.quantity = widget.cartMap[name];
    }

    setState(() {
      _selectedIndex = index;
      price = widget.quantity * this.widget.item.prices[_selectedIndex];
    });
    widget.item.index = index;
  }

  void _pressedAdd() async {
    if (_loopActive) return;
    _loopActive = true;
    int duration = 0;
    while (_plusHeld) {
      setState(() {
        widget.quantity++;
        price += widget.item.prices[_selectedIndex];
      });
      if (duration < 40) duration++;
      await Future.delayed(Duration(milliseconds: 200 - (duration * 3)));
    }
    _loopActive = false;
  }

  void _pressedDeduct() async {
    if (_loopActive) return;
    _loopActive = true;
    int duration = 0;
    while (_minusHeld) {
      setState(() {
        if (widget.quantity > 1) {
          widget.quantity--;
          price -= widget.item.prices[_selectedIndex];
        }
      });
      if (duration < 40) duration++;
      await Future.delayed(Duration(milliseconds: 200 - (duration * 3)));
    }
    _loopActive = false;
  }

  void _close() {
    Navigator.pop(context);
  }

  void _dismissAnimation() {
    widget.addToCart(item: widget.item, quantity: widget.quantity);
   // _controller.forward();
    Navigator.pop(context);
  }

  Widget _sizeButton(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: RaisedButton(
        onPressed: () => _changeSize(index),
        color: _selectedIndex == index ? Colors.blue[800] : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
        child: Text(
          this.widget.item.sizes[index],
          style: TextStyle(fontSize: 12, color: Colors.white),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child: Container(
          width: width * 0.7,
          height: height * 0.3,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Theme.of(context).accentColor, Colors.blue]),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: FractionalOffset(0.5, -0.6),
                child: Image.asset(widget.item.imageURL,
                    width: 150.0, height: 150.0),
              ),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: _close,
                  icon: Icon(Icons.close, color: Colors.black),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("${widget.item.name}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600)),
                  Container(
                    height: height * 0.03,
                    width: width * 0.7,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: this.widget.item.sizes.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: width * 0.7 / 3, child: _sizeButton(index));
                      },
                    ),
                  ),
                  Text("${formatCurrency.format(this.price)}",
                      style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Listener(
                        onPointerDown: (details) {
                          _minusHeld = true;
                          _pressedDeduct();
                        },
                        onPointerUp: (details) {
                          _minusHeld = false;
                        },
                        child: Icon(Icons.remove_circle_outline,
                            color: Colors.black, size: 50.0),
                      ),
                      Container(
                        width: 100.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        child: Text(
                          "${widget.quantity}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Listener(
                        onPointerDown: (details) {
                          _plusHeld = true;
                          _pressedAdd();
                        },
                        onPointerUp: (details) {
                          _plusHeld = false;
                        },
                        child: Icon(Icons.add_circle_outline,
                            color: Colors.black, size: 50.0),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: _dismissAnimation,
                    color: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                    child: Text('Add to Cart',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
