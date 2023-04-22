import 'package:flutter/material.dart';
import 'package:stylish/productDetail.dart';
import 'package:stylish/productInfo.dart';
import 'package:stylish/webService.dart';
import 'elements.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productInfo});

  final ProductInfo productInfo;

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
                    theme: theme);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({
    super.key,
    required this.pageSize,
    required this.detail,
    required this.titleStyle,
    required this.infoStyle,
    required this.theme,
  });

  final Size pageSize;
  final ProductDetail detail;
  final TextStyle titleStyle;
  final TextStyle infoStyle;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: SizedBox(
        width: pageSize.width / 1.5,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 600.0,
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
