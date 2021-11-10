import 'package:flutter/material.dart';
import 'package:untitled/screen/product_overview_screen.dart';

class MainStartPage extends StatelessWidget {
  const MainStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop App'
        ),
      ),
      body:   ProductsOverviewScreen(),
    );
  }
}
