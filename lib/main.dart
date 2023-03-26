import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Program App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(
        title: "STYLiSH",
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required title});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    List<String> imageAssetPaths = [
      'assets/JupiterVenus_Luy_960.jpg',
      'assets/VenusJupiterSky_Tumino_1080_annotated.jpg',
      'assets/10_Days_of_Venus_and_Jupiter.jpeg'
    ];

    var items = ItemsGenerator();

    return Scaffold(
      appBar: AppBar(
        title: const Text("STYLiSH"),
        titleTextStyle:
            TextStyle(fontSize: 28.0, color: theme.appBarTheme.foregroundColor),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              for (var imagePath in imageAssetPaths)
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(imagePath),
                    ),
                  ),
                )
            ],
          )),
          const SizedBox(height: 10.0),
          Expanded(
              child: Row(
            children: [
              ItemList(items: items.list1),
              ItemList(items: items.list2),
              ItemList(items: items.list3)
            ],
          )),
        ],
      ),
    );
  }
}

class ItemsGenerator {
  List<ItemInfo> list1 = List<ItemInfo>.generate(
      20,
      (index) =>
          ItemInfo('UNIQLO Coat', 323, 'assets/JupiterVenus_Luy_960.jpg'));
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

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.items});

  final List<ItemInfo> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      children: [
        for (var item in items)
          ListTile(
            title: Text(item.title),
            subtitle: Text('NT\$${item.price}'),
            leading: Image.asset(item.imagePath, width: 100),
          )
      ],
    ));
  }
}
