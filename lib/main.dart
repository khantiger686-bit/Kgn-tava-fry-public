import 'package:flutter/material.dart';

void main() => runApp(KGNApp());

class KGNApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KGN Tawa Fry',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  List<Map> cart = [];
  List<Map> onHold = [];
  List<Map> closed = [];
  double todaySale = 0;

  final List<Map> menu = [
    {'name': 'Chicken Tawa Fry', 'price': 250},
    {'name': 'Mutton Tawa Fry', 'price': 350},
    {'name': 'Fish Tawa Fry', 'price': 300},
    {'name': 'Egg Tawa Fry', 'price': 150},
    {'name': 'Prawns Fry', 'price': 400},
  ];

  void addToCart(Map item) {
    setState(() => cart.add(item));
  }

  void setBill(double total) {
    setState(() {
      todaySale += total;
      closed.add({'total': total, 'items': List.from(cart)});
      cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      OrderTab(
        allItems: menu,
        cart: cart,
        onAdd: addToCart,
        onBill: setBill,
        todaySale: todaySale,
        closedOrders: closed,
        onHold: onHold,
      ),
      ReportsTab(closedOrders: closed, todaySale: todaySale),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('KGN Tawa Fry - ₹$todaySale')),
      body: tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Report'),
        ],
      ),
    );
  }
}

class OrderTab extends StatelessWidget {
  final List<Map> allItems;
  final List<Map> cart;
  final Function(Map) onAdd;
  final Function(double) onBill;
  final double todaySale;
  final List closedOrders;
  final List onHold;

  OrderTab({
    required this.allItems,
    required this.cart,
    required this.onAdd,
    required this.onBill,
    required this.todaySale,
    required this.closedOrders,
    required this.onHold,
  });

  @override
  Widget build(BuildContext context) {
    double total = cart.fold(0, (s, e) => s + (e['price'] as int));

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: allItems.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(allItems[i]['name']),
              subtitle: Text('₹${allItems[i]['price']}'),
              trailing: ElevatedButton(
                onPressed: () => onAdd(allItems[i]),
                child: Text('Add'),
              ),
            ),
          ),
        ),
        Divider(),
        Text('Cart: ${cart.length} items - Total ₹$total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: cart.isEmpty? null : () => onBill(total),
          child: Text('Generate Bill - ₹$total'),
          style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class ReportsTab extends StatelessWidget {
  final List closedOrders;
  final double todaySale;
  ReportsTab({required this.closedOrders, required this.todaySale});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Card(child: ListTile(title: Text('Today Sale'), trailing: Text('₹$todaySale', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)))),
        SizedBox(height: 10),
        Text('Closed Orders: ${closedOrders.length}', style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
