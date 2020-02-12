import 'package:eshop/models/item.dart';

class CartItem {
  Item item;
  int quantity;
  bool isSale;

  CartItem(this.item, this.quantity, this.isSale);
}