import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stylish/elements.dart';
import 'package:stylish/productInfo.dart';
import 'package:stylish/staticResource.dart';
import 'package:stylish/webService.dart';
import 'itemDetail.dart';
import 'itemInfo.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WebService _webService = WebService();

  List<ProductInfo> _menProductList = List<ProductInfo>.empty();
  List<ProductInfo> _womenProductList = List<ProductInfo>.empty();
  List<ProductInfo> _accessoriesProductList = List<ProductInfo>.empty();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    List<String> imageAssetPaths = [
      'assets/JupiterVenus_Luy_960.jpg',
      'assets/VenusJupiterSky_Tumino_1080_annotated.jpg',
      'assets/10_Days_of_Venus_and_Jupiter.jpeg'
    ];

    var items = ItemsGenerator();

    _webService.getProductList(ProductType.men, (list) {
      print(list);
      setState(() {
        _menProductList = list;
      });
    });

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
              // ItemList(category: '男裝', items: items.list1),
              Expanded(
                  child: Column(
                children: [
                  Center(
                      child: InkWell(
                    onTap: () {},
                    child: const Text(
                      '男裝',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _menProductList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_menProductList[index].title),
                            subtitle:
                                Text('NT\$${_menProductList[index].price}'),
                            leading: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: _menProductList[index].mainImagePath,
                              errorWidget: ((context, url, error) =>
                                  const Icon(Icons.error)),
                            ),
                            contentPadding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemDetailPage(
                                            itemInfo: items.list1[index],
                                          )));
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10)),
                  )
                ],
              )),
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
