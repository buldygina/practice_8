import 'package:flutter/material.dart';
import 'package:practice_8/api_service.dart';
import 'package:practice_8/components/item_note.dart';
import 'package:practice_8/model/coffee.dart';
import 'package:practice_8/pages/basket_page.dart';
import 'package:practice_8/model/cart_item.dart';
import 'package:practice_8/api_service.dart';


class HomePage extends StatefulWidget {
  final Function(Coffee) onFavouriteToggle;
  final List<Coffee> favouriteCoffee;

  const HomePage({super.key, required this.onFavouriteToggle, required this.favouriteCoffee});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CartItem> cart = [];
  List<dynamic> coffee = [];
  final ApiService apiService = ApiService();

  void addToCart(Coffee coffee) {
    setState(() {
      final cartItemIndex = cart.indexWhere((item) => item.coffee.id == coffee.id);

      if (cartItemIndex != -1) {
        cart[cartItemIndex].quantity++;
      } else {
        cart.add(CartItem(coffee: coffee, quantity: 1));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${coffee.title} добавлен в корзину'),)
    );
  }
  Future<void> _addNewNoteDialog(BuildContext context) async {
    String title = '';
    String description = '';
    String imageUrl = '';
    String cost = '';
    String article = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить новый напиток'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Название'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Описание'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Картинка'),
                onChanged: (value){
                  imageUrl = value;
                }
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Цена'),
                onChanged: (value) {
                  cost = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Артикул'),
                onChanged: (value) {
                  article = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Добавить'),
              onPressed: () async {
                if (title.isNotEmpty && description.isNotEmpty && cost.isNotEmpty && article.isNotEmpty) {
                  Coffee newCoffee = Coffee(
                    coffee.length,
                    title,
                    description,
                    imageUrl,
                    cost,
                    article,
                  );
                  try{
                    Coffee createdCoffee = await apiService.createCoffee(newCoffee);
                  setState(() {
                    coffee.add(createdCoffee);
                  });
                  Navigator.of(context).pop();
                } catch(error){
                 print('Ошибка при добавлении кофе: $error');
                  }
                } else{
                  print('Пожалуйста, заполните все поля.');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchCoffees() async {
    final response = await apiService.getCoffees();
    if (response.isNotEmpty) coffee = response;
  }

  @override
  void initState() {
    super.initState();
    fetchCoffees();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кофе'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BasketPage(cart: cart)),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${cart.fold<int>(0, (previousValue, item) => previousValue + item.quantity)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        coffee.isNotEmpty
        ?GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: coffee.length,
          itemBuilder: (BuildContext context, int index) {
            final Coffee coffeeItem = coffee[index];
            final isFavourite = widget.favouriteCoffee.contains(coffeeItem);
            final DismissDirection dismissDirection =
            index % 2 == 0 ? DismissDirection.endToStart : DismissDirection.startToEnd;
            return Dismissible(
              key: Key(coffeeItem.id.toString()),
              direction: dismissDirection,
              onDismissed: (direction) {
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          coffee.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${coffeeItem.title} был удален')),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              child: ItemNote(
                coffee: coffeeItem,
                isFavourite: isFavourite,
                  onFavouriteToggle: () => widget.onFavouriteToggle(coffeeItem),
                onAddToCart: () => addToCart(coffeeItem),
              ),
            );
          },
        )
          : const Center(child: Text('Нет доступных напитков')),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: FloatingActionButton(
            onPressed: () {
              _addNewNoteDialog(context);
            },
            child: const Icon(
              Icons.add,
              size: 40.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}