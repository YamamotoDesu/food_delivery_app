import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_drawer.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/pages/my_current_location.dart';
import 'package:food_delivery_app/pages/my_description_box.dart';
import 'package:food_delivery_app/pages/my_silver.app_bar.dart';
import 'package:food_delivery_app/components/my_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: FoodCategory.values.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: MyTabBar(
              tabController: _tabController,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),

                // my current location
                const MyCurrentLocation(),

                // description box
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                title: Text("First tab items $index"),
              ),
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                title: Text("Second tab items $index"),
              ),
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                title: Text("Third tab items $index"),
              ),
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                title: Text("Fourth tab items $index"),
              ),
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                title: Text("Fifth tab items $index"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
