import 'package:eshop/models/item.dart';
import 'package:eshop/models/sale.dart';

Item x = new Item("Sirloin Steak", "assets/images/sirloinsteak.png",
    [12.0, 16.0, 20.0], ["10oz", "16oz", "20oz"], ["Meat", "Steak"],
    selectedIndex: 1);

Item y = new Item("T-Bone Steak", "assets/images/tbonesteak.png",
    [12.0, 16.0, 20.0], ["10oz", "16oz", "20oz"], ["Meat", "Steak"],
    selectedIndex: 2);

Item z = new Item("Potatoes", "assets/images/potatoes.png", [4.0, 6.0, 8.0],
    ["1lb", "1.5lb", "2lb"], ["Potatoes", "Potato"],
    selectedIndex: 0);

List<Sale> sales = [
  new Sale(y, 2, y.prices[y.index] * 1.5, "BUY ONE, GET ONE 50% OFF"),
  new Sale(z, 2, x.prices[z.index], "BUY ONE, GET ONE FREE"),
  new Sale(x, 2, x.prices[x.index] * 1.5, "BUY ONE, GET ONE 50% OFF"),
];
