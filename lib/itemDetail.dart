import 'package:flutter/material.dart';
import 'elements.dart';
import 'itemInfo.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({super.key, required this.itemInfo});

  final ItemInfo itemInfo;

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

    List<String> imageAssetPaths = [
      'assets/JupiterVenus_Luy_960.jpg',
      'assets/VenusJupiterSky_Tumino_1080_annotated.jpg',
      'assets/10_Days_of_Venus_and_Jupiter.jpeg'
    ];

    return Scaffold(
        appBar: MainAppBar(appBar: AppBar(), theme: theme),
        body: SingleChildScrollView(
            child: Center(
          child: SizedBox(
            width: pageSize.width / 2,
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
                          child: Image.asset(itemInfo.imagePath)),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
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
                              child: const Text(
                                  'Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Donec sed odio dui. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Aenean lacinia bibendum nulla sed consectetur. Nulla vitae elit libero, a pharetra augue. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam quis risus eget urna mollis ornare vel eu leo.',
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
                const Text(
                    'Cras mattis consectetur purus sit amet fermentum. Nullam id dolor id nibh ultricies vehicula ut id elit.'),
                for (var path in imageAssetPaths)
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Image.asset(path))
              ],
            ),
          ),
        )));
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
