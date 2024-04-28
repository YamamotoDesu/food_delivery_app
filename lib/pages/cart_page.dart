import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/models/restraurant.dart';
import 'package:food_delivery_app/pages/payent_page.dart';
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
          title: const Text('Cart'),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Are you sure you want to clear the cart?"),
                    actions: [
                      // cancel
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),

                      // clear cart
                      TextButton(
                        onPressed: () {
                          restaurant.clearCart();
                          Navigator.pop(context);
                        },
                        child: const Text("Clear Cart"),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
        body: Column(
          children: [
            // cart items
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty
                      ? const Expanded(
                          child: Center(child: Text("Cart is empty")))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: userCart.length,
                            itemBuilder: ((context, index) {
                              // get individual food item
                              final cartItem = userCart[index];
                              // return cart tile UI
                              return MyCartTile(cartItem: cartItem);
                            }),
                          ),
                        )
                ],
              ),
            ),

            // button to pay
            MyButton(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentPage(),
                ),
              ),
              text: "Go to checkout",
            ),

            const SizedBox(height: 25),
          ],
        ),
      );
    });
  }
}
