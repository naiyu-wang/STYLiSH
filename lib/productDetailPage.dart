import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish/productDetail.dart';
import 'package:stylish/productInfo.dart';
import 'package:stylish/webService.dart';
import 'elements.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key, required this.productInfo});

  final ProductInfo productInfo;

  static const platform = MethodChannel('stylish.flutter/productDetailPage');

  String _pruchaseResult = 'Unknown Result';

  Future<String> _getPurchaseResult() async {
    String pResult;
    try {
      final String result = await platform.invokeMethod('getPurchaseResult');
      pResult = 'Purchase Result is $result.';
    } on PlatformException catch (e) {
      pResult = "Failed to get result: '${e.message}'.";
    }
    return pResult;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var pageSize = MediaQuery.of(context).size;
    var titleStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
    );
    var infoStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    return Scaffold(
        appBar: MainAppBar(appBar: AppBar(), theme: theme),
        body: FutureBuilder<ProductDetail>(
            future: WebService().requestProductDetail(productInfo.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                ProductDetail detail = snapshot.data!;
                return ProductDetailView(
                    pageSize: pageSize,
                    detail: detail,
                    titleStyle: titleStyle,
                    infoStyle: infoStyle,
                    theme: theme,
                    buttonAction: _getPurchaseResult());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView(
      {super.key,
      required this.pageSize,
      required this.detail,
      required this.titleStyle,
      required this.infoStyle,
      required this.theme,
      required this.buttonAction});

  final Size pageSize;
  final ProductDetail detail;
  final TextStyle titleStyle;
  final TextStyle infoStyle;
  final ThemeData theme;
  final Future<String> buttonAction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double givenWidth = pageSize.width / 1.5;
      double givenHeight = givenWidth / 1.5;
      if (constraints.maxWidth < 500) {
        givenWidth = pageSize.width / 2;
        givenHeight = givenWidth / 2;
      }
      return SingleChildScrollView(
          child: Center(
        child: SizedBox(
          width: givenWidth,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: givenHeight,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: double.infinity,
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: detail.mainImagePath,
                          errorWidget: ((context, url, error) =>
                              const Icon(Icons.error)),
                        )),
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(detail.title, style: titleStyle),
                          Text(DateTime.now().toString(), style: infoStyle),
                          Text(
                            'NT\$${detail.price}',
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
                              theme: theme),
                          const SizedBox(
                            width: double.infinity,
                            height: 5.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: FilledButton(
                                onPressed: () {
                                  print('button pressed');
                                  buttonAction;
                                },
                                style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0))),
                                child: const Text('Please Select Size')),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5.0),
                            child: Text(
                                '${detail.note}\n${detail.texture}\n${detail.description}\n${detail.wash}\n${detail.place}',
                                textAlign: TextAlign.left),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: 1.0,
                  color: theme.colorScheme.primary),
              Text(detail.story),
              for (var path in detail.images)
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      imageUrl: path,
                      errorWidget: ((context, url, error) =>
                          const Icon(Icons.error)),
                    ))
            ],
          ),
        ),
      ));
    });
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
