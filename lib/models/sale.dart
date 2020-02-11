import "package:eshop/models/item.dart";

class Sale {
  Item item;
  int quantity;
  double price;
  String description;

  Sale(this.item, this.quantity, this.price, this.description);
}