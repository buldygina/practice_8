import 'package:flutter/material.dart';
import 'package:practice_5/model/cart_item.dart';

class BasketPage extends StatefulWidget {
  final List<CartItem> cart;

  const BasketPage({super.key, required this.cart});

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  int calculateTotalPrice() {
    int total = 0;
    for (var item in widget.cart) {
      total += int.parse(item.coffee.cost) * item.quantity;
    }
    return total;
  }

  void increaseQuantity(int index) {
    setState(() {
      widget.cart[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (widget.cart[index].quantity > 1) {
        widget.cart[index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = calculateTotalPrice();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: widget.cart.isNotEmpty
          ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cart[index];
                return ListTile(
                  leading: Image.network(cartItem.coffee.imageUrl, width: 90, height: 120, fit: BoxFit.cover),
                  title: Text(cartItem.coffee.title),
                  subtitle: Text('${cartItem.quantity} x ${cartItem.coffee.cost} руб.'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => decreaseQuantity(index),
                      ),
                      Text(cartItem.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => increaseQuantity(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Покупка успешно совершена!'))
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: const Color.fromARGB(255, 187, 164, 132),
                foregroundColor: Colors.white,
              ),
              child: Text('Купить за $totalPrice руб.'),
            ),
          ),
        ],
      )
          : const Center(child: Text('Ваша корзина пуста')),
    );
  }
}
