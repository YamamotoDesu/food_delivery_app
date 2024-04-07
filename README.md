# food_delivery_app
https://www.youtube.com/watch?v=rHIFJo4IbOE



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
