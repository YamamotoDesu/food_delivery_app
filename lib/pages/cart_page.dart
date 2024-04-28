import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/models/restraurant.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (contex, restaurant, child) {
      // cart
      final userCart = restaurant.cart;

      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: userCart.length,
                itemBuilder: ((context, index) {
                  // get individual food item
                  final cartItem = userCart[index];

                  print("Cart item: ");
                  print(cartItem.food.name);
                  print("Addons: ");
                  print(cartItem.food.availableAddons.length);

                  cartItem.food.availableAddons.map(
                    (e) {
                      print("Addons:");
                      print(e);
                    },
                  );

                  // return cart tile UI
                  return MyCartTile(cartItem: cartItem);
                }),
              ),
            )
          ],
        ),
      );
    });
  }
}
