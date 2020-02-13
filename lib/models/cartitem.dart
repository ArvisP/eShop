import 'package:eshop/models/item.dart';

class CartItem {
  Item item;
  int quantity;
  bool isSale;
  double price;
  
  CartItem(this.item, int q, this.isSale){
    setQuantity(q);
  }

  setQuantity(int q){
    this.quantity = q;
    price = item.prices[item.index] * this.quantity;
  }
}