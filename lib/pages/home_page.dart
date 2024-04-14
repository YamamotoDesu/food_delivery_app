import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_drawer.dart';
import 'package:food_delivery_app/components/my_food_tile.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/restraurant.dart';
import 'package:food_delivery_app/pages/food_page.dart';
import 'package:food_delivery_app/pages/my_current_location.dart';
import 'package:food_delivery_app/pages/my_description_box.dart';
import 'package:food_delivery_app/pages/my_silver.app_bar.dart';
import 'package:food_delivery_app/components/my_tab_bar.dart';
import 'package:provider/provider.dart';

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

  // sort out and return a list of food items that belong to the selected category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // return list of foods in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      // get food items in this category
      List<Food> categoruMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoruMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          // get indibidual food item
          final food = categoruMenu[index];

          // return food tile UI
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodPage(food: food),
              ),
            ),
          );
        },
      );
    }).toList();
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
        body: Consumer<Restaurant>(builder: (context, restaurant, child) {
          return TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(restaurant.menu),
          );
        }),
      ),
    );
  }
}
