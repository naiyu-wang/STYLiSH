import 'package:flutter/material.dart';
import 'package:stylish/elements.dart';
import 'itemDetail.dart';
import 'itemInfo.dart';

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
      appBar: MainAppBar(appBar: AppBar(), theme: theme),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: TopSaleList(imageAssetPaths: imageAssetPaths)),
          const SizedBox(height: 10.0),
          Expanded(
              child: Row(
            children: [
              ItemList(category: '男裝', items: items.list1),
              const SizedBox(width: 10.0),
              ItemList(category: '女裝', items: items.list2),
              const SizedBox(width: 10.0),
              ItemList(category: '配件', items: items.list3)
            ],
          )),
        ],
      ),
    );
  }
}

class TopSaleList extends StatelessWidget {
  const TopSaleList({
    super.key,
    required this.imageAssetPaths,
  });

  final List<String> imageAssetPaths;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
        separatorBuilder: (context, index) => const SizedBox(width: 5.0),
        itemCount: imageAssetPaths.length);
  }
}

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.category, required this.items});

  final String category;
  final List<ItemInfo> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Center(
            child: InkWell(
          onTap: () {},
          child: Text(
            category,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
        Expanded(
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
              separatorBuilder: (context, index) => const SizedBox(height: 10)),
        )
      ],
    ));
  }
}
