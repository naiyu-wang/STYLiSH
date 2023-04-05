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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
      backgroundColor: theme.colorScheme.primaryContainer,
      appBar: AppBar(
        title: Image.asset('assets/stylish_logo.png',
            width: 150, fit: BoxFit.cover),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 300,
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(imageAssetPaths[index]),
                        ));
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5.0),
                  itemCount: imageAssetPaths.length)),
          const SizedBox(height: 10.0),
          Expanded(
              child: Row(
            children: [
              ItemList(category: 'UNIQLO', items: items.list1),
              const SizedBox(width: 10.0),
              ItemList(category: 'Adidas', items: items.list2),
              const SizedBox(width: 10.0),
              ItemList(category: 'Nike', items: items.list3)
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

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.category, required this.items});

  final String category;
  final List<ItemInfo> items;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index].title),
                subtitle: Text('NT\$${items[index].price}'),
                leading: Image.asset(items[index].imagePath),
                contentPadding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemDetailPage(
                                itemInfo: items[index],
                              )));
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10)));
  }
}

///////

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key, required this.itemInfo});

  final ItemInfo itemInfo;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var titleStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
    );
    var infoStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    return Scaffold(
        backgroundColor: theme.colorScheme.primaryContainer,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 500, child: Image.asset(itemInfo.imagePath)),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(itemInfo.title, style: titleStyle),
                      Text(DateTime.now().toString(), style: infoStyle),
                      Text(
                        'NT\$${itemInfo.price}',
                        style: titleStyle,
                      ),
                      Container(
                          width: double.infinity,
                          height: 1.0,
                          color: theme.colorScheme.primary),
                      OptionBox(
                          title: 'color',
                          options: 'options',
                          infoStyle: infoStyle,
                          theme: theme),
                      OptionBox(
                          title: 'size',
                          options: 'options',
                          infoStyle: infoStyle,
                          theme: theme),
                      OptionBox(
                          title: 'amount',
                          options: 'options',
                          infoStyle: infoStyle,
                          theme: theme)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class OptionBox extends StatelessWidget {
  const OptionBox({
    super.key,
    required this.title,
    required this.options,
    required this.infoStyle,
    required this.theme,
  });

  final String title;
  final String options;
  final TextStyle infoStyle;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50.0,
        child: Row(children: [
          Text(title, style: infoStyle),
          Container(
              width: 1.0,
              height: 30.0,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              color: theme.colorScheme.primary),
          Text(options)
        ]));
  }
}
