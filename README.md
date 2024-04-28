# food_delivery_app
https://www.youtube.com/watch?v=rHIFJo4IbOE


### UI

| Login| List | 
| :-------------------------:|:-------------------------:|
| <img width="300" alt="image" src="https://github.com/YamamotoDesu/food_delivery_app/assets/47273077/bd899961-68fd-43ea-8bd5-9427c33cd9ee">|<img width="300" alt="image" src="https://github.com/YamamotoDesu/food_delivery_app/assets/47273077/00a8e070-42e9-4469-a475-2ae2f771c379"> |

| Add | Cart | 
| :-------------------------:|:-------------------------:|
|<img width="300" alt="image" src="https://github.com/YamamotoDesu/food_delivery_app/assets/47273077/7462780b-88d1-41ef-b534-91ba19398e47"> | <img width="300" alt="image" src="https://github.com/YamamotoDesu/food_delivery_app/assets/47273077/a2a91e77-f2bf-40d0-a578-01b3cea9b034"> | <img width="300" alt="image" src="https://github.com/YamamotoDesu/food_delivery_app/assets/47273077/97ac44f5-9b7c-49a3-b316-96476353898a">|

| Checkout |
| :-------------------------:|
|<img width="300" alt="image" src="https://github.com/YamamotoDesu/food_delivery_app/assets/47273077/9ced7626-f9ee-40f9-80fb-3303278a811f">|

<details>
<summary>MyTabBar</summary>


<img width="300" alt="image" src="https://github.com/YamamotoDesu/food_delivery_app/assets/47273077/49c7d3c1-2450-4c2a-8c4a-10b471cbcab1">

MyTabBar
```dart
class MyTabBar extends StatelessWidget {
  final TabController tabController;

  const MyTabBar({
    super.key,
    required this.tabController,
  });

  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values
        .map(
          (category) => Tab(
            child: Text(
              category.toString().split('.').last,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs: _buildCategoryTabs(),
      ),
    );
  }
}

```

HomePage
```dart
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
```

## Using Provider

```dart
void main() {
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => ThemeProvider(),
    //   child: const MyApp(),
    // ),
    MultiProvider(
      providers: [
        // theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        // restaurant provider
        ChangeNotifierProvider(create: (context) => Restaurant()),
      ],
      child: const MyApp(),
    ),
  );
}
```

restraurant.dart
```dart
class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // burgers
    Food(
      name: "Classic Cheeseburger",
      description:
          "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle.",
      imagePath: "lib/images/burgers/cheese_burger.png",
      price: 8.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.49),
        Addon(name: "Avocado", price: 1.99),
      ],
    ),
  ```

home_page.dart
```dart
  // sort out and return a list of food items that belong to the selected category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // return list of foods in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoruMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoruMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categoruMenu[index].name),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
///---------------------------------------/////
        body: Consumer<Restaurant>(builder: (context, restaurant, child) {
          return TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(restaurant.menu),
          );
        }),
      ),
    );
```

</details>



