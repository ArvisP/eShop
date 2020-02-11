import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  AnimationController animationController;
  Animation animation;
  Function _shoppingCart;
  bool isEmpty = true;

  CartButton(this._shoppingCart, this.isEmpty);

  @override
  Widget build(BuildContext context) {
    animation = Tween(begin: 0, end: 60).animate(animationController);
    return FloatingActionButton(
      onPressed: _shoppingCart,
      elevation: 1.0,
      child: Icon(Icons.shopping_cart,
          color: isEmpty ? Colors.white : Colors.red, size: 30.0),
    );
  }
}
