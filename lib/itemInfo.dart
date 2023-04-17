class ItemsGenerator {
  List<ItemInfo> list1 = List<ItemInfo>.generate(
      20,
      (index) => ItemInfo('UNIQLO Coat', 323,
          'assets/ZodiacalPlanets_Merzlyakov_960_annotated.jpg'));
  List<ItemInfo> list2 = List<ItemInfo>.generate(
      20,
      (index) => ItemInfo('Adidas Shoes', 250,
          'assets/VenusJupiterSky_Tumino_1080_annotated.jpg'));
  List<ItemInfo> list3 = List<ItemInfo>.generate(
      20,
      (index) => ItemInfo(
          'Nike Hat', 800, 'assets/10_Days_of_Venus_and_Jupiter.jpeg'));
}

class ItemInfo {
  final String title;
  final int price;
  final String imagePath;

  ItemInfo(this.title, this.price, this.imagePath);
}
