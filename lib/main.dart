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

    return Scaffold(
      appBar: AppBar(
        title: const Text("STYLiSH"),
        titleTextStyle:
            TextStyle(fontSize: 28.0, color: theme.appBarTheme.foregroundColor),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(20),
        children: [
          for (var imagePath in imageAssetPaths)
            Image.asset(imagePath, width: 500),
          // Card(
          //   color: theme.colorScheme.background,
          //   child: Padding(
          //     padding: const EdgeInsets.all(20),
          //     child: Text(text),
          //   ),
          // )
        ],
      ),
    );
  }
}
