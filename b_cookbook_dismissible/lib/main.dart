import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final items = [
    'Arroz',
    'Feijão',
    'Leite',
    'Café',
    'Pão',
    'Ovos',
    'Banana',
    'Macarrão',
    'Queijo',
    'Detergente',
  ];
  final controller = TextEditingController();
  int comprados = 0;

  void adicionarItem() {
    final texto = controller.text.trim();
    if (texto.isEmpty || items.contains(texto)) return;
    setState(() {
      items.add(texto);
    });
    controller.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Lista de Compras (${items.length})')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(hintText: 'Novo item'),
                      onSubmitted: (_) => adicionarItem(),
                    ),
                  ),
                  IconButton(
                    onPressed: adicionarItem,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Text('Comprados: $comprados'),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Dismissible(
                    key: Key(item),
                    onDismissed: (direction) {
                      final comprou = direction == DismissDirection.startToEnd;
                      setState(() {
                        items.removeAt(index);
                        if (comprou) comprados++;
                      });

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            comprou ? '$item comprado' : '$item removido',
                          ),
                          action: SnackBarAction(
                            label: 'Desfazer',
                            onPressed: () {
                              setState(() {
                                items.insert(index, item);
                                if (comprou) comprados--;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.check, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: Text(item),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
