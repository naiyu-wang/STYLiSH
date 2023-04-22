import 'package:flutter/material.dart';
import 'package:stylish/elements.dart';
import 'package:stylish/productInfo.dart';
import 'package:stylish/staticResource.dart';
import 'package:stylish/webService.dart';
import 'productDetailPage.dart';
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

    _webService.requestProductList(ProductType.men).then((list) => setState(() {
          _menProductList = list;
        }));

    _webService
        .requestProductList(ProductType.women)
        .then((list) => setState(() {
              _womenProductList = list;
            }));

    _webService
        .requestProductList(ProductType.accessories)
        .then((list) => setState(() {
              _accessoriesProductList = list;
            }));

    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), theme: theme),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: TopSaleList(imageAssetPaths: imageAssetPaths)),
          const SizedBox(height: 10.0),
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ProductList(category: '男裝', products: _menProductList),
                const SizedBox(width: 10.0),
                ProductList(category: '女裝', products: _womenProductList),
                const SizedBox(width: 10.0),
                ProductList(category: '配件', products: _accessoriesProductList)
              ],
            ),
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

class ProductList extends StatelessWidget {
  const ProductList(
      {super.key, required this.category, required this.products});

  final String category;
  final List<ProductInfo> products;

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
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].title),
                  subtitle: Text('NT\$${products[index].price}'),
                  leading: SizedBox(
                    width: 80,
                    child: CachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      imageUrl: products[index].mainImagePath,
                      errorWidget: ((context, url, error) =>
                          const Icon(Icons.error)),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                  productInfo: products[index],
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
