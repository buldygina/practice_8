import 'package:flutter/material.dart';
import 'package:practice_4/components/item_note.dart';
import 'package:practice_4/model/coffee.dart';
import 'package:practice_4/components/item_note.dart';


final List<Coffee> coffee = [
  Coffee(
      0,
      "Капучино",
      "Кофейный напиток итальянской кухни на основе эспрессо с добавлением в него подогретого до 65 градусов вспененного молока.",
      "https://media.leverans.ru/product_images_inactive/moscow/shou-restoran-lalalend/капучино.jpg",
      '120 ',
      '31343356'),
  Coffee(
      1,
      "Эспрессо",
      "Это популярный способ приготовления кофе, который отличается небольшим размером порции и характерными слоями: тёмной массой, покрытой более светлой пенкой, называемой сливками.",
      "https://i.pinimg.com/originals/46/fc/c2/46fcc2767aed83789f346dd310f29da3.jpg",
      '150 ',
      '25142265'),
  Coffee(
      2,
      "Латте",
      "Кофейный напиток на основе молока, представляющий собой трёхслойную смесь из молочной пены",
      "https://avatars.mds.yandex.net/i?id=11af79cd4db45ddba235a09c46a16926_l-5858967-images-thumbs&n=13",
      '130 ',
      '86551930'),
  Coffee(
      3,
      "Раф",
      "Это кофейный напиток, который готовится из эспрессо, сливок и сахара. Его можно назвать кофейно-молочным коктейлем или десертом, так как он очень вкусный, сладкий и нежный, в чём-то напоминает крем-брюле.",
      "https://scanformenu.ru/compiled/uploads/item_images/2f2d768c95a1a943a0d4d8b1b4b31992.jpg",
      '160 ',
      '42472068'),
  Coffee(
      4,
      "Американо",
      "Американо готовится из одной или двух порций эспрессо, в который добавляется от 30 до 470 мл горячей воды. В процессе приготовления горячую воду можно брать как из специальной эспрессомашины, так и из отдельного чайника или подогревателя. Для обогащения вкуса в американо могут добавляться сливки или молоко, разнообразные сиропы, корица, шоколад.",
      "https://lafoy.ru/photo_l/foto-2426-2.jpg",
      "100 ",
      "64816553"),
  Coffee(
      5,
      "Доппио",
      "Кофейный напиток, который готовится как двойная порция эспрессо с помощью кофейного фильтра или эспрессо-машины.",
      "https://avatars.mds.yandex.net/get-entity_search/4759071/952720682/S600xU_2x",
      "80 ",
      "43223687"),
  Coffee(
      6,
      "Аффогато",
      "Итальянский кофейный десерт. Его готовят так: шарик джелато (молочного мороженого) заливают чашечкой горячего эспрессо (30 мл). Бариста часто экспериментируют с ингредиентами и добавляют коньяк, ликёр или сироп. В качестве топпинга используют горький шоколад, какао-порошок, орехи, ягоды, мёд.",
      "https://avatars.mds.yandex.net/get-entity_search/1528499/952453330/S600xU_2x",
      "200 ",
      "41337060"),
  Coffee(
      7,
      "Венский кофе",
      "Это сочетание крепкого чёрного кофе и пенки из взбитых сливок. Последняя аккуратно размещается на поверхности кофе без размешивания.",
      "https://cafecentral.wien/wp-content/uploads/einspaenner_cafecentral.jpg",
      "230 ",
      "84544447"),
  Coffee(
      8,
      "Моккачино",
      "Это кофейный напиток, который напоминает капучино или латте, но с добавлением шоколадного соуса.",
      "https://i.pinimg.com/736x/03/d9/d2/03d9d27010057294eded352af161340f.jpg",
      "190 ",
      "89370190"),
  Coffee(
      9,
      "Бомбон",
      "Он состоит из эспрессо и сгущённого молока. Этот напиток прекрасно подойдёт на завтрак и зарядит бодростью и хорошим настроением на целый день.",
      "https://lafoy.ru/photo_l/foto-2426-19.jpg",
      "175 ",
      "59247291")
];

class HomePage extends StatefulWidget {
  final Function(Coffee) onFavouriteToggle;
  final List<Coffee> favouriteCoffee;

  const HomePage({super.key, required this.onFavouriteToggle, required this.favouriteCoffee});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty && cost.isNotEmpty && article.isNotEmpty) {
                  setState(() {
                    coffee.add(
                      Coffee(
                        coffee.length,
                        title,
                        description,
                        imageUrl,
                        cost,
                        article,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кофе'),
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
            return Dismissible(
              key: Key(coffeeItem.id.toString()),
              onDismissed: (direction) {
                setState(() {
                  coffee.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${coffeeItem.title} был удален')),
                );
              },
              background: Container(color: Colors.red),
              child: ItemNote(
                coffee: coffeeItem,
                isFavourite: isFavourite,
                  onFavouriteToggle: () => widget.onFavouriteToggle(coffeeItem)
              ),
            );
          },
        )
          : const Center(child: Text('Нет доступных напитков')),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 80.0,
          height: 80.0,
          child: FloatingActionButton(
            onPressed: () {
              _addNewNoteDialog(context);
            },
            backgroundColor: Colors.white.withOpacity(0.8),
            foregroundColor: Colors.white,
            splashColor: Colors.white60,
            elevation: 10.0,
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