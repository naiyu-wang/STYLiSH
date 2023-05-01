import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // static const platform = MethodChannel('stylish.flutter/homePage');

  // Test: Get battery level. from iOS platform
  // String _batteryLevel = 'Unknown battery level.';

  // Future<String> _getBatteryLevel() async {
  //   String batteryLevel;
  //   try {
  //     final int result = await platform.invokeMethod('getBatteryLevel');
  //     batteryLevel = 'Battery level at $result % .';
  //   } on PlatformException catch (e) {
  //     batteryLevel = "Failed to get battery level: '${e.message}'.";
  //   }
  //   return batteryLevel;
  // }

  final WebService _webService = WebService();

  bool dataDidSet = false;
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

    if (!dataDidSet) {
      Future.wait([
        _webService.requestProductList(ProductType.men),
        _webService.requestProductList(ProductType.women),
        _webService.requestProductList(ProductType.accessories),
        // _getBatteryLevel()
      ]).then((List responses) {
        setState(() {
          _menProductList = responses[0];
          _womenProductList = responses[1];
          _accessoriesProductList = responses[2];

          // _batteryLevel = responses[3];

          dataDidSet = true;
        });
      }).catchError((e) {
        print('Error -> $e');
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        appBar: AppBar(),
        theme: theme,
        isMapNavigationEnabled: true,
      ),
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
