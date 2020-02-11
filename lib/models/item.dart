class Item {
  final String name;
  final String imageURL;
  final List<double> prices;
  final List<String> sizes;
  List<String> categories;
  int selectedIndex;

  int get index {
    return this.selectedIndex;
  }

  set index (int i) {
    this.selectedIndex = i;
  }

  Item(this.name, this.imageURL, this.prices, this.sizes, this.categories){
    this.selectedIndex = 0;
  }

  Item clone(){
    Item copy = new Item(this.name, this.imageURL, this.prices, this.sizes, this.categories);
    copy.index = this.index;
    return copy;
  }
}