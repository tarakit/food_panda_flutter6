import 'dart:io';

import 'package:flutter/material.dart';

import 'widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('2 St 24'),
            Text('Phnom Penh', style: TextStyle(fontSize: 12)),
          ],
        ),
        // leadingWidth: 35,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_basket))
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
