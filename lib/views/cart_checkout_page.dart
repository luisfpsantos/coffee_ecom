import 'package:coffe_ecom/main.dart';
import 'package:coffe_ecom/models/cart_model.dart';
import 'package:coffe_ecom/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartCheckoutPage extends StatefulWidget {
  const CartCheckoutPage({super.key});

  @override
  State<CartCheckoutPage> createState() => _CartCheckoutPageState();
}

class _CartCheckoutPageState extends State<CartCheckoutPage> {
  Map<String, List<CartModel>> groupByName(List<CartModel> cartCoffes) {
    Map<String, List<CartModel>> result = {};

    for (var item in cartCoffes) {
      if (!result.containsKey(item.coffe.title)) {
        result[item.coffe.title] = [];
      }
      result[item.coffe.title]!.add(item);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      appBarTitle: const Text(
        'Meu carrinho',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      body: ListenableBuilder(
        listenable: cartController,
        builder: (context, child) {
          final carts = groupByName(cartController.cartCoffes);
          if (cartController.getCartTotalItems() == 0) {
            return const Center(
              child: Text(
                'Seu carrinho está vazio!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: carts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, i) {
                      final title = carts.keys.elementAt(i);
                      final items = carts[title]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ...items.map(
                            (item) => Container(
                              height: 120,
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 100,
                                        child: Image.asset(item.coffe.imagePath),
                                      ),
                                      Text(
                                        item.coffe.size.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => cartController.removeCoffeFromCart(item),
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => cartController.addCoffeToCart(item.coffe),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Total',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'R\$: ${(item.quantity * item.coffe.price).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total dos itens: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'R\$ ${cartController.getCartTotalValue().toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          context.push('/payment');
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff8C4D21),
                          fixedSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Continuar para o pagamento',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
